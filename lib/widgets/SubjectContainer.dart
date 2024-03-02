import 'package:flutter/material.dart';

class SubjectContainer extends StatefulWidget {
  const SubjectContainer({super.key, required this.title});

  final String title;

  @override
  State<SubjectContainer> createState() => _SubjectContainerState();
}

class _SubjectContainerState extends State<SubjectContainer> {
  bool showDropdown = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 70,
          margin: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 180, 217, 255),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    showDropdown = !showDropdown;
                  });
                },
                child: const Icon(Icons.arrow_right_rounded, size: 50),
              ),
              Text(widget.title, style: const TextStyle(fontSize: 20)),
              const Spacer(),
              PopupMenuButton(
                  color: const Color.fromRGBO(135, 196, 255, 1),
                  itemBuilder: (context) {
                    return [
                      const PopupMenuItem<int>(
                        value: 0,
                        child: Text("Rename"),
                      ),
                      const PopupMenuItem<int>(
                        value: 1,
                        child: Text("Delete"),
                      ),
                    ];
                  },
                  onSelected: (value) {
                    if (value == 0) {
                      print("Rename menu is selected.");
                    } else if (value == 1) {
                      print("Delete menu is selected.");
                    }
                  })
            ],
          ),
        ),
        Visibility(
          visible: showDropdown,
          child: AnimatedContainer(
            width: MediaQuery.of(context).size.width,
            duration: const Duration(seconds: 3),
            curve: Curves.fastOutSlowIn,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text("Topic 1"),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text("Topic 2"),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text("Topic 3"),
                ),
              ],
            ),
          )
        ),
      ],
    );
  }
}
