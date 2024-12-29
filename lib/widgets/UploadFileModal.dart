import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flashcard_forge_app/models/FlashcardModel.dart';
import 'package:flashcard_forge_app/models/TopicModel.dart';
import 'package:flashcard_forge_app/services/repositories/flashcard_repo.dart';
import 'package:flashcard_forge_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
  File? file;
  bool isLoading = false;

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);

    if (result == null) return;

    setState(() => file = File(result.files.single.path!));
  }

  void generateFlashcards() async {
    setState(() => isLoading = true);
    List<FlashcardModel>? newFlashcards = await FlashcardRepository().uploadFile(
      file!,
      selectedQuantityIndex > -1 ? quantities[selectedQuantityIndex] : 5,
      isSelected.indexWhere((element) => element),
      widget.topic.subjectId,
      widget.topic.id!,
    );
    setState(() => isLoading = false);

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

    return PopScope(
      canPop: !isLoading,
      child: AlertDialog(
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
                        if (!isLoading) {
                          setState(() {
                            isSelected.fillRange(0, isSelected.length, false);
                            isSelected[index] = true;
                          });
                        }
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
                bool isSelected = index == selectedQuantityIndex;
                return Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (!isLoading) {
                          setState(() {
                            selectedQuantityIndex = isSelected ? -1 : index;
                          });
                        }
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.blue : null,
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                        "${quantities[index]}",
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.grey,
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
              onTap: () {
                if (!isLoading) file == null ? pickFile() : generateFlashcards();
              },
              child: DottedBorder(
                borderType: BorderType.RRect,
                radius: const Radius.circular(8),
                dashPattern: file == null ? [6, 3] : [1, 0],
                color: file == null ? Colors.grey : Colors.transparent,
                strokeWidth: file == null ? 2 : 2.5,
                child: Container(
                  width: MediaQuery.of(context).size.width * .6,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: file == null ? Colors.transparent : Colors.amber,
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: isLoading
                    ? const SizedBox(
                        width: 25,
                        height: 25,
                        child: CircularProgressIndicator(
                          color: Color.fromARGB(255, 12, 12, 12),
                        ),
                      )
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            file == null ? 'Choose File' : 'Generate',
                            style: TextStyle(
                              color: file == null ? Colors.grey : const Color.fromARGB(255, 12, 12, 12),
                              fontWeight: file == null ? null : FontWeight.w900,
                            ),
                          ),
                          const SizedBox(width: 7),
                          file == null
                            ? const Icon(Icons.upload, size: 25, color: Colors.grey)
                            : SvgPicture.asset('assets/images/ia-generate-icon.svg', width: 27, height: 27)
                        ],
                      ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}