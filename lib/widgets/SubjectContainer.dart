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
          height: 65,
          margin: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 180, 217, 255),
            borderRadius: showDropdown
              ? const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                )
              : BorderRadius.circular(10)),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    showDropdown = !showDropdown;
                  });
                },
                child: Icon(showDropdown 
                  ? Icons.arrow_drop_down_rounded
                  : Icons.arrow_right_rounded,
                  size: 50
                ),
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
            duration: const Duration(seconds: 5),
            curve: Curves.fastOutSlowIn,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 180, 217, 255),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                )

            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text("Topic 1", style: TextStyle(fontSize: 16)),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text("Topic 2", style: TextStyle(fontSize: 16)),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text("Topic 3", style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          )
        ),
      ],
    );
  }
}
