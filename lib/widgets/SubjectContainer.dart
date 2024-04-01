import 'dart:async';

import 'package:flashcard_forge_app/models/TopicModel.dart';
import 'package:flashcard_forge_app/screens/flashcards_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flashcard_forge_app/utils/constants.dart';

class SubjectContainer extends StatefulWidget {
  const SubjectContainer({super.key, required this.title, required this.topics});

  final String title;
  final List<TopicResponseModel> topics;

  @override
  State<SubjectContainer> createState() => _SubjectContainerState();
}

class _SubjectContainerState extends State<SubjectContainer> {
  bool showDropdown = false;
  bool creatingTopic = false;
  late TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();
  late StreamSubscription<bool> keyboardSubscription;

  void createTopic(String value) {
    widget.topics.add(TopicResponseModel(topic: TopicModel(
      id: 10000,
      subjectId: 1223243,
      topicName: value
    )));
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
              color: AppColors.secondaryColor,
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
                  size: 50, color: AppColors.whiteColor),
              ),
              Text(widget.title, style: const TextStyle(fontSize: 20, color: AppColors.whiteColor)),
              const Spacer(),
              PopupMenuButton(
                color: AppColors.secondaryColor,
                iconColor: AppColors.whiteColor,
                itemBuilder: (context) {
                  return [
                    const PopupMenuItem<int>(
                      value: 0,
                      child: Text("Rename", style: TextStyle(color: AppColors.whiteColor)),
                    ),
                    const PopupMenuItem<int>(
                      value: 1,
                      child: Text("Delete", style: TextStyle(color: AppColors.whiteColor)),
                    ),
                  ];
                },
                onSelected: (value) {}
              )
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
                color: AppColors.secondaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ...widget.topics.map((topic) {
                    return TextButton(
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => FlashcardScreen(flashcards: topic.flashcards),
                        ),
                      ),
                      child: Row(children: [
                        const SizedBox(width: 8),
                        Text(topic.topic.topicName, style: const TextStyle(fontSize: 16, color: AppColors.accentColor))
                      ]),
                    );
                  }),
                  Visibility(
                    visible: !creatingTopic,
                    replacement: Container(
                      decoration: BoxDecoration(
                        color: AppColors.secondaryColor,
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
                                style: const TextStyle(fontSize: 16, color: AppColors.whiteColor),
                                decoration: const InputDecoration(
                                    hintText: "Add a topic",
                                    hintStyle: TextStyle(fontSize: 16, color: AppColors.whiteColor),
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
                        Text("Create new topic", style: TextStyle(fontSize: 16, color: AppColors.accentColor))
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
