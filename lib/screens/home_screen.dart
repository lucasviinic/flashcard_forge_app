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

  final List<String> topics = ['Topic 1', 'Topic 2', 'Topic 3'];

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
        backgroundColor: Color.fromRGBO(57, 167, 255, 1),
      ),
      body: Container(
        color: const Color.fromRGBO(224, 244, 255, 1),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Divider(color: Colors.black),
              ),
              Container(
                height: 70,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 180, 217, 255),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showMenu(
                          context: context,
                          position: const RelativeRect.fromLTRB(0, 70, 0, 0),
                          items: topics.map((String topic) {
                            return PopupMenuItem<String>(
                              value: topic,
                              child: Text(topic),
                            );
                          }).toList(),
                          elevation: 8.0,
                        );
                      },
                      child: const Icon(Icons.arrow_right_rounded, size: 50),
                    ),
                    const Text("Biologia", style: TextStyle(fontSize: 20)),
                    const Spacer(),
                    const Padding(
                      padding: EdgeInsets.all(15),
                      child: Icon(Icons.menu),
                    )
                  ],
                ),
              )
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
