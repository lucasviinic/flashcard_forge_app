import 'package:flashcard_forge_app/models/FlashcardModel.dart';
import 'package:flashcard_forge_app/utils/constants.dart';
import 'package:flutter/material.dart';

class FlashcardForm extends StatefulWidget {
  final FlashcardModel? flashcard;

  const FlashcardForm({super.key, this.flashcard});

  @override
  State<FlashcardForm> createState() => _FlashcardFormState();
}

class _FlashcardFormState extends State<FlashcardForm> {
  final TextEditingController questionController = TextEditingController();
  final TextEditingController answerController = TextEditingController();
  List<bool> isSelected = [false, false, false];

    @override
  void initState() {
    super.initState();
    questionController.text = widget.flashcard?.question ?? '';
    answerController.text = widget.flashcard?.answer ?? '';
  }

  @override
  void dispose() {
    questionController.dispose();
    answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.secondaryColor,
      title: Text(
        widget.flashcard != null ? "Edit flashcard" : "Create flashcard",
        style: const TextStyle(color: AppColors.whiteColor)
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Question:"),
            TextField(
              controller: questionController,
              decoration: const InputDecoration(labelText: 'Enter flashcard question'),
              keyboardType: TextInputType.multiline,
              maxLines: 3,
              style: const TextStyle(color: AppColors.whiteColor),
            ),
            const SizedBox(height: 10),
            const Text("Answer:"),
            TextField(
              controller: answerController,
              decoration: const InputDecoration(labelText: 'Enter flashcard answer'),
              keyboardType: TextInputType.multiline,
              maxLines: 3,
              style: const TextStyle(color: AppColors.whiteColor),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                GestureDetector(
                  onTap:() => setState(() {
                    isSelected.fillRange(0, isSelected.length, false);
                    isSelected[0] = true;
                  }),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected[0] ? AppColors.greenEasy : null,
                      border: Border.all(width: 1, color: AppColors.greenEasy),
                      borderRadius: BorderRadius.circular(50)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Text(
                        "Easy", 
                        style: TextStyle(
                          color: isSelected[0] ? AppColors.whiteColor : AppColors.greenEasy)
                        ),
                    ),
                  )
                ),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap:() => setState(() {
                    isSelected.fillRange(0, isSelected.length, false);
                    isSelected[1] = true;
                  }),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected[1] ? AppColors.blueNeutral : null,
                      border: Border.all(width: 1, color: AppColors.blueNeutral),
                      borderRadius: BorderRadius.circular(50)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Text(
                        "Medium", 
                        style: TextStyle(
                          color: isSelected[1] ? AppColors.whiteColor : AppColors.blueNeutral)
                        ),
                    ),
                  )
                ),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap:() => setState(() {
                    isSelected.fillRange(0, isSelected.length, false);
                    isSelected[2] = true;
                  }),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected[2] ? AppColors.redHard : null,
                      border: Border.all(width: 1, color: AppColors.redHard),
                      borderRadius: BorderRadius.circular(50)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Text(
                        "Hard", 
                        style: TextStyle(
                          color: isSelected[2] ? AppColors.whiteColor : AppColors.redHard)
                        ),
                    ),
                  )
                )
              ],
            )
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('Save'),
          onPressed: () {
            Navigator.of(context).pop(widget.flashcard);
          },
        ),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}