import 'package:flashcard_forge_app/utils/constants.dart';
import 'package:flutter/material.dart';

class ThemeSwitch extends StatefulWidget {
  const ThemeSwitch({super.key});

  @override
  State<ThemeSwitch> createState() => _ThemeSwitchState();
}

class _ThemeSwitchState extends State<ThemeSwitch> {
  bool light = false;

  final MaterialStateProperty<Icon?> thumbIcon = MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.dark_mode);
      }
      return const Icon(Icons.light_mode);
    },
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Switch(
          thumbIcon: thumbIcon,
          value: light,
          onChanged: (bool value) {
            setState(() {
              light = value;
            });
          },
        ),
        const SizedBox(width: 5),
        Text("Switch to ${light ? 'light' : 'dark'} theme", style: const TextStyle(color: Colors.white))
      ],
    );
  }
}