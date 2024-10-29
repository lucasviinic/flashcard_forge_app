import 'dart:async';

import 'package:flashcard_forge_app/models/SubjectModel.dart';
import 'package:flashcard_forge_app/models/TopicModel.dart';
import 'package:flashcard_forge_app/screens/flashcards_screen.dart';
import 'package:flashcard_forge_app/services/repositories/subject_repo.dart';
import 'package:flashcard_forge_app/services/repositories/topic_repo.dart';
import 'package:flashcard_forge_app/widgets/CustomModal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flashcard_forge_app/utils/constants.dart';


class SubjectContainer extends StatefulWidget {
  const SubjectContainer({super.key, required this.subject, required this.onDelete});

  final SubjectModel subject;
  final Function(String) onDelete;

  @override
  State<SubjectContainer> createState() => _SubjectContainerState();
}

class _SubjectContainerState extends State<SubjectContainer> {
  late SubjectModel subject;

  bool showDropdown = false;
  bool creatingTopic = false;
  bool editing = false;
  bool isDeleted = false;
  int? longPressedTopicIndex;

  final TextEditingController _topicController = TextEditingController();
  final TextEditingController _editTopicController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();

  final FocusNode _focusNode = FocusNode();
  late StreamSubscription<bool> keyboardSubscription;

  Map<String, bool> editingTopic = {};

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
                    if (_subjectController.text.isNotEmpty) {
                      updateSubject(subject.id!, _subjectController.text).then((value) {
                        setState(() {
                          _subjectController.text = subject.subjectName!;
                          editing = false;
                        });
                      });
                    } else {
                      setState(() {                        
                        _subjectController.text = subject.subjectName!;
                        editing = false;
                      });
                    }
                    Navigator.of(context).pop();
                  } ,
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 5), child: VerticalDivider(width: 10),
                ),
                TextButton(
                  child: const Text('Cancel', style: TextStyle(fontSize: 16, color: Colors.red)),
                  onPressed: () {
                    setState(() {
                      _subjectController.text = subject.subjectName!;
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

  Future<void> createTopic(String subjectId, String topicName) async {
    try {
      TopicModel newTopic = await TopicRepository().createTopic(subjectId, topicName);
      subject.topics!.add(newTopic);

      setState(() {
        _topicController.text = "";
        creatingTopic = false;
      });
    } catch (error) {
      showCustomDialog(
        context: context,
        message: "Error on create topic. Please, try again.",
        dialogType: DialogType.error,
      );
    }
  }

  Future<void> removeTopic(String topicId) async {
    try {
      bool success = await TopicRepository().deleteTopic(topicId);

      if (success) {
        setState(() {
          subject.topics!.removeWhere((topic) => topic.id == topicId);
        });
      }
    } catch (error) {
      print("Erro ao remover o tópico: $error");
    }
  }

  Future<void> updateTopic(String subjectId, String topicId, String topicName) async {
    try {
      TopicModel updatedTopic = await TopicRepository().updateTopic(subjectId, topicId, topicName);

      subject.topics = subject.topics!.map((topic) {
        if (topic.id == topicId) {
          return updatedTopic;
        } else {
          return topic;
        }
      }).toList();
    } catch (error) {
      print("Erro ao atualizar o tópico: $error");
    }
  }

  Future<void> removeSubject(String id) async {
    try {
      bool success = await SubjectRepository().deleteSubject(id);

      if (success) {
        setState(() => isDeleted = true);
        widget.onDelete(widget.subject.id!);
      }
    } catch (e) {
      // exibe modal de erro
    }
  }

  Future<void> updateSubject(String id, String name) async {
    try {
      SubjectModel? subject_ = await SubjectRepository().updateSubject(id, name);

      if (subject_ != null) {
        setState(() {
          subject = subject_;
        });
      }
    } catch (e) {
      // exibe modal de erro
    }
  }

  @override
  void initState() {
    super.initState();
    subject = widget.subject;
    _topicController.text = "";
    _subjectController.text = subject.subjectName!;
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
    return isDeleted ? const SizedBox.shrink() : GestureDetector(
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
                        cursorColor: Theme.of(context).hintColor,
                        onSubmitted: (value) {
                          setState(() => editing = false);
                          if(value.isNotEmpty) {
                            updateSubject(subject.id!, value).then((_) {
                              setState(() {
                                _subjectController.text = value;
                              });
                            });
                          } else {
                            setState(() {
                              _subjectController.text = subject.subjectName!;
                            });
                          }
                        },
                        autofocus: editing,
                        maxLength: 50,
                        controller: _subjectController,
                        style: TextStyle(fontSize: 20, color: Theme.of(context).textTheme.bodyMedium!.color),
                        decoration: InputDecoration(
                          hintStyle: TextStyle(color: Theme.of(context).hintColor),
                          counterText: "",
                          contentPadding: EdgeInsets.zero,
                          isDense: true,
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Theme.of(context).hintColor),
                          ),
                        ),
                        focusNode: _focusNode,
                      ),
                      child: Text(
                        subject.subjectName!,
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
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.edit, color: Theme.of(context).textTheme.bodyMedium!.color),
                                const SizedBox(width: 8),
                                Text(
                                  "Rename",
                                  style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color),
                                ),
                              ],
                            ),
                          ),
                        ),
                        PopupMenuItem<int>(
                          value: 1,
                          child: TextButton(
                            onPressed: () async {
                              await removeSubject(subject.id!);
                              Navigator.pop(context);
                            },
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.only(left: 0, top: 0, bottom: 0),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.delete, color: Theme.of(context).textTheme.bodyMedium!.color), // Ícone de lixeira
                                const SizedBox(width: 8), // Espaço entre o ícone e o texto
                                Text(
                                  "Delete",
                                  style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color),
                                ),
                              ],
                            ),
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
                      for (var i = 0; i < subject.topics!.length; i++)
                        TextButton(
                          onLongPress: () => setState(() {
                            longPressedTopicIndex = longPressedTopicIndex != i ? i : null;
                          }),
                          onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => FlashcardScreen(topic: subject.topics![i]),
                            ),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(width: 8),
                              Expanded(
                                flex: 4,
                                child: Text(
                                  subject.topics![i].topicName,
                                  style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.bodyMedium!.color),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              Visibility(
                                visible: i == longPressedTopicIndex,
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () => setState(() {
                                        editingTopic[subject.topics![i].id!] = true;
                                        _editTopicController.text = subject.topics![i].topicName;
                                      }),
                                      icon: const Icon(Icons.edit),
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        await removeTopic(subject.topics![i].id!);
                                        setState(() {
                                          longPressedTopicIndex = null;
                                        });
                                      },
                                      icon: Icon(Icons.close_rounded, color: Colors.red[900]),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
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
                                    maxLength: 30,
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
                                        onPressed: () => createTopic(subject.id!, _topicController.text),
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
              )
            ),
          ],
        ),
      ),
    );
  }
}
