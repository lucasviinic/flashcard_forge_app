import 'dart:async';

import 'package:flashcard_forge_app/widgets/SubjectContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController _controller;
  late StreamSubscription<bool> keyboardSubscription;
  final FocusNode _focusNode = FocusNode();

  List<String> subjects = ['Biologia', 'História', 'Filosofia'];
  bool creatingSubject = false;

  void createSubject(String value) {
    subjects.add(value);
    setState(() {
      _controller.text = "";
      creatingSubject = false;
    });
    Navigator.of(context).pop();
  }

  void showOptionModal() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 100,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  child: const Text('Save',
                      style: TextStyle(fontSize: 16, color: Colors.green)),
                  onPressed: () => createSubject(_controller.text),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: VerticalDivider(),
                ),
                TextButton(
                  child: const Text('Cencel',
                      style: TextStyle(fontSize: 16, color: Colors.red)),
                  onPressed: () {
                    setState(() {
                      _controller.text = "";
                      creatingSubject = false;
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

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    KeyboardVisibilityController().onChange.listen((bool visible) {
      if (!visible && creatingSubject) {
        showOptionModal();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
        title: SvgPicture.asset('assets/images/logo-v1.svg', height: 45, width: 45),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.search, size: 35),
          ),
        ],
      ),
      drawer: const Drawer(
        backgroundColor: Color.fromRGBO(135, 196, 255, 1),
      ),
      body: Container(
        color: const Color.fromRGBO(224, 244, 255, 1),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              const Divider(color: Colors.black),
              Column(
                children: subjects.map((subject) {
                  return SubjectContainer(title: subject);
                }).toList(),
              ),
              Visibility(
                  visible: creatingSubject,
                  child: Container(
                    height: 65,
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 180, 217, 255),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          autofocus: creatingSubject,
                          maxLength: 15,
                          controller: _controller,
                          style: const TextStyle(fontSize: 20),
                          decoration: const InputDecoration(
                              hintText: "Add a subject",
                              hintStyle: TextStyle(fontSize: 20),
                              counterText: "",
                              contentPadding: EdgeInsets.zero,
                              isDense: true),
                          focusNode: _focusNode,
                        ),
                      ),
                    ),
                  )
                ),
                const SizedBox(height: 25)
            ],
          ),
        ),
      ),
      floatingActionButton: Visibility(
        visible: !creatingSubject,
        child: FloatingActionButton(
          onPressed: () {
            setState(() {
              creatingSubject = true;
            });
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
