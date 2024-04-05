import 'package:flashcard_forge_app/models/FlashcardModel.dart';
import 'package:flashcard_forge_app/utils/constants.dart';
import 'package:flashcard_forge_app/widgets/FlashcardPreview.dart';
import 'package:flutter/material.dart';

class FlashcardScreen extends StatefulWidget {
  const FlashcardScreen({super.key, this.flashcards, this.title});

  final String? title;
  final List<FlashcardModel>? flashcards;

  @override
  State<FlashcardScreen> createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  List<FlashcardModel> flashcardsMock = [
    FlashcardModel(
      id: 1,
      userId: 1,
      subjectId: 1,
      topicId: 1,
      question: "Qual peça de Shakespeare apresenta o famoso monólogo 'Ser ou não ser'?",
      answer: "Hamlet",
      lastResponse: false,
      imageUrl: null,
    ),
    FlashcardModel(
      id: 2,
      userId: 1,
      subjectId: 1,
      topicId: 1,
      question: "Qual é o nome da filha de Shakespeare?",
      answer: "Susanna",
      lastResponse: false,
      imageUrl: null,
    ),
    FlashcardModel(
      id: 3,
      userId: 1,
      subjectId: 1,
      topicId: 1,
      question: "Qual é a comédia de Shakespeare que envolve uma disputa amorosa?",
      answer: "Sonho de uma Noite de Verão",
      lastResponse: false,
      imageUrl: null,
    ),
    FlashcardModel(
      id: 4,
      userId: 1,
      subjectId: 1,
      topicId: 1,
      question: "Qual é o nome do rei em 'Hamlet'?",
      answer: "Claudius",
      lastResponse: false,
      imageUrl: null,
    ),
    FlashcardModel(
      id: 5,
      userId: 1,
      subjectId: 1,
      topicId: 1,
      question: "Quem mata Romeu em 'Romeu e Julieta'?",
      answer: "Paris",
      lastResponse: false,
      imageUrl: null,
    ),
    FlashcardModel(
      id: 6,
      userId: 1,
      subjectId: 1,
      topicId: 1,
      question: "Como morre Julieta?",
      answer: "Ela se mata com uma adaga",
      lastResponse: false,
      imageUrl: null,
    ),
    FlashcardModel(
      id: 7,
      userId: 1,
      subjectId: 1,
      topicId: 1,
      question: "Quem é o mentor e guia espiritual de Hamlet?",
      answer: "O fantasma de seu pai",
      lastResponse: false,
      imageUrl: null,
    ),
    FlashcardModel(
      id: 8,
      userId: 1,
      subjectId: 1,
      topicId: 1,
      question: "Qual é o nome do irmão de Otelo que o trai?",
      answer: "Iago",
      lastResponse: false,
      imageUrl: null,
    ),
    FlashcardModel(
      id: 9,
      userId: 1,
      subjectId: 1,
      topicId: 1,
      question: "Qual é a tragédia de Shakespeare ambientada em Veneza?",
      answer: "Otelo",
      lastResponse: false,
      imageUrl: null,
    ),
    FlashcardModel(
      id: 10,
      userId: 1,
      subjectId: 1,
      topicId: 1,
      question: "Como termina 'A Tempestade'?",
      answer: "Com o perdão do protagonista Prospero",
      lastResponse: false,
      imageUrl: null,
    ),
    FlashcardModel(
      id: 11,
      userId: 1,
      subjectId: 1,
      topicId: 1,
      question: "Qual é o nome do antagonista em 'Rei Lear'?",
      answer: "Edmund",
      lastResponse: false,
      imageUrl: null,
    ),
    FlashcardModel(
      id: 12,
      userId: 1,
      subjectId: 1,
      topicId: 1,
      question: "Qual peça de Shakespeare é frequentemente considerada uma das suas mais sombrias?",
      answer: "Macbeth",
      lastResponse: false,
      imageUrl: null,
    ),
    FlashcardModel(
      id: 13,
      userId: 1,
      subjectId: 1,
      topicId: 1,
      question: "Qual é o nome do duque em 'Muito Barulho por Nada'?",
      answer: "Pedro",
      lastResponse: false,
      imageUrl: null,
    ),
    FlashcardModel(
      id: 14,
      userId: 1,
      subjectId: 1,
      topicId: 1,
      question: "Qual é o nome do príncipe em 'Henrique V'?",
      answer: "Henrique",
      lastResponse: false,
      imageUrl: null,
    ),
    FlashcardModel(
      id: 15,
      userId: 1,
      subjectId: 1,
      topicId: 1,
      question: "Quem é conhecido por dizer 'Tudo o que reluz não é ouro'?",
      answer: "Falstaff",
      lastResponse: false,
      imageUrl: null,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.menu_rounded,
                color: AppColors.whiteColor,
                size: 30,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        title: Row(
          children: [
            Text(
              widget.title!.length > 13 ? "${widget.title!.substring(0, 12)}..." : widget.title!,
              style: const TextStyle(color: AppColors.whiteColor),
            ),
          ],
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: Icon(Icons.play_arrow_rounded, size: 40, color: AppColors.whiteColor),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Icon(Icons.upload_file_rounded, size: 30, color: AppColors.whiteColor),
          ),
        ],
      ),
      drawer: const Drawer(
        backgroundColor: AppColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
              child: Row(
                children: [
                  SizedBox(width: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text("10", style: TextStyle(fontSize: 16, color: AppColors.blueNeutral)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text("4", style: TextStyle(fontSize: 16, color: AppColors.greenEasy)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text("6", style: TextStyle(fontSize: 16, color: AppColors.redHard)),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text("Last: 24%", style: TextStyle(fontSize: 16, color: AppColors.redHard)),
                  ),
                ],
              ),
            ),
            Flexible(
              child: GridView.builder(
                itemCount: flashcardsMock.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return FlashcardPreview(flashcardsMock[index]);
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.secondaryColor,
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add, color: AppColors.whiteColor),
      ),
    );
  }
}
