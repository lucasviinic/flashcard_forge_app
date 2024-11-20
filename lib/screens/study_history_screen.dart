import 'package:flashcard_forge_app/models/FlashcardModel.dart';
import 'package:flashcard_forge_app/models/StudySessionModel.dart';
import 'package:flashcard_forge_app/utils/constants.dart';
import 'package:flashcard_forge_app/widgets/DrawerMenu.dart';
import 'package:flashcard_forge_app/widgets/StudySessionCard.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StudyHistoryScreen extends StatefulWidget {
  const StudyHistoryScreen({super.key});

  @override
  State<StudyHistoryScreen> createState() => _StudyHistoryScreenState();
}

class _StudyHistoryScreenState extends State<StudyHistoryScreen> {
  final List<Map<String, dynamic>> studyHistory = [
    {
      "created_at": DateTime.parse("2024-08-13T14:55:23.527272"),
      "topic_name": "Linear Algebra",
      "score": {"total": 15, "max_score": 20},
      "time_spent": "00:25:00",
      "difficulty_breakdown": {"easy": 7, "medium": 5, "hard": 3}
    },
    {
      "created_at": DateTime.parse("2024-08-13T14:55:23.527272"),
      "topic_name": "Linear Algebra",
      "score": {"total": 15, "max_score": 20},
      "time_spent": "00:25:00",
      "difficulty_breakdown": {"easy": 7, "medium": 5, "hard": 3}
    },
    {
      "created_at": DateTime.parse("2024-08-12T09:15:45.527272"),
      "topic_name": "Cryptography",
      "score": {"total": 13, "max_score": 20},
      "time_spent": "00:21:00",
      "difficulty_breakdown": {"easy": 7, "medium": 4, "hard": 2}
    },
    {
      "created_at": DateTime.parse("2024-08-13T14:55:23.527272"),
      "topic_name": "Linear Algebra",
      "score": {"total": 15, "max_score": 20},
      "time_spent": "00:25:00",
      "difficulty_breakdown": {"easy": 7, "medium": 5, "hard": 3}
    },
    {
      "created_at": DateTime.parse("2024-08-14T18:45:30.527272"),
      "topic_name": "Parallel Computing",
      "score": {"total": 14, "max_score": 20},
      "time_spent": "00:24:00",
      "difficulty_breakdown": {"easy": 7, "medium": 4, "hard": 3}
    },
    {
      "created_at": DateTime.parse("2024-08-14T20:15:10.527272"),
      "topic_name": "Computer Graphics",
      "score": {"total": 13, "max_score": 20},
      "time_spent": "00:22:00",
      "difficulty_breakdown": {"easy": 6, "medium": 5, "hard": 2}
    }
  ];

  List<StudySessionModel> mockStudySessions = [
    StudySessionModel(
      subjectId: 1,
      topicName: "Computer Graphics",
      topicId: 101,
      correctAnswerCount: 10,
      incorrectAnswerCount: 3,
      totalQuestions: 13,
      totalTimeSpent: "00:22:00",
      easyQuestionCount: 6,
      mediumQuestionCount: 5,
      hardQuestionCount: 2,
      easyQuestions: [
        FlashcardModel(id: "f47ac10b-58cc-4372-a567-0e02b2c3d479", question: "Easy Q1", answer: "A1"),
      ],
      mediumQuestions: [
        FlashcardModel(id: "c9bf9e57-1685-4c89-bafb-ff5af830be8a", question: "Medium Q1", answer: "A2"),
      ],
      hardQuestions: [
        FlashcardModel(id: "a57b38e2-6473-4973-8bc7-e0a32e53c08b", question: "Hard Q1", answer: "A3"),
      ],
      createdAt: DateTime.parse("2024-08-14T20:15:10.527272"),
    ),
    StudySessionModel(
      subjectId: 2,
      topicName: "Data Structures",
      topicId: 102,
      correctAnswerCount: 8,
      incorrectAnswerCount: 4,
      totalQuestions: 12,
      totalTimeSpent: "00:18:30",
      easyQuestionCount: 4,
      mediumQuestionCount: 4,
      hardQuestionCount: 4,
      easyQuestions: [
        FlashcardModel(id: "8ec2e30e-f10e-4a4e-8eae-fc57b979c088", question: "Easy Q2", answer: "A4"),
      ],
      mediumQuestions: [
        FlashcardModel(id: "d75ab734-1d8b-4a7d-a7e6-19a7790b9d7f", question: "Medium Q2", answer: "A5"),
      ],
      hardQuestions: [
        FlashcardModel(id: "5f7b50c8-9877-4cb6-b621-22918b53cf32", question: "Hard Q2", answer: "A6"),
      ],
      createdAt: DateTime.parse("2024-08-15T18:00:00.000000"),
    ),
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(
                Icons.menu_rounded,
                color: Theme.of(context).textTheme.bodyMedium!.color,
                size: 30,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        title: Text("Study History", style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color)),
        centerTitle: true
      ),
      drawer: const DrawerMenu(),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: mockStudySessions.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return const Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                "Past study sessions",
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            );
          } else {
            final studySession = mockStudySessions[index - 1];

            BorderRadius borderRadius;
            Border border;

            if (index == 1) {
              borderRadius = const BorderRadius.vertical(top: Radius.circular(10));
              border = Border.all(color: Colors.blueGrey, width: 0.5);
            } else if (index == mockStudySessions.length) {
              borderRadius = const BorderRadius.vertical(bottom: Radius.circular(10));
              border = const Border(
                left: BorderSide(color: Colors.blueGrey, width: 0.5),
                right: BorderSide(color: Colors.blueGrey, width: 0.5),
                bottom: BorderSide(color: Colors.blueGrey, width: 0.5)
              );
            } else {
              borderRadius = const BorderRadius.vertical(bottom: Radius.circular(10));
              border = const Border(
                left: BorderSide(color: Colors.blueGrey, width: 0.5),
                right: BorderSide(color: Colors.blueGrey, width: 0.5),
              );
            }

            return Container(
              decoration: BoxDecoration(
                border: border,
                borderRadius: borderRadius,
              ),
              child: StudySessionCard(session: studySession),
            );
          }
        },
      )
    );
  }
}
