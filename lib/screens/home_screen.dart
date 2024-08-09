import 'dart:async';

import 'package:flashcard_forge_app/models/SubjectModel.dart';
import 'package:flashcard_forge_app/services/repositories/subject_repo.dart';
import 'package:flashcard_forge_app/widgets/DrawerMenu.dart';
import 'package:flashcard_forge_app/widgets/SubjectContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flashcard_forge_app/utils/constants.dart';

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

  bool loading = false;
  bool creatingSubject = false;
  List<SubjectModel> subjects = [];

  void setLoading(bool value) {
    setState(() {
      loading = value;
    });
  }

  Future<void> createSubject(SubjectModel subject) async {
    setLoading(true);
    // await context.read<StudyProvider>().createSubject(subject).then((_) async {
    //   List<SubjectModel> subjectsList = await LocalStorage().getSubjects();
    //   setState(() => subjects = subjectsList);
    // });
    setLoading(false);
  }

  Future<void> getSubjects() async {
    List<SubjectModel> subjects_ = await SubjectRepository().fetchSubjects();
    setState(() {
      subjects =  subjects_;
    });
  }

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
                    createSubject(SubjectModel(subjectName: _controller.text)).then((_) {
                      setState(() {
                        _controller.text = "";
                        creatingSubject = false;
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
    getSubjects();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final subjectList = subjects;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Styles.primaryColor,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.menu_rounded,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        title: SvgPicture.asset('assets/images/logo-v1.svg', height: 35, width: 35),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.all(10),
            child: Icon(Icons.search, size: 30, color: Colors.white),
          ),
        ],
      ),
      drawer: const DrawerMenu(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Visibility(
          visible: subjectList.isNotEmpty || creatingSubject,
          replacement: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: SvgPicture.asset(
                  "assets/images/no-content.svg", 
                  width: MediaQuery.of(context).size.width * .4
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  "No subjects yet",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, color: Styles.backgroundText),
                ),
              )
            ],
          ),
          child: SingleChildScrollView(
            child: Visibility(
              visible: !loading,
              replacement: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                ],
              ),
              child: Column(
                children: [
                  ...subjectList.map((subject) {
                    return SubjectContainer(subject: subject);
                  }),
                  Visibility(
                    visible: creatingSubject,
                    child: Container(
                      height: 65,
                      margin: const EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: Styles.linearGradient
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                            onSubmitted: (value) {
                              createSubject(SubjectModel(subjectName: value)).then((_) {
                                setState(() {
                                  _controller.text = "";
                                  creatingSubject = false;
                                });
                              });
                            },
                            autofocus: creatingSubject,
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
                        ),
                      ),
                    )
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: Visibility(
        visible: !creatingSubject,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: Styles.linearGradient
          ),
          child: FloatingActionButton(
            backgroundColor: Colors.transparent,
            onPressed: () {
              setState(() {
                creatingSubject = true;
              });
            },
            tooltip: 'Create new subject',
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
      ),
    );
  }
}