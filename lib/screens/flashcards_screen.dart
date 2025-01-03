import 'dart:async';

import 'package:flashcard_forge_app/models/FlashcardModel.dart';
import 'package:flashcard_forge_app/models/ResponseModel.dart';
import 'package:flashcard_forge_app/models/TopicModel.dart';
import 'package:flashcard_forge_app/screens/study_session_screen.dart';
import 'package:flashcard_forge_app/services/repositories/flashcard_repo.dart';
import 'package:flashcard_forge_app/widgets/DrawerMenu.dart';
import 'package:flashcard_forge_app/widgets/FlashcardForm.dart';
import 'package:flashcard_forge_app/widgets/FlashcardPreview.dart';
import 'package:flashcard_forge_app/widgets/UploadFileModal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FlashcardScreen extends StatefulWidget {
  const FlashcardScreen({super.key, this.topic});

  final TopicModel? topic;

  @override
  State<FlashcardScreen> createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  final scrollController = ScrollController();
  late StreamSubscription<bool> keyboardSubscription;

  bool isGeneratingFlashcards = false;
  bool isSearching = false;
  int offset = 0;
  int limit = 20;
  bool hasMore = true;
  bool isLoadingMore = false;
  int deleteCount = 0;
  bool isLoading = false;
  bool creatingSFlashcard = false;
  List<FlashcardModel> flashcards = [];
  int? flashcardsCount = 0;

  bool isFlashcardDuplicate(FlashcardModel newFlashcard) {
    return flashcards.any((flashcard) => flashcard.id == newFlashcard.id);
  }

  void setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  Future<void> getFlashcards({bool requestMore = false, bool isRefresh = false, String searchTerm = ""}) async {
    if (!isRefresh && (isLoading || isLoadingMore || !hasMore)) return;

    if (isRefresh) {
      setState(() {
        flashcards.clear();
        offset = 0;
        limit = 20;
        hasMore = true;
      });
      setLoading(true);
    } else if (requestMore) {
      setState(() {
        isLoadingMore = true;
      });
    } else {
      setLoading(true);
    }

    try {
      FlashcardListResponseModel? response = await FlashcardRepository()
          .fetchFlashcards(widget.topic!.id!, offset: offset, limit: limit, searchTerm: searchTerm);
      List<FlashcardModel>? newFlashcards = response?.flashcards;

      setState(() => flashcardsCount = response?.count);

      if (newFlashcards!.isNotEmpty) {
        setState(() {
          flashcards.addAll(newFlashcards
              .where((newFlashcard) => !isFlashcardDuplicate(newFlashcard))
              .toList());
          offset += limit;
        });

        if (newFlashcards.length < limit) {
          setState(() => hasMore = false);
        }
      } else {
        setState(() => hasMore = false);
      }
    } catch (e) {
      //se acontecer um erro lanço um modal aqui
    } finally {
      setLoading(false);
      setState(() {
        isLoadingMore = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getFlashcards();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: Icon(
                    Icons.menu_rounded,
                    color: Theme.of(context).textTheme.bodyMedium!.color,
                    size: 30,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              },
            ),
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.start, // Alinha os elementos no início do eixo cruzado (vertical).
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // Alinha os elementos no início do eixo cruzado (horizontal dentro da coluna).
                    mainAxisAlignment: MainAxisAlignment.start, // Alinha os elementos no início do eixo principal (vertical dentro da coluna).
                    children: [
                      Text(
                        widget.topic!.topicName,
                        style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).textTheme.bodyMedium!.color,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 1),
                      Text(
                        "$flashcardsCount flashcards",
                        style: TextStyle(
                          fontSize: 12.5,
                          color: Theme.of(context).textTheme.bodyMedium!.color,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: flashcards.isNotEmpty
                    ? () async {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return StudySession(topic: widget.topic!);
                          },
                        );
                      }
                    : null,
                icon: Icon(
                  Icons.play_arrow_rounded,
                  size: 40,
                  color: flashcards.isNotEmpty
                      ? Theme.of(context).textTheme.bodyMedium!.color
                      : Colors.grey[350],
                ),
              ),
              IconButton(
                  icon: SvgPicture.asset(
                    'assets/images/upload-to-ia-generate.svg',
                    width: 30,
                    height: 30,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return UploadFileModal(
                          topic: widget.topic!,
                          onGeneratingFlashcardsChanged: (isGenerating) {
                            setState(() => isGeneratingFlashcards = isGenerating);
                          },
                          onFlashcardsGenerated: (newFlashcards) {
                            setState(() {
                              flashcards.insertAll(0, newFlashcards);
                            });
                          },
                        );
                      },
                    );
                  },
                  highlightColor: Colors.transparent),
            ],
          ),
          drawer: const DrawerMenu(),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Expanded(
                  child: Visibility(
                    visible: !isLoading && flashcards.isNotEmpty,
                    replacement: Center(
                      child: Visibility(
                        visible: isLoading,
                        replacement: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/images/no-content.svg",
                              width: MediaQuery.of(context).size.width * .4,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                "No flashcards yet",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Theme.of(context).textTheme.bodyMedium!.color,
                                ),
                              ),
                            ),
                          ],
                        ),
                        child: SizedBox(
                          width: 60,
                          height: 60,
                          child: CircularProgressIndicator(
                            color: Theme.of(context).textTheme.bodyMedium!.color,
                          ),
                        ),
                      ),
                    ),
                    child: NotificationListener<ScrollEndNotification>(
                      onNotification: (notification) {
                        if (notification.metrics.pixels == notification.metrics.maxScrollExtent) {
                          if (!isLoadingMore) {
                            getFlashcards(requestMore: true);
                          }
                        }
                        return false;
                      },
                      child: RefreshIndicator(
                        color: Colors.black,
                        backgroundColor: Colors.white,
                        onRefresh: () async {
                          getFlashcards(isRefresh: true);
                        },
                        child: GridView.builder(
                          controller: scrollController,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          itemCount: isLoadingMore ? flashcards.length + 1 : flashcards.length,
                          itemBuilder: (context, index) {
                            if (index == flashcards.length) {
                              return isLoadingMore
                                  ? Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: SizedBox(
                                          width: 30,
                                          height: 30,
                                          child: CircularProgressIndicator(
                                            color: Theme.of(context).textTheme.bodyMedium!.color,
                                          ),
                                        ),
                                      ),
                                    )
                                  : const SizedBox.shrink();
                            }
        
                            final flashcard = flashcards[index];
        
                            return FlashcardPreview(
                              key: ValueKey(flashcard.id),
                              flashcard: flashcard,
                              onDelete: (flashcard) {
                                setState(() {
                                  flashcards.removeWhere((f) => f.id == flashcard.id);
                                });
                              },
                            );
                          },
                        )
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          floatingActionButton: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              //gradient: Styles.linearGradient,
            ),
            child: FloatingActionButton(
              backgroundColor: Theme.of(context).floatingActionButtonTheme.backgroundColor,
              onPressed: () async {
                final flashcardObject = await showDialog<FlashcardModel>(
                  context: context,
                  builder: (BuildContext context) {
                    return FlashcardForm(
                      subjectId: widget.topic!.subjectId,
                      topicId: widget.topic!.id,
                    );
                  },
                );
        
                if (flashcardObject != null) {
                  setState(() {
                    flashcards.add(flashcardObject);
                  });
                }
              },
              tooltip: 'Create new subject',
              child: Icon(Icons.add,
                  color: Theme.of(context).textTheme.bodyMedium!.color),
            ),
          ),
        ),
        Visibility(
          visible: isGeneratingFlashcards,
          child: Container(
            color: const Color.fromARGB(90, 0, 0, 0),
            child: Center(
              child: SizedBox(
                height: 40,
                width: 40,
                child: CircularProgressIndicator(
                  color: Theme.of(context).textTheme.bodyMedium!.color
                )
              ),
            ),
          )
        )
      ],
    );
  }
}
