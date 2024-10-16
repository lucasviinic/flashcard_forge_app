import 'dart:async';

import 'package:flashcard_forge_app/models/SubjectModel.dart';
import 'package:flashcard_forge_app/models/UserModel.dart';
import 'package:flashcard_forge_app/providers.dart';
import 'package:flashcard_forge_app/services/repositories/auth_repo.dart';
import 'package:flashcard_forge_app/services/repositories/preferences_repo.dart';
import 'package:flashcard_forge_app/services/repositories/subject_repo.dart';
import 'package:flashcard_forge_app/widgets/DrawerMenu.dart';
import 'package:flashcard_forge_app/widgets/SubjectContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flashcard_forge_app/utils/constants.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController _controller;
  late StreamSubscription<bool> keyboardSubscription;
  late Future<UserModel?> _userFuture;
  bool isSearching = false;

  final FocusNode _focusNode = FocusNode();

  bool loading = false;
  bool creatingSubject = false;
  List<SubjectModel> subjects = [];

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email'
    ]
  );

  void setLoading(bool value) {
    setState(() {
      loading = value;
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
    setLoading(true);
    setLoading(false);
  }

  Future<void> getSubjects() async {
    setLoading(true);
    try {
      List<SubjectModel>? subjects_ = await SubjectRepository().fetchSubjects();
      setState(() {
        subjects =  subjects_!;
      });
    } catch (e) {
      //se acontecer um erro lanço um modal aqui
    }
    await Future.delayed(const Duration(seconds: 3));
    setLoading(false);
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

  Future<UserModel?> _fetchUser() async {
    final authRepo = AuthRepository();
    return await authRepo.getStoredUser();
  }

  @override
  void initState() {
    super.initState();
    _userFuture = _fetchUser();
    _controller = TextEditingController();
    KeyboardVisibilityController().onChange.listen((bool visible) {
      if (!visible && creatingSubject) {
        showConfirmModal();
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
        actions: [
          Consumer<AuthProvider>(
            builder: (context, authProvider, child) {
              if (authProvider.currentUser != null) {
                return Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: PopupMenuButton<int>(
                    color: Theme.of(context).popupMenuTheme.color,
                    icon: CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(authProvider.currentUser!.photoUrl!),
                    ),
                    offset: const Offset(-20, 45),
                    iconSize: 40,
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem<int>(
                          value: 0,
                          child: Row(
                            children: [
                              Icon(Icons.account_circle_outlined, color: Theme.of(context).textTheme.bodyMedium!.color),
                              const SizedBox(width: 8),
                              Text(
                                "My account",
                                style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color),
                              ),
                            ],
                          ),
                        ),
                        PopupMenuItem<int>(
                          value: 1,
                          onTap: () => authProvider.signOutFromGoogle(),
                          child: Row(
                            children: [
                              Icon(Icons.logout, color: Theme.of(context).textTheme.bodyMedium!.color),
                              const SizedBox(width: 8),
                              Text(
                                "Log out",
                                style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color),
                              ),
                            ],
                          ),
                        ),
                      ];
                    },
                    onSelected: (value) {},
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
      drawer: const DrawerMenu(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Visibility(
          visible: !loading && (subjectList.isNotEmpty || creatingSubject),
          replacement: Center(
            child: Visibility(
              visible: loading,
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: TextField(
                    cursorColor: Theme.of(context).hintColor,
                    style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color),
                    decoration: InputDecoration(
                      hintText: "Search term",
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
                  ),
                ),
                ...subjectList.map((subject) {
                  return SubjectContainer(subject: subject);
                }),
                Visibility(
                  visible: creatingSubject,
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
              ],
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
            gradient: Styles.linearGradient
          ),
          child: FloatingActionButton(
            backgroundColor: Theme.of(context).floatingActionButtonTheme.backgroundColor,
            onPressed: () {
              setState(() {
                creatingSubject = true;
              });
            },
            tooltip: 'Create new subject',
            child: Icon(Icons.add, color: Theme.of(context).textTheme.bodyMedium!.color),
          ),
        ),
      ),
    );
  }
}