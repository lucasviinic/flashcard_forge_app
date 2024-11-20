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
    StudySessionModel(
      subjectId: 3,
      topicName: "Algorithms",
      topicId: 103,
      correctAnswerCount: 12,
      incorrectAnswerCount: 1,
      totalQuestions: 13,
      totalTimeSpent: "00:20:00",
      easyQuestionCount: 7,
      mediumQuestionCount: 4,
      hardQuestionCount: 2,
      easyQuestions: [
        FlashcardModel(id: "d115b5b0-82b0-4f26-aef0-f9b7e6a1b4f3", question: "Easy Q3", answer: "A7"),
      ],
      mediumQuestions: [
        FlashcardModel(id: "36f71c93-92b9-4f07-8507-79a67f6cbab1", question: "Medium Q3", answer: "A8"),
      ],
      hardQuestions: [
        FlashcardModel(id: "7840c3b0-00d3-4c8e-b1b0-bd570f3b6bc5", question: "Hard Q3", answer: "A9"),
      ],
      createdAt: DateTime.parse("2024-08-16T10:00:00.000000"),
    ),
    StudySessionModel(
      subjectId: 4,
      topicName: "Operating Systems",
      topicId: 104,
      correctAnswerCount: 9,
      incorrectAnswerCount: 4,
      totalQuestions: 13,
      totalTimeSpent: "00:25:00",
      easyQuestionCount: 5,
      mediumQuestionCount: 6,
      hardQuestionCount: 2,
      easyQuestions: [
        FlashcardModel(id: "8a9b173d-4f30-4e96-b66d-ded9b56c428e", question: "Easy Q4", answer: "A10"),
      ],
      mediumQuestions: [
        FlashcardModel(id: "1f6cf99b-9b61-484d-a6d0-b26d351be428", question: "Medium Q4", answer: "A11"),
      ],
      hardQuestions: [
        FlashcardModel(id: "5c348acc-4f65-4690-bfbc-397ed0c1abff", question: "Hard Q4", answer: "A12"),
      ],
      createdAt: DateTime.parse("2024-08-17T09:30:00.000000"),
    ),
    StudySessionModel(
      subjectId: 5,
      topicName: "Databases",
      topicId: 105,
      correctAnswerCount: 15,
      incorrectAnswerCount: 0,
      totalQuestions: 15,
      totalTimeSpent: "00:30:00",
      easyQuestionCount: 7,
      mediumQuestionCount: 5,
      hardQuestionCount: 3,
      easyQuestions: [
        FlashcardModel(id: "3a1d0458-b601-4f97-9b26-b7bc4e2ae39c", question: "Easy Q5", answer: "A13"),
      ],
      mediumQuestions: [
        FlashcardModel(id: "7b542755-8b24-4789-8f66-b69ed21f9a39", question: "Medium Q5", answer: "A14"),
      ],
      hardQuestions: [
        FlashcardModel(id: "5d8fce32-89b6-4f95-b592-2b35e4f7e4a0", question: "Hard Q5", answer: "A15"),
      ],
      createdAt: DateTime.parse("2024-08-18T08:00:00.000000"),
    ),
    StudySessionModel(
      subjectId: 6,
      topicName: "Discrete Mathematics",
      topicId: 106,
      correctAnswerCount: 11,
      incorrectAnswerCount: 2,
      totalQuestions: 13,
      totalTimeSpent: "00:27:00",
      easyQuestionCount: 6,
      mediumQuestionCount: 5,
      hardQuestionCount: 2,
      easyQuestions: [
        FlashcardModel(id: "9a2b944b-1635-479e-9d0e-5e23247627f2", question: "Easy Q6", answer: "A16"),
      ],
      mediumQuestions: [
        FlashcardModel(id: "ffed04d9-79d3-44da-a4cc-267dbd6fddf6", question: "Medium Q6", answer: "A17"),
      ],
      hardQuestions: [
        FlashcardModel(id: "c6b3e9b5-cb35-406b-b874-d6227d3c2289", question: "Hard Q6", answer: "A18"),
      ],
      createdAt: DateTime.parse("2024-08-19T07:45:00.000000"),
    ),
    StudySessionModel(
      subjectId: 7,
      topicName: "Linear Algebra",
      topicId: 107,
      correctAnswerCount: 10,
      incorrectAnswerCount: 3,
      totalQuestions: 13,
      totalTimeSpent: "00:21:30",
      easyQuestionCount: 5,
      mediumQuestionCount: 6,
      hardQuestionCount: 2,
      easyQuestions: [
        FlashcardModel(id: "234b95b1-8c2b-497d-a110-bf91f1107d8a", question: "Easy Q7", answer: "A19"),
      ],
      mediumQuestions: [
        FlashcardModel(id: "1f42c5eb-4b26-4c42-9b7a-c440746b01d5", question: "Medium Q7", answer: "A20"),
      ],
      hardQuestions: [
        FlashcardModel(id: "b9846d72-b20f-47fe-b31e-d342b799d98f", question: "Hard Q7", answer: "A21"),
      ],
      createdAt: DateTime.parse("2024-08-20T06:30:00.000000"),
    ),
    StudySessionModel(
      subjectId: 8,
      topicName: "Network Security",
      topicId: 108,
      correctAnswerCount: 14,
      incorrectAnswerCount: 1,
      totalQuestions: 15,
      totalTimeSpent: "00:29:00",
      easyQuestionCount: 6,
      mediumQuestionCount: 5,
      hardQuestionCount: 4,
      easyQuestions: [
        FlashcardModel(id: "b2104c58-daff-4370-b432-477ad107f01f", question: "Easy Q8", answer: "A22"),
      ],
      mediumQuestions: [
        FlashcardModel(id: "bc4fcbd5-57b4-4696-bf92-b660ff3ef0d3", question: "Medium Q8", answer: "A23"),
      ],
      hardQuestions: [
        FlashcardModel(id: "f8c5a0b9-4d33-4da2-a993-c7fda80abdfb", question: "Hard Q8", answer: "A24"),
      ],
      createdAt: DateTime.parse("2024-08-21T05:15:00.000000"),
    ),
    StudySessionModel(
      subjectId: 9,
      topicName: "Software Engineering",
      topicId: 109,
      correctAnswerCount: 13,
      incorrectAnswerCount: 2,
      totalQuestions: 15,
      totalTimeSpent: "00:32:00",
      easyQuestionCount: 6,
      mediumQuestionCount: 5,
      hardQuestionCount: 4,
      easyQuestions: [
        FlashcardModel(id: "9f8fd0ab-d2c7-442e-9252-c903aa22e1c1", question: "Easy Q9", answer: "A25"),
      ],
      mediumQuestions: [
        FlashcardModel(id: "16d31e51-c2e9-4f88-8139-dc2a9abef4fa", question: "Medium Q9", answer: "A26"),
      ],
      hardQuestions: [
        FlashcardModel(id: "493045a4-c91a-4d96-a7b4-e81aee41372a", question: "Hard Q9", answer: "A27"),
      ],
      createdAt: DateTime.parse("2024-08-22T04:45:00.000000"),
    ),
    StudySessionModel(
      subjectId: 10,
      topicName: "Machine Learning",
      topicId: 110,
      correctAnswerCount: 15,
      incorrectAnswerCount: 0,
      totalQuestions: 15,
      totalTimeSpent: "00:35:00",
      easyQuestionCount: 6,
      mediumQuestionCount: 5,
      hardQuestionCount: 4,
      easyQuestions: [
        FlashcardModel(id: "3bfe33bb-e5bb-404b-a110-7f9603586e47", question: "Easy Q10", answer: "A28"),
      ],
      mediumQuestions: [
        FlashcardModel(id: "8e7b0c1b-cf43-4654-846d-89e79d5b0e85", question: "Medium Q10", answer: "A29"),
      ],
      hardQuestions: [
        FlashcardModel(id: "9f08de4f-bb6b-4b92-a0c7-9d8c8f5a0b83", question: "Hard Q10", answer: "A30"),
      ],
      createdAt: DateTime.parse("2024-08-23T03:30:00.000000"),
    ),
    StudySessionModel(
      subjectId: 11,
      topicName: "Cloud Computing",
      topicId: 111,
      correctAnswerCount: 12,
      incorrectAnswerCount: 3,
      totalQuestions: 15,
      totalTimeSpent: "00:28:00",
      easyQuestionCount: 7,
      mediumQuestionCount: 5,
      hardQuestionCount: 3,
      easyQuestions: [
        FlashcardModel(id: "7c548b29-263d-42ff-b6d4-570d2a1b5d92", question: "Easy Q11", answer: "A31"),
      ],
      mediumQuestions: [
        FlashcardModel(id: "f8b1b7cc-4589-4f65-80da-d0cc07113f45", question: "Medium Q11", answer: "A32"),
      ],
      hardQuestions: [
        FlashcardModel(id: "95b8db61-df35-4c8f-a072-43b746b249ae", question: "Hard Q11", answer: "A33"),
      ],
      createdAt: DateTime.parse("2024-08-24T02:15:00.000000"),
    ),
    StudySessionModel(
      subjectId: 12,
      topicName: "Blockchain",
      topicId: 112,
      correctAnswerCount: 13,
      incorrectAnswerCount: 2,
      totalQuestions: 15,
      totalTimeSpent: "00:33:00",
      easyQuestionCount: 5,
      mediumQuestionCount: 6,
      hardQuestionCount: 4,
      easyQuestions: [
        FlashcardModel(id: "c31f46ed-cb1b-402a-897f-b1b77be21f2f", question: "Easy Q12", answer: "A34"),
      ],
      mediumQuestions: [
        FlashcardModel(id: "abe9455c-7f0c-4d5f-9b33-6d381e28319f", question: "Medium Q12", answer: "A35"),
      ],
      hardQuestions: [
        FlashcardModel(id: "af88c32a-2f53-408d-b498-9910ad65a774", question: "Hard Q12", answer: "A36"),
      ],
      createdAt: DateTime.parse("2024-08-25T01:40:00.000000"),
    ),
    StudySessionModel(
      subjectId: 13,
      topicName: "Artificial Intelligence",
      topicId: 113,
      correctAnswerCount: 14,
      incorrectAnswerCount: 1,
      totalQuestions: 15,
      totalTimeSpent: "00:31:00",
      easyQuestionCount: 7,
      mediumQuestionCount: 5,
      hardQuestionCount: 3,
      easyQuestions: [
        FlashcardModel(id: "1cf46467-6b96-4631-bff2-b8f38f9a2771", question: "Easy Q13", answer: "A37"),
      ],
      mediumQuestions: [
        FlashcardModel(id: "c03ad72e-5d34-472f-b6f4-0e9b72f520fc", question: "Medium Q13", answer: "A38"),
      ],
      hardQuestions: [
        FlashcardModel(id: "b6d1c5db-57bb-4608-b5a9-42c67d03b232", question: "Hard Q13", answer: "A39"),
      ],
      createdAt: DateTime.parse("2024-08-26T00:55:00.000000"),
    ),
    StudySessionModel(
      subjectId: 14,
      topicName: "Quantum Computing",
      topicId: 114,
      correctAnswerCount: 11,
      incorrectAnswerCount: 4,
      totalQuestions: 15,
      totalTimeSpent: "00:27:00",
      easyQuestionCount: 5,
      mediumQuestionCount: 6,
      hardQuestionCount: 4,
      easyQuestions: [
        FlashcardModel(id: "ca1fd745-e0b5-4d6c-87cc-4331ac917df4", question: "Easy Q14", answer: "A40"),
      ],
      mediumQuestions: [
        FlashcardModel(id: "562c1b72-93ae-42a3-8a60-4ebaf243eae2", question: "Medium Q14", answer: "A41"),
      ],
      hardQuestions: [
        FlashcardModel(id: "f1c3f832-5574-4410-a9b1-5fa34b48f1a6", question: "Hard Q14", answer: "A42"),
      ],
      createdAt: DateTime.parse("2024-08-27T23:40:00.000000"),
    ),
    StudySessionModel(
      subjectId: 15,
      topicName: "Computer Networks",
      topicId: 115,
      correctAnswerCount: 10,
      incorrectAnswerCount: 5,
      totalQuestions: 15,
      totalTimeSpent: "00:30:00",
      easyQuestionCount: 6,
      mediumQuestionCount: 6,
      hardQuestionCount: 3,
      easyQuestions: [
        FlashcardModel(id: "207a7f3d-0fc2-4879-8d9b-c1f73009721e", question: "Easy Q15", answer: "A43"),
      ],
      mediumQuestions: [
        FlashcardModel(id: "c91f0847-f6a7-4a88-99d6-cf3c2f004b9e", question: "Medium Q15", answer: "A44"),
      ],
      hardQuestions: [
        FlashcardModel(id: "d6cd7f79-e071-40ae-b85e-e1b835e13b0e", question: "Hard Q15", answer: "A45"),
      ],
      createdAt: DateTime.parse("2024-08-28T22:15:00.000000"),
    )
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
                style: TextStyle(fontSize: 19),
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
              borderRadius = BorderRadius.zero;
              border = const Border(
                left: BorderSide(color: Colors.blueGrey, width: 0.5),
                right: BorderSide(color: Colors.blueGrey, width: 0.5),
                bottom: BorderSide(color: Colors.blueGrey, width: 0.5)
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
