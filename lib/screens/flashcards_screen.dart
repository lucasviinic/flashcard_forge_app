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
  List<String> flashcards = [
    "Qual foi a data de nascimento de Shakespeare?",
    "Onde Shakespeare nasceu?",
    "Quais eram os nomes dos pais de Shakespeare?",
    "Qual foi sua primeira peça?",
    "Quantas peças Shakespeare escreveu?",
    "Em quantas categorias as peças de Shakespeare são geralmente divididas?",
    "Qual é sua peça mais famosa?",
    "Quem eram os atores da Companhia de Shakespeare?",
    "Qual é o título completo de 'Romeu e Julieta'?",
    "Quem são os principais personagens de 'Hamlet'?",
    "Em que cidade a maioria das peças de Shakespeare se passa?",
    "Qual é o título do poema mais famoso de Shakespeare?",
    "Quem é considerado o maior rival literário de Shakespeare?",
    "Qual é o nome do teatro onde muitas peças de Shakespeare foram realizadas pela primeira vez?",
    "Em que ano Shakespeare faleceu?",
    "Qual é o título da última peça escrita por Shakespeare?",
    "Quantos filhos Shakespeare teve e quais foram seus nomes?",
    "Qual é sua comédia mais famosa?",
    "Quais são os temas principais das obras de Shakespeare?",
    "Quais são algumas adaptações modernas das peças de Shakespeare?"
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
      body: Column(
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
              itemCount: flashcards.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemBuilder: (BuildContext context, int index) {
                return FlashcardPreview(flashcards[index]);
              },
            ),
          )
        ],
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
