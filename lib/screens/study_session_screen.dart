import 'dart:async';

import 'package:flashcard_forge_app/models/FlashcardModel.dart';
import 'package:flashcard_forge_app/services/mocks.dart';
import 'package:flashcard_forge_app/utils/constants.dart';
import 'package:flashcard_forge_app/widgets/Flashcard.dart';
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
  List<FlashcardModel> flashcardList = flashcardListMock;
  int currentIndex = 0;
  double progress = 0.0;

  GlobalKey<FlipCardState> flipCardKey = GlobalKey<FlipCardState>();

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
    // Aqui você pode realizar qualquer ação necessária após parar o timer
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
      body: Column(
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
                    )),
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
                    )),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              setState(() {
                                if (currentIndex < flashcardList.length-1) {
                                  flipCardKey.currentState?.toggleCardWithoutAnimation();
                                  currentIndex++;
                                } else {
                                  _stopTimer();
                                }
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
                                if (currentIndex < flashcardList.length-1) {
                                  flipCardKey.currentState?.toggleCardWithoutAnimation();
                                  currentIndex++;
                                } else {
                                  _stopTimer();
                                }
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
            percent: (currentIndex+1) / flashcardList.length,
            backgroundColor: Colors.white,
            animateFromLastPercent: true,
            animation: true,
            animationDuration: 500,
            progressColor: Colors.green,
          ),
        ],
      ),
    );
  }
}