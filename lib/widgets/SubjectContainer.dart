import 'dart:async';

import 'package:flashcard_forge_app/models/SubjectModel.dart';
import 'package:flashcard_forge_app/models/TopicModel.dart';
import 'package:flashcard_forge_app/screens/flashcards_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flashcard_forge_app/utils/constants.dart';


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
  
  int? longPressedTopicIndex;

  final TextEditingController _topicController = TextEditingController();
  final TextEditingController _editTopicController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();

  final FocusNode _focusNode = FocusNode();
  late StreamSubscription<bool> keyboardSubscription;

  Map<int, bool> editingTopic = {};

  void showOptionModal() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 90,
          color: Theme.of(context).textTheme.bodyMedium!.color,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  child: const Text('Save', style: TextStyle(fontSize: 16, color: Colors.green)),
                  onPressed: () async {
                    updateSubject(widget.subject.id!, _subjectController.text).then((value) {
                      setState(() {
                        _subjectController.text = widget.subject.subjectName!;
                        editing = false;
                      });
                      Navigator.of(context).pop();
                    });
                  } ,
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 5), child: VerticalDivider(width: 10),
                ),
                TextButton(
                  child: const Text('Cancel', style: TextStyle(fontSize: 16, color: Colors.red)),
                  onPressed: () {
                    setState(() {
                      _subjectController.text = widget.subject.subjectName!;
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

  Future<void> createTopic(int subjectId, String topicName) async {
    try {
      TopicModel topic = TopicModel(subjectId: subjectId, topicName: topicName);
      //await context.read<StudyProvider>().createTopic(subjectId, topic);
      setState(() {
        _topicController.text = "";
        creatingTopic = false;
      });
    } catch (error) {
      print("Erro ao criar o tópico: $error");
    }
  }

  Future<void> removeTopic(int subjectId, int topicId) async {
    try {
      //await context.read<StudyProvider>().removeTopic(subjectId, topicId);
    } catch (error) {
      print("Erro ao remover o tópico: $error");
    }
  }

  Future<void> updateTopic(int subjectId, int topicId, String name) async {
    try {
      //await context.read<StudyProvider>().updateTopic(subjectId, topicId, name);
    } catch (error) {
      print("Erro ao atualizar o tópico: $error");
    }
  }

  Future<void> removeSubject(int id) async {
    // await LocalStorage().removeSubject(id).then((_) {
    //   Provider.of<StudyProvider>(context, listen: false).removeSubject(id);
    // });
  }

  Future<void> updateSubject(int id, String name) async {
    //await context.read<StudyProvider>().updateSubject(widget.subject.id!, _subjectController.text);
  }

  @override
  void initState() {
    super.initState();
    _topicController.text = "";
    _subjectController.text = widget.subject.subjectName!;
    KeyboardVisibilityController().onChange.listen((bool visible) {
      if (!visible && editing) {
        showOptionModal();
      }
    });
    KeyboardVisibilityController().onChange.listen((bool visible) {});
  }

  @override
  void dispose() {
    _subjectController.dispose();
    _topicController.dispose();
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
          color: Theme.of(context).floatingActionButtonTheme.backgroundColor
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  Icon(showDropdown ? Icons.arrow_drop_down_rounded : Icons.arrow_right_rounded,
                    size: 50, color: Theme.of(context).textTheme.bodyMedium!.color
                  ),
                  Expanded(
                    child: Visibility(
                      visible: !editing,
                      replacement: TextField(
                        onSubmitted: (value) {
                          updateSubject(widget.subject.id!, value).then((_) {
                            setState(() {
                              _subjectController.text = value;
                              editing = false;
                            });
                          });
                        },
                        autofocus: editing,
                        maxLength: 50,
                        controller: _subjectController,
                        style: TextStyle(fontSize: 20, color: Theme.of(context).textTheme.bodyMedium!.color),
                        decoration: InputDecoration(
                          hintStyle: TextStyle(color: Theme.of(context).hintColor),
                          counterText: "",
                          contentPadding: EdgeInsets.zero,
                          isDense: true
                        ),
                        focusNode: _focusNode,
                      ),
                      child: Text(
                        widget.subject.subjectName!,
                        style: TextStyle(fontSize: 20, color: Theme.of(context).textTheme.bodyMedium!.color),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ),
                  PopupMenuButton(
                    color: Theme.of(context).popupMenuTheme.color,
                    iconColor: Theme.of(context).textTheme.bodyMedium!.color,
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem<int>(
                          value: 0,
                          child: TextButton(
                            onPressed: () {
                              setState(() => editing = true);
                              Navigator.of(context).pop();
                            },
                            child: Text("Rename", style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color))
                          )
                        ),
                        PopupMenuItem<int>(
                          value: 1,
                          child: TextButton(
                            onPressed: () async {
                              //await context.read<StudyProvider>().removeSubject(widget.subject.id!).then((value) => Navigator.of(context).pop());
                            },
                            child: Text("Delete", style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color))
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
                      for (var i = 0; i < widget.subject.topics!.length; i++)
                        TextButton(
                          onLongPress: () => setState(() {
                            longPressedTopicIndex = longPressedTopicIndex != i ? i : null;
                          }),
                          onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => FlashcardScreen(topic: widget.subject.topics![i]),
                            ),
                          ),
                          child: Row(children: [
                            const SizedBox(width: 8),
                            Expanded(
                              child: Visibility(
                                visible: !(editingTopic[widget.subject.topics![i].id!] ?? false),
                                replacement: TextField(
                                  onSubmitted: (value) {
                                    updateTopic(widget.subject.id!, widget.subject.topics![i].id!, value).then((_) {
                                      setState(() {
                                        _editTopicController.text = value;
                                        editingTopic[widget.subject.topics![i].id!] = false;
                                      });
                                    });
                                  },
                                  autofocus: editingTopic[widget.subject.topics![i].id!] ?? false,
                                  maxLength: 50,
                                  controller: _editTopicController,
                                  style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color),
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color),
                                    counterText: "",
                                    contentPadding: EdgeInsets.zero,
                                    isDense: true,
                                    border: InputBorder.none
                                  ),
                                  focusNode: _focusNode,
                                ),
                                child: Text(
                                  widget.subject.topics![i].topicName,
                                  style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.bodyMedium!.color),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Visibility(
                              visible: i == longPressedTopicIndex,
                              child: Visibility(
                                visible: editingTopic[widget.subject.topics![i].id!] ?? false,
                                replacement: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () => setState(() {
                                        editingTopic[widget.subject.topics![i].id!] = true;
                                        _editTopicController.text = widget.subject.topics![i].topicName;
                                      }),
                                      icon: const Icon(Icons.edit)
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        await removeTopic(widget.subject.id!, widget.subject.topics![i].id!);
                                        longPressedTopicIndex = null;
                                      },
                                      icon: Icon(Icons.close_rounded, color: Colors.red[900])
                                    )
                                  ],
                                ),
                                child: IconButton(
                                  onPressed: () async {
                                    updateTopic(widget.subject.id!, widget.subject.topics![i].id!, _editTopicController.text).then((_) {
                                      setState(() {
                                        longPressedTopicIndex = null;
                                        editingTopic[widget.subject.topics![i].id!] = false;
                                      });
                                    });
                                  },
                                  icon: Icon(Icons.check, color: Colors.green[900])
                                ),
                              )
                            )
                          ]),
                        ),
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
                                    cursorColor: Theme.of(context).hintColor,
                                    autofocus: creatingTopic,
                                    maxLength: 50,
                                    controller: _topicController,
                                    style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color),
                                    decoration: InputDecoration(
                                        hintText: "Add a topic",
                                        hintStyle: TextStyle(fontSize: 16, color: Theme.of(context).hintColor),
                                        counterText: "",
                                        contentPadding: EdgeInsets.zero,
                                        isDense: true,
                                        focusedBorder: UnderlineInputBorder(
                                          //borderRadius: const BorderRadius.all(Radius.circular(50)), // Bordas arredondadas
                                          borderSide: BorderSide(color: Theme.of(context).hintColor), // Cor da borda branca quando focado
                                        ),
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
                                        onPressed: () => createTopic(widget.subject.id!, _topicController.text),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(vertical: 5),
                                        child: VerticalDivider(),
                                      ),
                                      TextButton(
                                        child: const Text('Cancel', style: TextStyle(fontSize: 16, color: Colors.red)),
                                        onPressed: () {
                                          setState(() {
                                            _topicController.text = "";
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
                              Icon(Icons.add, color: Styles.accentColor),
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
