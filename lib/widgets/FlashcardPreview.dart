import 'package:flashcard_forge_app/models/FlashcardModel.dart';
import 'package:flashcard_forge_app/utils/constants.dart';
import 'package:flashcard_forge_app/widgets/FlashcardForm.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

class FlashcardPreview extends StatefulWidget {
  final FlashcardModel flashcard;

  const FlashcardPreview(this.flashcard, {super.key});

  @override
  State<FlashcardPreview> createState() => _FlashcardPreviewState();
}

class _FlashcardPreviewState extends State<FlashcardPreview> {
  FlashcardModel? flashcard;

  String _getDisplayText(String text) {
    if (text.length > 30 && text.length < 40) {
      return "${text.substring(0, 27)}...";
    } else if (text.length >= 50) {
      return "${text.substring(0, 47)}...";
    } else {
      return text;
    }
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
                        flashcard!.question!,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: flashcard!.question!.length >= 50 ? 17 : 20),
                      ),
                    )),
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
                        flashcard!.answer!,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: flashcard!.answer!.length >= 50 ? 17 : 20),
                      ),
                    )),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> showDeleteFlashcardDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.secondaryColor,
          title: Icon(Icons.warning_amber_rounded, color: Colors.red[600], size: 50),
          content: const Text(
            "Do you really want to delete this flashcard?", textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Yes', style: TextStyle(fontSize: 16)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('No', style: TextStyle(fontSize: 16)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
        ]
      );
    });
  }

  @override
  void initState() {
    super.initState();
    flashcard = widget.flashcard;
  }

  @override
  Widget build(BuildContext context) {
    String displayText = _getDisplayText(flashcard!.question!);

    return Card(
      elevation: 4.0,
      color: AppColors.secondaryColor,
      child: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () async {
                    final flashcardObject = await showDialog<FlashcardModel>(
                      context: context,
                      builder: (BuildContext context) {
                        return FlashcardForm(flashcard: flashcard);
                      },
                    );

                    if (flashcardObject != null) {
                      setState(() {
                        flashcard = flashcardObject;
                      });
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
                    child: Icon(Icons.edit, color: Colors.blue),
                  )
                ),
                GestureDetector(
                  onTap: () => showDeleteFlashcardDialog(context),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
                    child: Icon(Icons.delete, color: Colors.red[700]),
                  )
                )
              ],
            ),
            GestureDetector(
              onTap: () => showFlashcardDialog(context),
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