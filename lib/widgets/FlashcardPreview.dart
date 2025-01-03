import 'package:flashcard_forge_app/models/FlashcardModel.dart';
import 'package:flashcard_forge_app/services/repositories/flashcard_repo.dart';
import 'package:flashcard_forge_app/widgets/Flashcard.dart';
import 'package:flashcard_forge_app/widgets/FlashcardForm.dart';
import 'package:flutter/material.dart';

class FlashcardPreview extends StatefulWidget {
  final FlashcardModel flashcard;
  final void Function(FlashcardModel flashcard) onDelete;

  const FlashcardPreview({
    required this.flashcard,
    required this.onDelete,
    super.key,
  });

  @override
  State<FlashcardPreview> createState() => _FlashcardPreviewState();
}

class _FlashcardPreviewState extends State<FlashcardPreview> {
  FlashcardModel? flashcard;
  bool showEditOptions = false;

  String _getDisplayText(String text) {
    if (text.length > 30 && text.length < 40) {
      return "${text.substring(0, 27)}...";
    } else if (text.length >= 50) {
      return "${text.substring(0, 47)}...";
    } else {
      return text;
    }
  }

  Future<void> deleteFlashcard(FlashcardModel flashcard) async {
    try {
      FlashcardRepository().deleteFlashcard(widget.flashcard.id!)
        .then((_) => widget.onDelete(flashcard));
    } catch (error) {
      print("Erro ao editar flashcard");
    }
  }

  Future<void> showDeleteFlashcardDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).dialogTheme.backgroundColor,
          title: Icon(Icons.warning_amber_rounded, color: Colors.red[600], size: 50),
          content: const Text(
            "Do you really want to delete this flashcard?",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Yes', style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.bodyMedium!.color)),
              onPressed: () async {
                deleteFlashcard(flashcard!).then((_) => Navigator.of(context).pop());
              },
            ),
            TextButton(
              child: Text('No', style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.bodyMedium!.color)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    flashcard = widget.flashcard;
  }

  @override
  Widget build(BuildContext context) {
    String displayText = _getDisplayText(flashcard!.question!);

    return GestureDetector(
      onLongPress: () {
        setState(() {
          showEditOptions = !showEditOptions;
        });
      },
      onTap: () async {
        if (!showEditOptions) {
          
          if (flashcard?.opened == false) {
            setState(() => flashcard?.opened = true);
            FlashcardRepository().updateFlashcard(flashcard!);
          }

          showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return Flashcard(flashcard: flashcard);
            },
          );
      }},
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).floatingActionButtonTheme.backgroundColor,
              borderRadius: BorderRadius.circular(10),
              border: flashcard?.opened == false 
                ? Border.all(
                    color: Colors.green,
                    width: 2.5,
                  )
                : null,
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 12, right: 12),
                child: Text(
                  displayText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: displayText.length >= 40 ? 15 : 20,
                    color: Theme.of(context).textTheme.bodyMedium!.color,
                  ),
                  maxLines: displayText.length >= 40 ? 4 : 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
          if (showEditOptions)
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10), 
                child: Container(
                  color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.5),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () async {
                            final flashcardObject = await showDialog<FlashcardModel>(
                              context: context,
                              builder: (BuildContext context) {
                                return FlashcardForm(flashcard: flashcard);
                              },
                            );
                
                            if (flashcardObject != null) {
                              setState(() {
                                flashcard = flashcardObject;
                                showEditOptions = false;
                              });
                            }
                          },
                          icon: const Icon(Icons.edit, color: Colors.blue, size: 40),
                        ),
                        const SizedBox(width: 10),
                        IconButton(
                          onPressed: () async {
                            await showDeleteFlashcardDialog(context);
                            setState(() {
                              showEditOptions = false;
                            });
                          },
                          icon: const Icon(Icons.delete, color: Colors.red, size: 40),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}