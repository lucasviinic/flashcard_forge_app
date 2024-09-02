import 'package:flashcard_forge_app/providers.dart';
import 'package:flashcard_forge_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeSwitch extends StatefulWidget {
  const ThemeSwitch({super.key});

  @override
  State<ThemeSwitch> createState() => _ThemeSwitchState();
}

class _ThemeSwitchState extends State<ThemeSwitch> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    final WidgetStateProperty<Icon?> thumbIcon = WidgetStateProperty.resolveWith<Icon?>(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return Icon(Icons.light_mode, color: Theme.of(context).colorScheme.primary);
        }
        return Icon(Icons.dark_mode, color: Theme.of(context).colorScheme.secondary);
      },
    );

    return Row(
      children: [
        Switch(
          thumbIcon: thumbIcon,
          value: themeProvider.currentTheme == AppThemes.lightTheme,
          onChanged: (bool value) {
            themeProvider.toggleTheme();
          },
          activeColor: Theme.of(context).colorScheme.secondary,
          inactiveTrackColor: Theme.of(context).colorScheme.secondary,
        ),
        const SizedBox(width: 5),
        Text(
          "Switch to ${themeProvider.currentTheme == AppThemes.lightTheme ? 'dark' : 'light'} theme",
          style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color),
        ),
      ],
    );
  }
}
