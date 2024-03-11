import 'package:flashcard_forge_app/models/FlashcardModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FlashcardScreen extends StatefulWidget {
  const FlashcardScreen({super.key, this.flashcards});

  final List<FlashcardModel>? flashcards;

  @override
  State<FlashcardScreen> createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(224, 244, 255, 1),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.menu_rounded,
                color: Colors.black,
                size: 40,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        title: SvgPicture.asset('assets/images/logo-v1.svg',
            height: 45, width: 45),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.search, size: 35),
          ),
        ],
      ),
    );
  }
}
