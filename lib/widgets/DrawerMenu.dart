import 'package:flashcard_forge_app/utils/constants.dart';
import 'package:flashcard_forge_app/widgets/ThemeSwitch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({super.key});

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Styles.primaryColor,
      child: Column(
        children: [
          ShaderMask(
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.8),
                  Colors.black.withOpacity(0.7),
                  Colors.transparent
                ],
              ).createShader(bounds);
            },
            blendMode: BlendMode.dstIn,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/flashcards-menu-header.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              height: MediaQuery.of(context).size.height * .2,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 15, top: 15, right: 15),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: [
                          Image.asset("assets/images/crown.png", width: 25, height: 25),
                          const SizedBox(width: 10),
                          const Text("Get the premium", 
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              color: Colors.amber
                            )
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: [
                          SvgPicture.asset("assets/images/subjects-icon.svg", width: 35, height: 35),
                          const SizedBox(width: 10),
                          const Text("View subjects", style: TextStyle(color: Colors.white))
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: GestureDetector(
                      onTap: () {},
                      child: const Row(
                        children: [
                          Icon(Icons.history, color: Colors.white, size: 30),
                          SizedBox(width: 10),
                          Text("Study sessions history", style: TextStyle(color: Colors.white))
                        ],
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 10), child: ThemeSwitch()),
                  const Padding(padding: EdgeInsets.only(bottom: 15), child: Divider(color: Colors.white)),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: [
                          SvgPicture.asset("assets/images/about.svg", width: 25, height: 25),
                          const SizedBox(width: 10),
                          const Text("About", style: TextStyle(color: Colors.white))
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: GestureDetector(
                      onTap: () {},
                      child: const Row(
                        children: [
                          Icon(Icons.feedback_outlined, color: Colors.white, size: 25),
                          SizedBox(width: 10),
                          Text("Feedback", style: TextStyle(color: Colors.white))
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25),
                    child: GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: [
                          SvgPicture.asset("assets/images/google_icon_dark.svg"),
                          const SizedBox(width: 12),
                          const Text("Sign in with Google", style: TextStyle(fontWeight: FontWeight.w800))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}