import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final Function(String) onSearchChanged;
  final String? label;

  const CustomSearchBar({super.key, required this.onSearchChanged, this.label});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        onSearchChanged(value);
      },
      cursorColor: Theme.of(context).hintColor,
      style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color),
      decoration: InputDecoration(
        hintText: label ?? "Search term",
        hintStyle: TextStyle(color: Theme.of(context).hintColor),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Icon(Icons.search, size: 25, color: Theme.of(context).hintColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(50)),
          borderSide: BorderSide(color: Theme.of(context).hintColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(50)),
          borderSide: BorderSide(color: Theme.of(context).hintColor),
        ),
      ),
    );
  }
}
