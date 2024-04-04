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

  @override
  Widget build(BuildContext context) {
    String displayText = _getDisplayText(text);

    return Card(
      elevation: 4.0,
      color: AppColors.secondaryColor,
      child: Center(
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(Icons.edit, color: Colors.blue),
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