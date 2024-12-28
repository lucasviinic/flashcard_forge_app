import 'package:flashcard_forge_app/services/repositories/feedback_repo.dart';
import 'package:flutter/material.dart';

class FeedbackModal extends StatefulWidget {
  const FeedbackModal({super.key});

  @override
  State<FeedbackModal> createState() => _FeedbackModalState();
}

class _FeedbackModalState extends State<FeedbackModal> {
  final TextEditingController content = TextEditingController();
  bool sent = false;
  bool success = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void setLoading(bool value) {
    setState(() => isLoading = value);
  }

  Future<void> sendFeedback(String text) async {
    setLoading(true);
    try {
      await FeedbackRepository().sendFeedback(text);
      setState(() => success = true);
    } catch (e) {
      setState(() => success = false);
    }
    setLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).dialogTheme.backgroundColor,
      title: isLoading ? null : sent 
      ? Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            }, 
            icon: const Icon(Icons.close, color: Colors.red, size: 30),
          ),
        )
      : Text(
          "Feedback",
          style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color),
        ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * .95,
        child: SingleChildScrollView(
          child: isLoading 
            ? Padding(
              padding: const EdgeInsets.only(top: 100, bottom: 50),
              child: Center(
                child: SizedBox(
                  width: 65,
                  height: 65,
                  child: CircularProgressIndicator(color: Theme.of(context).textTheme.bodyMedium!.color)
                )
              ),
            )
            : sent
              ? Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 65),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: success 
                          ? const Icon(Icons.check_circle_outline_outlined, color: Colors.green, size: 100)
                          : const Icon(Icons.error_outline, color: Colors.red, size: 100)
                      ),
                      success 
                        ? const Text("Feedback enviado com sucesso!", style: TextStyle(fontSize: 17), textAlign: TextAlign.center)
                        : const Text("Something went wrong. Please try again.", style: TextStyle(fontSize: 17), textAlign: TextAlign.center)
                    ],
                  ),
                ),
              )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: content,
                      cursorColor: Theme.of(context).hintColor,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Theme.of(context).hintColor),
                        labelText: 'Leave your feedback here',
                        hintStyle: TextStyle(color: Theme.of(context).hintColor),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).hintColor), // Cor da borda branca quando focado
                        ),
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color),
                    ),
                  ],
                ),
        ),
      ),
      actions: sent ? null : <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: Text('Cancel', style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color, fontSize: 16)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: Text("Send", style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color, fontSize: 16)),
          onPressed: () async {
            await sendFeedback(content.text);
            setState(() => sent = true);
          },
        ),
      ],
    );
  }
}