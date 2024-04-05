import 'package:flashcard_forge_app/utils/constants.dart';
import 'package:flutter/material.dart';

class FlashcardPreview extends StatelessWidget {
  final String text;

  const FlashcardPreview(this.text, {super.key});

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
        return AlertDialog(
          backgroundColor: AppColors.secondaryColor,
          title: const Text('Edit flashcard', style: TextStyle(color: AppColors.whiteColor)),
          content: const SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Question:"),
                TextField(
                  decoration: InputDecoration(labelText: 'Enter flashcard question'),
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  style: TextStyle(color: AppColors.whiteColor),
                ),
                SizedBox(height: 10),
                Text("Answer:"),
                TextField(
                  decoration: InputDecoration(labelText: 'Enter flashcard answer'),
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  style: TextStyle(color: AppColors.whiteColor),
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
  }

  @override
  Widget build(BuildContext context) {
    String displayText = _getDisplayText(text);

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
            Padding(
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
          ],
        ),
      ),
    );
  }
}
