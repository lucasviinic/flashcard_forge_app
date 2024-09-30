import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flashcard_forge_app/models/FlashcardModel.dart';
import 'package:flashcard_forge_app/models/TopicModel.dart';
import 'package:flashcard_forge_app/screens/study_session_screen.dart';
import 'package:flashcard_forge_app/utils/constants.dart';
import 'package:flashcard_forge_app/widgets/DrawerMenu.dart';
import 'package:flashcard_forge_app/widgets/FlashcardForm.dart';
import 'package:flashcard_forge_app/widgets/FlashcardPreview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FlashcardScreen extends StatefulWidget {
  const FlashcardScreen({super.key, this.topic});

  final TopicModel? topic;

  @override
  State<FlashcardScreen> createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  void _removeFlashcard(FlashcardModel flashcard) {
    setState(() {
      widget.topic!.flashcards.remove(flashcard);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<FlashcardModel> flashcards = widget.topic!.flashcards;

    return Scaffold(
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
          children: [
            Expanded(
              child: Text(
                widget.topic!.topicName,
                style: TextStyle(fontSize: 20, color: Theme.of(context).textTheme.bodyMedium!.color),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            )
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: widget.topic!.flashcards.isNotEmpty
              ? () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return StudySession(flashcardList: widget.topic!.flashcards);
                    },
                  );
                }
              : null,
            icon: Icon(
              Icons.play_arrow_rounded,
              size: 40,
              color: widget.topic!.flashcards.isNotEmpty ? Theme.of(context).textTheme.bodyMedium!.color : Colors.white.withOpacity(0.5),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: IconButton(
              icon: Icon(Icons.upload_file_rounded, size: 30, color: Theme.of(context).textTheme.bodyMedium!.color),
              onPressed: () async {
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['pdf']
                );

                if (result != null) {
                  File file = File(result.files.single.path!);
                  print(file);
                }
              },
              highlightColor: Colors.transparent
            ),
          ),
        ],
      ),
      drawer: const DrawerMenu(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "Score: 7/20",
                      style: TextStyle(fontSize: 14, color: Styles.redHard),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "Time: 00:15:20",
                      style: TextStyle(fontSize: 14, color: Styles.blueNeutral),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      "4",
                      style: TextStyle(fontSize: 14, color: Styles.greenEasy),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      "10",
                      style: TextStyle(fontSize: 14, color: Styles.blueNeutral),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      "6",
                      style: TextStyle(fontSize: 14, color: Styles.redHard),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Visibility(
                    visible: widget.topic!.flashcards!.isNotEmpty,
                    replacement: SizedBox(
                      height: MediaQuery.of(context).size.height * .8,
                      width: MediaQuery.of(context).size.width * .85,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: SvgPicture.asset(
                              "assets/images/no-content.svg",
                              width: MediaQuery.of(context).size.width * .4,
                            ),
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
                          )
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: flashcards.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return FlashcardPreview(
                            flashcard: widget.topic!.flashcards[index],
                            onDelete: _removeFlashcard,
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
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
                widget.topic!.flashcards.add(flashcardObject);
              });
            }
          },
          tooltip: 'Create new subject',
          child: Icon(Icons.add, color: Theme.of(context).textTheme.bodyMedium!.color),
        ),
      ),
    );
  }
}
