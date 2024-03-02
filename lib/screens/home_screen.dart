import 'package:flashcard_forge_app/widgets/SubjectContainer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _createSubject() {
    return;
  }

  final List<String> subjects = ['Biologia', 'História', 'Filosofia'];

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
        title: Image.asset('assets/images/logo-v1.png', height: 45, width: 45),
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
          child: Column(
            children: [
              const Divider(color: Colors.black),
              ListView.builder(
                shrinkWrap: true,
                itemCount: subjects.length,
                itemBuilder: (BuildContext context, int index) {
                  return SubjectContainer(title: subjects[index]);
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createSubject,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
