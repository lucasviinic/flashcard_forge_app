import 'dart:async';

import 'package:flashcard_forge_app/models/FlashcardModel.dart';
import 'package:flashcard_forge_app/models/StudySessionModel.dart';
import 'package:flashcard_forge_app/models/TopicModel.dart';
import 'package:flashcard_forge_app/services/repositories/flashcard_repo.dart';
import 'package:flashcard_forge_app/services/repositories/study_session.dart';
import 'package:flashcard_forge_app/utils/constants.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class StudySession extends StatefulWidget {
  final TopicModel topic;

  const StudySession({super.key, required this.topic});

  @override
  State<StudySession> createState() => _StudySessionState();
}

class _StudySessionState extends State<StudySession> {
  List<FlashcardModel>? flashcardList;
  GlobalKey<FlipCardState> flipCardKey = GlobalKey<FlipCardState>();

  int currentIndex = 0;
  double progress = 0.0;
  bool sessionCompleted = false;

  int correctAnswerCount = 0;
  int incorrectAnswerCount = 0;

  int? easyQuestionCount;
  int? correctEasyQuestionsCount;
  int? mediumQuestionCount;
  int? correctMediumQuestionsCount;
  int? hardQuestionCount;
  int? correctHardQuestionsCount;

  Map<int, int> correctAnswersByDifficulty = {0: 0, 1: 0, 2: 0};

  int? totalQuestions;
  String? totalTimeSpent;

  void saveStudySession() async {
    List<FlashcardModel>? easyQuestions = [];
    List<FlashcardModel>? mediumQuestions = [];
    List<FlashcardModel>? hardQuestions = [];

    for (var flashcard in flashcardList!) {
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

    setState(() {
      totalQuestions = flashcardList!.length;
      easyQuestionCount = easyQuestions.length;
      mediumQuestionCount = mediumQuestions.length; 
      hardQuestionCount = hardQuestions.length;
    });

    StudySessionModel studySession = StudySessionModel(
      subjectId: widget.topic.subjectId,
      topicName: widget.topic.topicName,
      topicId: widget.topic.id!, 
      correctAnswerCount: correctAnswerCount, 
      incorrectAnswerCount: incorrectAnswerCount, 
      totalQuestions: totalQuestions!, 
      totalTimeSpent: timerText, 
      easyQuestionCount: easyQuestionCount!, 
      mediumQuestionCount: mediumQuestionCount!, 
      hardQuestionCount: hardQuestionCount!
    );

    await StudySessionRepository().saveStudySession(studySession);
  }

  Future<void> getAllFlashcards() async {
    FlashcardRepository().fetchFlashcards(widget.topic.id!).then((response) {
      setState(() {
        flashcardList = response?.flashcards;
      });
      _startTimer();
    });
  }

  void updateProgress() {
    double percent = 1 / flashcardList!.length;
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
    getAllFlashcards();
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
                    const Text("Feedback", style: TextStyle(fontSize: 35, color: Colors.white)),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "🎯 Score: $correctAnswerCount/$totalQuestions",
                          style: const TextStyle(fontSize: 20, color: Colors.white)),
                        Text(
                          "⌛ Time: $timerText",
                          style: const TextStyle(fontSize: 20, color: Colors.white)),
                        Text(
                          "🥱 Easy: ${correctAnswersByDifficulty[0]}/$easyQuestionCount",
                          style: const TextStyle(fontSize: 20, color: Styles.greenEasy)),
                        Text(
                          "😐 Medium: ${correctAnswersByDifficulty[1]}/$mediumQuestionCount",
                          style: const TextStyle(fontSize: 20, color: Styles.blueNeutral)),
                        Text(
                          "😡 Hard: ${correctAnswersByDifficulty[2]}/$hardQuestionCount",
                          style: const TextStyle(fontSize: 20, color: Styles.redHard)),
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
                        Text(timerText, style: const TextStyle(fontSize: 22, color: Colors.white)),
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
                        color: Theme.of(context).floatingActionButtonTheme.backgroundColor,
                        borderRadius: BorderRadius.circular(30),
                        //gradient: Styles.linearGradient
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
                              child: flashcardList != null
                                ? Text(
                                    flashcardList![currentIndex].question!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: flashcardList![currentIndex].question!.length >= 50 ? 17 : 20,
                                    ),
                                  )
                                : const CircularProgressIndicator(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    back: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).floatingActionButtonTheme.backgroundColor,
                        borderRadius: BorderRadius.circular(30),
                        //gradient: Styles.linearGradient
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
                              child: flashcardList != null
                                  ? Text(
                                      flashcardList![currentIndex].answer!,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: flashcardList![currentIndex].answer!.length >= 50 ? 17 : 20,
                                      ),
                                    )
                                  : const CircularProgressIndicator(),
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
                                      int? difficulty = flashcardList![currentIndex].difficulty;
                                      
                                      if (difficulty != null) {
                                        correctAnswersByDifficulty[difficulty] = (correctAnswersByDifficulty[difficulty] ?? 0) + 1;
                                      }

                                      if (currentIndex < flashcardList!.length - 1) {
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
                                      if (currentIndex < flashcardList!.length - 1) {
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
