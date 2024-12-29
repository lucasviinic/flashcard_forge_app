import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flashcard_forge_app/models/FlashcardModel.dart';
import 'package:flashcard_forge_app/models/TopicModel.dart';
import 'package:flashcard_forge_app/services/repositories/flashcard_repo.dart';
import 'package:flashcard_forge_app/utils/constants.dart';
import 'package:flutter/material.dart';

class UploadFileModal extends StatefulWidget {
  final TopicModel topic;
  final Function(bool) onGeneratingFlashcardsChanged;
  final Function(List<FlashcardModel>) onFlashcardsGenerated;

  const UploadFileModal({
    super.key,
    required this.topic,
    required this.onGeneratingFlashcardsChanged,
    required this.onFlashcardsGenerated,
  });

  @override
  State<UploadFileModal> createState() => _UploadFileModalState();
}

class _UploadFileModalState extends State<UploadFileModal> {
  List<bool> isSelected = [true, false, false];
  final quantities = [5, 10, 15, 20];
  int selectedQuantityIndex = 0;

  void _pickFileAndGenerateFlashcards() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);

    if (result == null) return;

    File file = File(result.files.single.path!);

    widget.onGeneratingFlashcardsChanged(true);

    List<FlashcardModel>? newFlashcards = await FlashcardRepository().uploadFile(
      file,
      selectedQuantityIndex > -1 ? quantities[selectedQuantityIndex] : 5,
      isSelected.indexWhere((element) => element),
      widget.topic.subjectId,
      widget.topic.id!,
    );

    widget.onGeneratingFlashcardsChanged(false);

    if (newFlashcards.isNotEmpty) {
      widget.onFlashcardsGenerated(newFlashcards);
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nenhum flashcard foi adicionado.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> difficultyLevels = ["Easy", "Medium", "Hard"];
    List<Color> colors = [Styles.greenEasy, Styles.blueNeutral, Styles.redHard];

    return AlertDialog(
      backgroundColor: Theme.of(context).dialogTheme.backgroundColor,
      title: Text(
        "Upload a File",
        style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color, fontSize: 20)
      ),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Text(
                  "Difficulty",
                  style: TextStyle(fontSize: 16)
                ),
              ],
            ),
          ),
          Row(
            children: List.generate(difficultyLevels.length, (index) {
              return Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isSelected.fillRange(0, isSelected.length, false);
                        isSelected[index] = true;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected[index] ? colors[index] : null,
                        border: Border.all(width: 1, color: colors[index]),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Text(
                          difficultyLevels[index],
                          style: TextStyle(
                            color: isSelected[index] ? Colors.white : colors[index],
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (index < difficultyLevels.length - 1)
                    const SizedBox(width: 5),
                ],
              );
            }),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Text("Quantity", style: TextStyle(fontSize: 16))
              ],
            ),
          ),
          Row(
            children: List.generate(quantities.length, (index) {
              bool _isSelected = index == selectedQuantityIndex;
              return Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedQuantityIndex = _isSelected ? -1 : index;
                      });
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: _isSelected ? Colors.blue : null,
                        border: Border.all(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                      "${quantities[index]}",
                        style: TextStyle(
                          color: _isSelected ? Colors.white : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  if (index < quantities.length - 1) const SizedBox(width: 7),
                ],
              );
            })
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: _pickFileAndGenerateFlashcards,
            child: DottedBorder(
              borderType: BorderType.RRect,
              radius: const Radius.circular(8),
              dashPattern: [6, 3],
              color: Colors.grey,
              strokeWidth: 2,
              child: Container(
                width: MediaQuery.of(context).size.width * .6,
                height: 40,
                color: Colors.transparent,
                alignment: Alignment.center,
                child: const Text(
                  'Choose File',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}