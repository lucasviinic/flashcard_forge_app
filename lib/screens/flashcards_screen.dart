import 'package:flashcard_forge_app/models/FlashcardModel.dart';
import 'package:flashcard_forge_app/screens/study_session_screen.dart';
import 'package:flashcard_forge_app/services/mocks.dart';
import 'package:flashcard_forge_app/utils/constants.dart';
import 'package:flashcard_forge_app/widgets/FlashcardForm.dart';
import 'package:flashcard_forge_app/widgets/FlashcardPreview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FlashcardScreen extends StatefulWidget {
  const FlashcardScreen({super.key, this.flashcards, this.title});

  final String? title;
  final List<FlashcardModel>? flashcards;

  @override
  State<FlashcardScreen> createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.menu_rounded,
                color: AppColors.whiteColor,
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
            Text(
              widget.title!.length > 13 ? "${widget.title!.substring(0, 12)}..." : widget.title!,
              style: const TextStyle(color: AppColors.whiteColor),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context, 
                builder: (BuildContext context) {
                  return const StudySession();
                }
              );
            },
            icon: const Icon(Icons.play_arrow_rounded, size: 40, color: AppColors.whiteColor)
          ),
          const Padding(
            padding: EdgeInsets.all(10),
            child: Icon(Icons.upload_file_rounded, size: 30, color: AppColors.whiteColor),
          ),
        ],
      ),
      drawer: const Drawer(backgroundColor: AppColors.primaryColor),
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
                    child: Text("Score: 7/20", style: TextStyle(fontSize: 14, color: AppColors.redHard)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text("Time: 00:15:20", style: TextStyle(fontSize: 14, color: AppColors.blueNeutral)),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text("4", style: TextStyle(fontSize: 14, color: AppColors.greenEasy)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text("10", style: TextStyle(fontSize: 14, color: AppColors.blueNeutral)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text("6", style: TextStyle(fontSize: 14, color: AppColors.redHard)),
                  ),
                ],
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              itemCount: flashcardListMock.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemBuilder: (BuildContext context, int index) {
                return FlashcardPreview(flashcardListMock[index]);
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.secondaryColor,
        onPressed: () async {
          final flashcardObject = await showDialog<FlashcardModel>(
            context: context, 
            builder: (BuildContext context) {
              return const FlashcardForm();
            },
          );

          if (flashcardObject != null) {
            /* 
              1. TODO: Request to create flashcard
              2. TODO: Update list with return
            */
          }
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add, color: AppColors.whiteColor),
      ),
    );
  }
}
