import 'dart:async';

import 'package:flashcard_forge_app/models/SubjectModel.dart';
import 'package:flashcard_forge_app/models/TopicModel.dart';
import 'package:flashcard_forge_app/providers/subject_provider.dart';
import 'package:flashcard_forge_app/screens/flashcards_screen.dart';
import 'package:flashcard_forge_app/services/repositories/local_storage_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flashcard_forge_app/utils/constants.dart';
import 'package:provider/provider.dart';

class SubjectContainer extends StatefulWidget {
  const SubjectContainer({super.key, required this.subject});

  final SubjectModel subject;

  @override
  State<SubjectContainer> createState() => _SubjectContainerState();
}

class _SubjectContainerState extends State<SubjectContainer> {
  bool showDropdown = false;
  bool creatingTopic = false;
  bool editing = false;
  
  late TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();
  late StreamSubscription<bool> keyboardSubscription;

    void showOptionModal() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 90,
          color: Styles.secondaryColor,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  child: const Text('Save', style: TextStyle(fontSize: 16, color: Colors.green)),
                  onPressed: () async {
                    context.read<SubjectProvider>().updateSubject(widget.subject.id!, _controller.text).then((value) {
                      setState(() {
                        _controller.text = widget.subject.subjectName!;
                        editing = false;
                      });
                      Navigator.of(context).pop();
                    });
                  } ,
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 5), child: VerticalDivider(width: 10),
                ),
                TextButton(
                  child: const Text('Cencel', style: TextStyle(fontSize: 16, color: Colors.red)),
                  onPressed: () {
                    setState(() {
                      _controller.text = widget.subject.subjectName!;
                      editing = false;
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void createTopic(String value) {
    widget.subject.topics!.add(TopicModel(
      id: 10000,
      subjectId: 1223243,
      topicName: value,
      flashcards: []
    ));
    setState(() {
      _controller.text = "";
      creatingTopic = false;
    });
  }

  Future<void> removeSubject(int id) async {
    await LocalStorage().removeSubject(id).then((value) {
      Provider.of<SubjectProvider>(context, listen: false).removeSubject(id);
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.text = widget.subject.subjectName!;
    KeyboardVisibilityController().onChange.listen((bool visible) {
      if (!visible && editing) {
        showOptionModal();
      }
    });
    KeyboardVisibilityController().onChange.listen((bool visible) {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          showDropdown = !showDropdown;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: Styles.linearGradient
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  Icon(showDropdown ? Icons.arrow_drop_down_rounded : Icons.arrow_right_rounded,
                    size: 50, color: Colors.white
                  ),
                  Expanded(
                    child: Text(
                      widget.subject.subjectName!,
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  PopupMenuButton(
                    color: Styles.secondaryColor,
                    iconColor: Colors.white,
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem<int>(
                          value: 0,
                          child: TextButton(
                            onPressed: () async {
                              setState(() => editing = true);
                            },
                            child: const Text("Rename", style: TextStyle(color: Colors.white))
                          )
                        ),
                        PopupMenuItem<int>(
                          value: 1,
                          child: TextButton(
                            onPressed: () async {
                              await context.read<SubjectProvider>().removeSubject(widget.subject.id!)
                                .then((value) => Navigator.pop(context));
                            },
                            child: const Text("Delete", style: TextStyle(color: Colors.white))
                          ),
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
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ...widget.subject.topics!.map((topic) {
                        return TextButton(
                          onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => FlashcardScreen(flashcards: topic.flashcards, title: topic.topicName),
                            ),
                          ),
                          child: Row(children: [
                            const SizedBox(width: 8),
                            Expanded(
                              child: Visibility(
                                visible: editing,
                                replacement: TextField(
                                  autofocus: editing,
                                  maxLength: 50,
                                  controller: _controller,
                                  style: const TextStyle(fontSize: 20, color: Colors.white),
                                  decoration: const InputDecoration(
                                    hintText: "Add a subject",
                                    hintStyle: TextStyle(fontSize: 20, color: Colors.white),
                                    counterText: "",
                                    contentPadding: EdgeInsets.zero,
                                    isDense: true
                                  ),
                                  focusNode: _focusNode,
                                ),
                                child: Text(
                                  topic.topicName,
                                  style: const TextStyle(fontSize: 16, color: Styles.accentColor),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ),
                          ]),
                        );
                      }),
                      Visibility(
                        visible: !creatingTopic,
                        replacement: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: TextField(
                                    autofocus: creatingTopic,
                                    maxLength: 50,
                                    controller: _controller,
                                    style: const TextStyle(fontSize: 16, color: Colors.white),
                                    decoration: const InputDecoration(
                                      hintText: "Add a topic",
                                      hintStyle: TextStyle(fontSize: 16, color: Colors.white),
                                      counterText: "",
                                      contentPadding: EdgeInsets.zero,
                                      isDense: true
                                    ),
                                    focusNode: _focusNode,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      TextButton(
                                        child: const Text('Save', style: TextStyle(fontSize: 16, color: Colors.green)),
                                        onPressed: () => createTopic(_controller.text),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(vertical: 5),
                                        child: VerticalDivider(),
                                      ),
                                      TextButton(
                                        child: const Text('Cencel', style: TextStyle(fontSize: 16, color: Colors.red)),
                                        onPressed: () {
                                          setState(() {
                                            _controller.text = "";
                                            creatingTopic = false;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        child: TextButton(
                          onPressed: () => setState(() {
                            creatingTopic = true;
                          }),
                          child: const Padding(
                            padding: EdgeInsets.only(bottom: 5),
                            child: Row(children: [
                              Icon(Icons.add),
                              SizedBox(width: 8),
                              Text("Create new topic", style: TextStyle(fontSize: 16, color: Styles.accentColor))
                            ]),
                          ),
                        ),
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
