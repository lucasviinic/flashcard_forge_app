import 'package:flashcard_forge_app/models/FlashcardModel.dart';
import 'package:flashcard_forge_app/utils/constants.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

class Flashcard extends StatefulWidget {
  final FlashcardModel? flashcard;
  final bool isSession;

  const Flashcard({super.key, this.flashcard, this.isSession = false});

  @override
  State<Flashcard> createState() => _FlashcardState();
}

class _FlashcardState extends State<Flashcard> {
  FlashcardModel? flashcard;

  @override
  void initState() {
    flashcard = widget.flashcard;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(0),
      backgroundColor: Colors.transparent,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.45,
        width: MediaQuery.of(context).size.width * 0.8,
        child: FlipCard(
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
                  child: Text("Question:", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
                ),
                Center(
                  child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Text(
                    widget.flashcard!.question!,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: widget.flashcard!.question!.length >= 50 ? 17 : 20),
                  ),
                )),
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
                  child: Text("Answer:", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
                ),
                Center(
                  child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Text(
                    widget.flashcard!.answer!,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: widget.flashcard!.answer!.length >= 50 ? 17 : 20),
                  ),
                )),
                Visibility(
                  visible: widget.isSession,
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                height: 55,
                                width: 55,
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
                              onTap: () {},
                              child: Container(
                                height: 55,
                                width: 55,
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
                      )
                    ],
                  )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}