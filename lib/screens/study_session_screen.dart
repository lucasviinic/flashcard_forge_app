import 'dart:async';

import 'package:flashcard_forge_app/models/FlashcardModel.dart';
import 'package:flashcard_forge_app/models/StudySessionModel.dart';
import 'package:flashcard_forge_app/providers/study_provider.dart';
import 'package:flashcard_forge_app/utils/constants.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class StudySession extends StatefulWidget {
  final int? subjectId;
  final int? topicId;
  final List<FlashcardModel>? flashcardList;

  const StudySession({super.key, this.flashcardList, this.subjectId, this.topicId});

  @override
  State<StudySession> createState() => _StudySessionState();
}

class _StudySessionState extends State<StudySession> {
  GlobalKey<FlipCardState> flipCardKey = GlobalKey<FlipCardState>();

  int currentIndex = 0;
  double progress = 0.0;
  bool sessionCompleted = false;

  int correctAnswerCount = 0;
  int incorrectAnswerCount = 0;

  void saveStudySession() async {
    List<FlashcardModel>? easyQuestions = [];
    List<FlashcardModel>? mediumQuestions = [];
    List<FlashcardModel>? hardQuestions = [];

    for (var flashcard in widget.flashcardList!) {
      if (flashcard.lastResponse == true) {
        switch (flashcard.difficulty) {
          case 0: // Easy
            easyQuestions.add(flashcard);
            break;
          case 1: // Medium
            mediumQuestions.add(flashcard);
            break;
          case 2: // Hard
            hardQuestions.add(flashcard);
            break;
          default:
            break;
        }
      }
    }

    StudySessionModel studySession = StudySessionModel(
      subjectId: widget.subjectId!, 
      topicId: widget.topicId!, 
      correctAnswerCount: correctAnswerCount, 
      incorrectAnswerCount: incorrectAnswerCount, 
      totalQuestions: widget.flashcardList!.length, 
      totalTimeSpent: _timer.toString(), 
      easyQuestionCount: easyQuestions.length, 
      mediumQuestionCount: mediumQuestions.length, 
      hardQuestionCount: hardQuestions.length, 
      easyQuestions: easyQuestions, 
      mediumQuestions: mediumQuestions, 
      hardQuestions: hardQuestions, 
      createdAt: DateTime.now()
    );

    await context.read<StudyProvider>().saveStudySession(studySession);
  }

  void updateProgress() {
    double percent = 1 / widget.flashcardList!.length;
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
                        Text("🥱 Easy: 4/4", style: TextStyle(fontSize: 20, color: Styles.greenEasy)),
                        Text("😐 Medium: 3/10", style: TextStyle(fontSize: 20, color: Styles.blueNeutral)),
                        Text("😡 Hard: 0/6", style: TextStyle(fontSize: 20, color: Styles.redHard)),
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
                  height: MediaQuery.of(context).size.height * 0.45,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: FlipCard(
                    key: flipCardKey,
                    fill: Fill.fillBack,
                    direction: FlipDirection.HORIZONTAL,
                    side: CardSide.FRONT,
                    front: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: Styles.linearGradient
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
                                widget.flashcardList![currentIndex].question!,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: widget.flashcardList![currentIndex].question!.length >= 50 ? 17 : 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    back: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: Styles.linearGradient
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
                                widget.flashcardList![currentIndex].answer!,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: widget.flashcardList![currentIndex].answer!.length >= 50 ? 17 : 20),
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
                                      correctAnswerCount += 1;
                                      if (currentIndex < widget.flashcardList!.length - 1) {
                                        flipCardKey.currentState?.toggleCardWithoutAnimation();
                                        currentIndex++;
                                      } else {
                                        _stopTimer();
                                        sessionCompleted = true;
                                        saveStudySession();
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
                                      incorrectAnswerCount += 1;
                                      if (currentIndex < widget.flashcardList!.length - 1) {
                                        flipCardKey.currentState?.toggleCardWithoutAnimation();
                                        currentIndex++;
                                      } else {
                                        _stopTimer();
                                        sessionCompleted = true;
                                        saveStudySession();
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
