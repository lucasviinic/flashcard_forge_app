import 'package:flutter/material.dart';

enum DialogType { error, confirmation, info }

void showCustomDialog({
  required BuildContext context,
  required String message,
  DialogType dialogType = DialogType.info,
  String title = '',
  VoidCallback? onConfirm,
}) {
  String dialogTitle;
  Icon dialogIcon;

  switch (dialogType) {
    case DialogType.error:
      dialogTitle = title.isNotEmpty ? title : "Error";
      dialogIcon = const Icon(Icons.error, color: Colors.red);
      break;
    case DialogType.confirmation:
      dialogTitle = title.isNotEmpty ? title : "Confirmation";
      dialogIcon = const Icon(Icons.help, color: Colors.blue);
      break;
    case DialogType.info:
      dialogTitle = title.isNotEmpty ? title : "Information";
      dialogIcon = const Icon(Icons.info, color: Colors.green);
      break;
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Row(
          children: [
            dialogIcon,
            const SizedBox(width: 8),
            Text(dialogTitle),
          ],
        ),
        content: Text(message),
        actions: [
          if (dialogType == DialogType.confirmation) ...[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text("Confirm"),
              onPressed: () {
                Navigator.of(context).pop();
                if (onConfirm != null) onConfirm();
              },
            ),
          ] else
            TextButton(
              child: const Text("OK"),
              onPressed: () => Navigator.of(context).pop(),
            ),
        ],
      );
    },
  );
}
