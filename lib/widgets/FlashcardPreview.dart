import 'package:flashcard_forge_app/models/FlashcardModel.dart';
import 'package:flashcard_forge_app/utils/constants.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

class FlashcardPreview extends StatefulWidget {
  final FlashcardModel flashcard;

  const FlashcardPreview(this.flashcard, {super.key});

  @override
  State<FlashcardPreview> createState() => _FlashcardPreviewState();
}

class _FlashcardPreviewState extends State<FlashcardPreview> {
  final TextEditingController questionController = TextEditingController();
  final TextEditingController answerController = TextEditingController();

  List<bool> isSelected = [false, false, false];
  
  String _getDisplayText(String text) {
    if (text.length > 30 && text.length < 40) {
      return "${text.substring(0, 27)}...";
    } else if (text.length >= 50) {
      return "${text.substring(0, 47)}...";
    } else {
      return text;
    }
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (stfContext, stfSetState) {
          return AlertDialog(
            backgroundColor: AppColors.secondaryColor,
            title: const Text('Edit flashcard', style: TextStyle(color: AppColors.whiteColor)),
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
                        onTap:() => stfSetState(() {
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
                        onTap:() => stfSetState(() {
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
                        onTap:() => stfSetState(() {
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
                  Navigator.of(context).pop();
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
        },
      );
    });
  }

  Future<void> showFlashcardDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width * 0.8,
            child: FlipCard(
              fill: Fill.fillBack,
              direction: FlipDirection.HORIZONTAL,
              side: CardSide.FRONT,
              front: Container(
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 30),
                      child: Text("Question:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Text(
                          widget.flashcard.question,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: widget.flashcard.question.length >= 50 ? 17 : 20),
                        ),
                      )
                    ),
                  ],
                ),
              ),
              back: Container(
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 30),
                      child: Text("Answer:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Text(
                          widget.flashcard.answer,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: widget.flashcard.answer.length >= 50 ? 17 : 20),
                        ),
                      )
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }


  @override
  void initState() {
    super.initState();
    questionController.text = widget.flashcard.question;
    answerController.text = widget.flashcard.answer;
  }

  @override
  void dispose() {
    questionController.dispose();
    answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String displayText = _getDisplayText(widget.flashcard.question);

    return Card(
      elevation: 4.0,
      color: AppColors.secondaryColor,
      child: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () => _dialogBuilder(context),
                  icon: const Icon(Icons.edit, color: Colors.blue)
                ),
              ],
            ),
            GestureDetector(
              onTap:() => showFlashcardDialog(context),
              child: Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  child: Text(
                    displayText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: displayText.length >= 40 ? 15 : 20,
                      color: AppColors.whiteColor,
                    ),
                    maxLines: displayText.length >= 40 ? 4 : 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
