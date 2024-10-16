import 'package:flashcard_forge_app/models/FlashcardModel.dart';
import 'package:flashcard_forge_app/services/repositories/flashcard_repo.dart';
import 'package:flashcard_forge_app/utils/constants.dart';
import 'package:flutter/material.dart';

class FlashcardForm extends StatefulWidget {
  const FlashcardForm({super.key, this.subjectId, this.topicId, this.flashcard});

  final String? subjectId;
  final String? topicId;
  final FlashcardModel? flashcard;

  @override
  State<FlashcardForm> createState() => _FlashcardFormState();
}

class _FlashcardFormState extends State<FlashcardForm> {
  final TextEditingController questionController = TextEditingController();
  final TextEditingController answerController = TextEditingController();

  List<bool> isSelected = [false, false, false];
  FlashcardModel? flashcard = FlashcardModel();
  bool editing = false;

  Future<FlashcardModel?> createFlashcard(FlashcardModel flashcard) async {
    flashcard.subjectId = widget.subjectId!;
    flashcard.topicId =  widget.topicId!;
    try {
      FlashcardModel? flashcard_ = await FlashcardRepository().createFlashcard(flashcard);
      return flashcard_;
    } catch (error) {
      print("Erro ao criar o flashcard: $error");
      return null;
    }
  }

  Future<void> updateFlashcard(FlashcardModel flashcard) async {
    try {
     //await context.read<StudyProvider>().updateFlashcard(flashcard);
    } catch (error) {
      print("Erro ao editar flashcard");
      //Exibir modal
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.flashcard != null) {
      editing = true;
      flashcard = widget.flashcard;
      questionController.text = flashcard?.question ?? '';
      answerController.text = flashcard?.answer ?? '';
      if (flashcard!.difficulty != null && flashcard!.difficulty != -1) {
        isSelected[flashcard!.difficulty!] = true;
      }
    }
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
      backgroundColor: Theme.of(context).dialogTheme.backgroundColor,
      title: Text(
        widget.flashcard != null ? "Edit flashcard" : "Create flashcard",
        style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color)
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Question:", style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color)),
            TextField(
              controller: questionController,
              cursorColor: Theme.of(context).hintColor,
              style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color),
              decoration: InputDecoration(
                labelText: 'Enter flashcard question',
                hintStyle: TextStyle(color: Theme.of(context).hintColor),
                floatingLabelBehavior: FloatingLabelBehavior.never
              ),
              keyboardType: TextInputType.multiline,
              maxLines: 3,
            ),
            const SizedBox(height: 10),
            Text("Answer:", style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color)),
            TextField(
              controller: answerController,
              cursorColor: Theme.of(context).hintColor,
              style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color),
              decoration: InputDecoration(
                labelText: 'Enter flashcard answer',
                hintStyle: TextStyle(color: Theme.of(context).hintColor),
                floatingLabelBehavior: FloatingLabelBehavior.never
              ),
              keyboardType: TextInputType.multiline,
              maxLines: 3,
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
                      color: isSelected[0] ? Styles.greenEasy : null,
                      border: Border.all(width: 1, color: Styles.greenEasy),
                      borderRadius: BorderRadius.circular(50)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Text(
                        "Easy", 
                        style: TextStyle(
                          color: isSelected[0] ? Colors.white : Styles.greenEasy)
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
                      color: isSelected[1] ? Styles.blueNeutral : null,
                      border: Border.all(width: 1, color: Styles.blueNeutral),
                      borderRadius: BorderRadius.circular(50)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Text(
                        "Medium", 
                        style: TextStyle(
                          color: isSelected[1] ? Colors.white : Styles.blueNeutral)
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
                      color: isSelected[2] ? Styles.redHard : null,
                      border: Border.all(width: 1, color: Styles.redHard),
                      borderRadius: BorderRadius.circular(50)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Text(
                        "Hard", 
                        style: TextStyle(
                          color: isSelected[2] ? Colors.white : Styles.redHard)
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
          child: Text('Cancel', style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: Text(editing ? "Save" : "Create", style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color)),
          onPressed: () async {
            //
            setState(() {
              flashcard!.question = questionController.text;
              flashcard!.answer = answerController.text;
              flashcard!.difficulty = isSelected.indexOf(true);
              if (editing) {
                updateFlashcard(flashcard!);
              }
              else {
                createFlashcard(flashcard!).then((flashcard) => Navigator.of(context).pop(flashcard));
              }
            });
            //Navigator.of(context).pop(flashcard);
          },
        ),
      ],
    );
  }
}