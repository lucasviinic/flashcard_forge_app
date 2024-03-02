import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key,required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
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
        title: Image.asset('assets/images/logo-v1.png', height: 45, width: 45),
        centerTitle: true,
        actions: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.search, size: 35),
            ),
        ],
      ),
      drawer: const Drawer(backgroundColor: Color.fromRGBO(57, 167, 255, 1),),
      body: Container(
        color: const Color.fromRGBO(224, 244, 255, 1),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}