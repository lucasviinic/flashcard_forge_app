import 'dart:async';

import 'package:flashcard_forge_app/models/FlashcardModel.dart';
import 'package:flashcard_forge_app/services/mocks.dart';
import 'package:flashcard_forge_app/utils/constants.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class StudySession extends StatefulWidget {
  final List<FlashcardModel>? flashcardList;

  const StudySession({super.key, this.flashcardList});

  @override
  State<StudySession> createState() => _StudySessionState();
}

class _StudySessionState extends State<StudySession> {
  GlobalKey<FlipCardState> flipCardKey = GlobalKey<FlipCardState>();

  List<FlashcardModel> flashcardList = flashcardListMock;
  int currentIndex = 0;
  double progress = 0.0;
  bool sessionCompleted = false;

  void updateProgress() {
    double percent = 1 / flashcardList.length;
    if (progress + percent < 1) {
      progress += percent;
    }
  }

  late Timer _timer;
  int _secondsElapsed = 0;
  String get timerText =>
      '${(_secondsElapsed ~/ 3600).toString().padLeft(2, '0')}:'
      '${((_secondsElapsed % 3600) ~/ 60).toString().padLeft(2, '0')}:'
      '${(_secondsElapsed % 60).toString().padLeft(2, '0')}';

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _secondsElapsed++;
      });
    });
  }

  void _stopTimer() {
    _timer.cancel();
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(170, 0, 0, 0),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(seconds: 1),
                curve: Curves.easeInOut,
                alignment: Alignment.bottomCenter,
                transform: Matrix4.translationValues(0.0, sessionCompleted ? 0.0 : MediaQuery.of(context).size.height, 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Feedback", style: TextStyle(fontSize: 35)),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("🎯 Score: 7/20", style: TextStyle(fontSize: 20)),
                        Text("⌛ Time: $timerText", style: TextStyle(fontSize: 20)),
                        Text("🥱 Easy: 4/4", style: TextStyle(fontSize: 20, color: AppColors.greenEasy)),
                        Text("😐 Medium: 3/10", style: TextStyle(fontSize: 20, color: AppColors.blueNeutral)),
                        Text("😡 Hard: 0/6", style: TextStyle(fontSize: 20, color: AppColors.redHard)),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          Visibility(
            visible: !sessionCompleted,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(timerText, style: const TextStyle(fontSize: 22)),
                      ]
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: FlipCard(
                    key: flipCardKey,
                    fill: Fill.fillBack,
                    direction: FlipDirection.HORIZONTAL,
                    side: CardSide.FRONT,
                    front: Container(
                      decoration: BoxDecoration(
                        color: AppColors.secondaryColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(bottom: 30),
                            child: Text("Question:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 18),
                              child: Text(
                                flashcardList[currentIndex].question!,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: flashcardList[currentIndex].question!.length >= 50 ? 17 : 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    back: Container(
                      decoration: BoxDecoration(
                        color: AppColors.secondaryColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(bottom: 30),
                            child: Text("Answer:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 18),
                              child: Text(
                                flashcardList[currentIndex].answer!,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: flashcardList[currentIndex].answer!.length >= 50 ? 17 : 20),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .5,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (currentIndex < flashcardList.length - 1) {
                                        flipCardKey.currentState?.toggleCardWithoutAnimation();
                                        currentIndex++;
                                      } else {
                                        _stopTimer();
                                        sessionCompleted = true;
                                      }
                                      updateProgress();
                                    });
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(
                                            color: Colors.green,
                                            width: 2
                                        )
                                    ),
                                    child: const Icon(Icons.check, color: Colors.green),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (currentIndex < flashcardList.length - 1) {
                                        flipCardKey.currentState?.toggleCardWithoutAnimation();
                                        currentIndex++;
                                      } else {
                                        _stopTimer();
                                        sessionCompleted = true;
                                      }
                                      updateProgress();
                                    });
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(
                                            color: Colors.red,
                                            width: 2
                                        )
                                    ),
                                    child: Icon(Icons.close, color: Colors.red[700]),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                LinearPercentIndicator(
                  alignment: MainAxisAlignment.center,
                  barRadius: const Radius.circular(50),
                  width: MediaQuery.of(context).size.width * .8,
                  lineHeight: 20,
                  percent: progress,
                  backgroundColor: Colors.white,
                  animateFromLastPercent: true,
                  animation: true,
                  animationDuration: 500,
                  progressColor: Colors.green,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
