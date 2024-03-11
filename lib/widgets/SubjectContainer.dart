import 'dart:async';

import 'package:flashcard_forge_app/screens/flashcards_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class SubjectContainer extends StatefulWidget {
  const SubjectContainer({super.key, required this.title});

  final String title;

  @override
  State<SubjectContainer> createState() => _SubjectContainerState();
}

class _SubjectContainerState extends State<SubjectContainer> {
  bool showDropdown = false;
  List<String> topics = ["Mitosis", "Meiosis", "Botany"];
  bool creatingTopic = false;
  late TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();
  late StreamSubscription<bool> keyboardSubscription;

  void createTopic(String value) {
    topics.add(value);
    setState(() {
      _controller.text = "";
      creatingTopic = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    KeyboardVisibilityController().onChange.listen((bool visible) {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 65,
          margin: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 180, 217, 255),
              borderRadius: showDropdown
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    )
                  : BorderRadius.circular(10)),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    showDropdown = !showDropdown;
                  });
                },
                child: Icon(
                    showDropdown
                        ? Icons.arrow_drop_down_rounded
                        : Icons.arrow_right_rounded,
                    size: 50),
              ),
              Text(widget.title, style: const TextStyle(fontSize: 20)),
              const Spacer(),
              PopupMenuButton(
                  color: const Color.fromRGBO(135, 196, 255, 1),
                  itemBuilder: (context) {
                    return [
                      const PopupMenuItem<int>(
                        value: 0,
                        child: Text("Rename"),
                      ),
                      const PopupMenuItem<int>(
                        value: 1,
                        child: Text("Delete"),
                      ),
                    ];
                  },
                  onSelected: (value) {
                    if (value == 0) {
                      print("Rename menu is selected.");
                    } else if (value == 1) {
                      print("Delete menu is selected.");
                    }
                  })
            ],
          ),
        ),
        Visibility(
            visible: showDropdown,
            child: AnimatedContainer(
              width: MediaQuery.of(context).size.width,
              duration: const Duration(seconds: 5),
              curve: Curves.fastOutSlowIn,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 180, 217, 255),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ...topics.map((topic) {
                    return TextButton(
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const FlashcardScreen(),
                        ),
                      ),
                      child: Row(children: [
                        const SizedBox(width: 8),
                        Text(topic, style: const TextStyle(fontSize: 16))
                      ]),
                    );
                  }),
                  Visibility(
                    visible: !creatingTopic,
                    replacement: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 180, 217, 255),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: TextField(
                                autofocus: creatingTopic,
                                maxLength: 15,
                                controller: _controller,
                                style: const TextStyle(fontSize: 16),
                                decoration: const InputDecoration(
                                    hintText: "Add a topic",
                                    hintStyle: TextStyle(fontSize: 16),
                                    counterText: "",
                                    contentPadding: EdgeInsets.zero,
                                    isDense: true),
                                focusNode: _focusNode,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton(
                                  child: const Text('Save',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.green)),
                                  onPressed: () =>
                                      createTopic(_controller.text),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  child: VerticalDivider(),
                                ),
                                TextButton(
                                  child: const Text('Cencel',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.red)),
                                  onPressed: () {
                                    setState(() {
                                      _controller.text = "";
                                      creatingTopic = false;
                                    });
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    child: TextButton(
                      onPressed: () => setState(() {
                        creatingTopic = true;
                      }),
                      child: const Row(children: [
                        Icon(Icons.add),
                        SizedBox(width: 8),
                        Text("Create new topic", style: TextStyle(fontSize: 16))
                      ]),
                    ),
                  )
                ],
              ),
            )),
      ],
    );
  }
}
