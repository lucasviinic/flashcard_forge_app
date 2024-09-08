import 'package:flashcard_forge_app/models/AuthTokenModel.dart';
import 'package:flashcard_forge_app/services/repositories/auth_repo.dart';
import 'package:flashcard_forge_app/widgets/FeedbackModal.dart';
import 'package:flashcard_forge_app/widgets/ThemeSwitch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({super.key});

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  GoogleSignInAccount? _currentUser;
  bool isAuthorized = false;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'openid',
      'profile',
    ]
  );

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        throw 'Login has been cancelled';
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final String? accessToken = googleAuth.accessToken;

      await signOutFromGoogle();

      if (accessToken == null) {
        throw 'Invalid Token (idToken)';
      }
      
      AuthTokenModel? response = await AuthRepository().authenticate(accessToken);
    
      if (response != null) {
        print("User authenticated:");
        print('access_token: ${response.accessToken}');
        print('refresh_token: ${response.refreshToken}');
      } else {
        throw 'Failed to authenticate.';
      }
    } catch (e) {
      await signOutFromGoogle();
      print('Error logging in with Google: $e');
    }
  }

  Future<void> signOutFromGoogle() async {
    try {
      await _googleSignIn.disconnect().then((_) async=> await _googleSignIn.signOut());
      print('User logged out successfully');
    } catch (e) {
      print('Error logging out from Google: $e');
    }
  }

  @override
  void initState() {
    super.initState();

    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) async {
      bool isAuthorized = account != null;

      setState(() {
        _currentUser = account;
        isAuthorized = isAuthorized;
      });

      print("_currentUser: $_currentUser");
      print("isAuthorized: $isAuthorized");
    });

    _googleSignIn.signInSilently();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.primary,
      //backgroundColor: Styles.primaryColor,
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
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(context, '/', (Route<dynamic> route) => false);
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset("assets/images/subjects-icon.svg", width: 35, height: 35, color: Theme.of(context).textTheme.bodyMedium!.color),
                          const SizedBox(width: 10),
                          Text("View subjects", style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color))
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.popAndPushNamed(context, '/history');
                      },
                      child: Row(
                        children: [
                          Icon(Icons.history, color: Theme.of(context).textTheme.bodyMedium!.color, size: 30),
                          const SizedBox(width: 10),
                          Text("Study sessions history", style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color))
                        ],
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 10), child: ThemeSwitch()),
                  Padding(padding: const EdgeInsets.only(bottom: 15), child: Divider(color: Theme.of(context).textTheme.bodyMedium!.color)),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.popAndPushNamed(context, '/about');
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset("assets/images/about.svg", width: 25, height: 25, color: Theme.of(context).textTheme.bodyMedium!.color),
                          const SizedBox(width: 10),
                          Text("About", style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color))
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const FeedbackModal();
                          },
                        );
                      },
                      child: Row(
                        children: [
                          Icon(Icons.feedback_outlined, color: Theme.of(context).textTheme.bodyMedium!.color, size: 25),
                          const SizedBox(width: 10),
                          Text("Feedback", style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color))
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25),
                    child: GestureDetector(
                      onTap: _currentUser != null ? signOutFromGoogle : signInWithGoogle,
                      child: Row(
                        children: [
                          Visibility(
                            visible: Theme.of(context).brightness == Brightness.light,
                            replacement: SvgPicture.asset("assets/images/google_icon_dark.svg"),
                            child: SvgPicture.asset("assets/images/google_icon_light.svg"),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            _currentUser != null ? "Sign out from Google" : "Sign in with Google",
                            style: const TextStyle(fontWeight: FontWeight.w800),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}