import 'dart:async';

import 'package:flashcard_forge_app/models/SubjectModel.dart';
import 'package:flashcard_forge_app/services/repositories/preferences_repo.dart';
import 'package:flashcard_forge_app/services/repositories/subject_repo.dart';
import 'package:flashcard_forge_app/widgets/DrawerMenu.dart';
import 'package:flashcard_forge_app/widgets/SubjectContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flashcard_forge_app/utils/constants.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController _controller;
  final scrollController = ScrollController();

  late StreamSubscription<bool> keyboardSubscription;
  bool isSearching = false;
  int offset = 0;
  int limit = 15;
  bool hasMore = true;
  bool isLoadingMore = false;

  final FocusNode _focusNode = FocusNode();

  bool isLoading = false;
  bool creatingSubject = false;
  List<SubjectModel> subjects = [];

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email'
    ]
  );

  void setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  Future<void> signOutFromGoogle() async {
    try {
      _googleSignIn.signOut().then((_) => PreferencesRepository().clearUserPrefs());
      print('User logged out successfully');
    } catch (e) {
      print('Error logging out from Google: $e');
    }
  }

  Future<void> createSubject(SubjectModel subject) async {
    try {
      SubjectModel newSubject = await SubjectRepository().createSubject(subject);
      setState(() {
        subjects.add(newSubject);
      });
    } catch (e) {
      print(e);
      //exibe modal de erro
    }
  }

  bool isSubjectDuplicate(SubjectModel newSubject) {
    return subjects.any((subject) => subject.id == newSubject.id);
  }

  Future<void> getSubjects({bool requestMore = false, bool isRefresh = false}) async {
    if (!isRefresh && (isLoading || isLoadingMore || !hasMore)) return;

    if (isRefresh) {
      setState(() {
        subjects.clear();
        offset = 0;
        limit = 15;
        hasMore = true;
      });
      setLoading(true);
    } else if (requestMore) {
      setState(() {
        isLoadingMore = true;
      });
    } else {
      setLoading(true);
    }

    try {
      List<SubjectModel>? newSubjects = await SubjectRepository().fetchSubjects(offset, limit);
      
      if (newSubjects != null && newSubjects.isNotEmpty) {
        setState(() {
          subjects.addAll(newSubjects.where((newSubject) => !isSubjectDuplicate(newSubject)).toList());
          offset += limit;
        });

        if (newSubjects.length < limit) {
          setState(() => hasMore = false);
        }
      } else {
        setState(() => hasMore = false);
      }
    } catch (e) {
      //se acontecer um erro lanço um modal aqui
    } finally {
      setLoading(false);
      setState(() {
        isLoadingMore = false;
      });
    }
  }

  Future<void> showConfirmModal() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).dialogTheme.backgroundColor,
          content: SizedBox(
            width: MediaQuery.of(context).size.width * .95,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Icon(Icons.warning_amber_rounded, color: Colors.orangeAccent, size: 100),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Do you want to save the action?", 
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyMedium!.color,
                        fontSize: 20,
                      )
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: Text('Cancel', style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color, fontSize: 16)),
              onPressed: () {
                setState(() {
                  _controller.text = "";
                  creatingSubject = false;
                });
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: Text("Save", style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color, fontSize: 16)),
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
          ],
        );
      },
    );
  }

  void scrollToEndAndFocus() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      ).then((_) => FocusScope.of(context).requestFocus(_focusNode));
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    KeyboardVisibilityController().onChange.listen((bool visible) {
      if (creatingSubject && !visible) {
        if (_controller.text == "") {
          setState(() {
            _controller.text = "";
            creatingSubject = false;
          });
        } else {
          showConfirmModal();
        }
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(
                Icons.menu_rounded,
                color: Theme.of(context).textTheme.bodyMedium!.color,
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
        actions: const [],
      ),
      drawer: const DrawerMenu(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Visibility(
          visible: !isLoading && (subjects.isNotEmpty || creatingSubject),
          replacement: Center(
            child: Visibility(
              visible: isLoading,
              replacement: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: SvgPicture.asset(
                      "assets/images/no-content.svg", 
                      width: MediaQuery.of(context).size.width * .4
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      "No subjects yet",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 22, color: Theme.of(context).textTheme.bodyMedium!.color),
                    ),
                  )
                ],
              ),
              child: SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(
                  color: Theme.of(context).textTheme.bodyMedium!.color,
                ),
              ),
            ),
          ),
          child: NotificationListener<ScrollEndNotification>(
            onNotification: (notification) {
              if (notification.metrics.pixels == notification.metrics.maxScrollExtent) {
                if (!creatingSubject) {
                  getSubjects(requestMore: true);
                }
              }
              return false;
            },
            child: RefreshIndicator(
              color: Colors.black,
              backgroundColor: Colors.white,
              onRefresh: () async {
                await getSubjects(isRefresh: true);
              },
              child: ListView.builder(
                controller: scrollController,
                itemCount: subjects.length + 1,
                itemBuilder: (context, index) {
                  if (index == subjects.length) {
                    return isLoadingMore 
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.all(20),
                              child: SizedBox(
                                width: 30,
                                height: 30,
                                child: CircularProgressIndicator(color: Colors.blue),
                              ),
                            ),
                          )
                        : Visibility(
                            visible: creatingSubject,
                            replacement: const SizedBox(height: 40),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Container(
                                height: 65,
                                margin: const EdgeInsets.only(top: 10),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).floatingActionButtonTheme.backgroundColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: TextField(
                                      cursorColor: Theme.of(context).hintColor,
                                      onSubmitted: (value) async {
                                        setState(() {
                                          creatingSubject = false;
                                          _controller.text = "";
                                        });
                                        await createSubject(SubjectModel(subjectName: value));
                                      },
                                      autofocus: creatingSubject,
                                      maxLength: 50,
                                      controller: _controller,
                                      style: TextStyle(fontSize: 20, color: Theme.of(context).textTheme.bodyMedium!.color),
                                      decoration: InputDecoration(
                                        hintText: "Add a subject",
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
                                  ),
                                ),
                              ),
                            ),
                          );
                  }
                  
                  final subject = subjects[index];
                  return SubjectContainer(subject: subject);
                },
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: Visibility(
        visible: !creatingSubject,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(15),
            gradient: Styles.linearGradient,
          ),
          child: FloatingActionButton(
            backgroundColor: Theme.of(context).floatingActionButtonTheme.backgroundColor,
            onPressed: () {
              setState(() {
                creatingSubject = true;
              });
              scrollToEndAndFocus();
            },
            tooltip: 'Create new subject',
            child: Icon(Icons.add, color: Theme.of(context).textTheme.bodyMedium!.color),
          ),
        ),
      ),
    );
  }
}