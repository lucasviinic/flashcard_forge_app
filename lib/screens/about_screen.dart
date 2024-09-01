import 'package:flashcard_forge_app/utils/constants.dart';
import 'package:flashcard_forge_app/widgets/DrawerMenu.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Styles.primaryColor,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.menu_rounded,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        title: const Text("About", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.all(10),
            child: Icon(Icons.search, size: 30, color: Colors.white),
          ),
        ],
      ),
      drawer: const DrawerMenu(),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: const EdgeInsets.only(top: 25),
            width: MediaQuery.of(context).size.width * .88,
            child: const Column(
              children: [
                Row(
                  children: [
                    Text("About", style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 20),
                Text("    Ideal para quem deseja otimizar seus estudos de forma organizada e inteligente, com o Flashcard Forge você pode criar flashcards personalizados e utilizar a inteligência artificial para gerar perguntas e respostas a partir de grandes volumes de texto. Estude de forma eficiente, onde e quando quiser, com uma ferramenta projetada para se adaptar às suas necessidades.", style: TextStyle(fontSize: 16.5)),
                SizedBox(height: 20),
                
                Row(
                  children: [
                    Text("Minimalista", style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 20),
                Text("    O Flashcard Forge apresenta um design limpo e simples, reduzindo estímulos visuais para manter seu foco no estudo. A interface intuitiva elimina distrações, proporcionando uma experiência de aprendizado mais concentrada e eficiente.", style: TextStyle(fontSize: 16.5)),
                SizedBox(height: 20),
                
                Row(
                  children: [
                    Text("Organização Personalizada", style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 20),
                Text("    Crie flashcards manuais e adapte-os às suas necessidades específicas de estudo. Separe seus conteúdos por assuntos e tópicos, garantindo que você sempre tenha os materiais certos à mão, organizados da maneira que preferir.", style: TextStyle(fontSize: 16.5)),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text("Aprendizado Inteligente com IA", style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 20),
                Text("    Aproveite o poder da inteligência artificial para gerar flashcards automaticamente. Basta fornecer grandes volumes de texto, seja colando diretamente no app ou fazendo upload de arquivos, e nossa IA avançada transformará essas informações em perguntas e respostas otimizadas, facilitando ainda mais sua preparação para exames ou reforço de conteúdos.", style: TextStyle(fontSize: 16.5)),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text("Flexibilidade e Conveniência", style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 20),
                Text("    O Flashcard Forge foi desenvolvido para ser usado onde quer que você esteja, oferecendo flexibilidade e conveniência, seja no transporte, em casa, ou durante intervalos entre aulas. Com uma interface intuitiva e fácil de usar, o foco fica sempre no que realmente importa: o aprendizado.", style: TextStyle(fontSize: 16.5)),
                SizedBox(height: 20)
              ]
            ),
          ),
        ),
      ),
    );
  }
}