import 'package:flashcard_forge_app/utils/constants.dart';
import 'package:flashcard_forge_app/widgets/DrawerMenu.dart';
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
      "created_at": DateTime.parse("2024-08-01T08:10:23.527272"),
      "topic_name": "Introduction to Programming",
      "score": {"total": 18, "max_score": 20},
      "time_spent": "00:20:00",
      "difficulty_breakdown": {"easy": 10, "medium": 6, "hard": 2}
    },
    {
      "created_at": DateTime.parse("2024-08-01T15:30:10.527272"),
      "topic_name": "Data Structures",
      "score": {"total": 14, "max_score": 20},
      "time_spent": "00:30:00",
      "difficulty_breakdown": {"easy": 6, "medium": 5, "hard": 3}
    },
    {
      "created_at": DateTime.parse("2024-08-02T09:45:45.527272"),
      "topic_name": "Calculus I",
      "score": {"total": 12, "max_score": 20},
      "time_spent": "00:25:00",
      "difficulty_breakdown": {"easy": 8, "medium": 3, "hard": 1}
    },
    {
      "created_at": DateTime.parse("2024-08-03T10:00:23.527272"),
      "topic_name": "Discrete Mathematics",
      "score": {"total": 16, "max_score": 20},
      "time_spent": "00:18:00",
      "difficulty_breakdown": {"easy": 9, "medium": 5, "hard": 2}
    },
    {
      "created_at": DateTime.parse("2024-08-04T11:30:00.527272"),
      "topic_name": "Computer Networks",
      "score": {"total": 13, "max_score": 20},
      "time_spent": "00:27:00",
      "difficulty_breakdown": {"easy": 7, "medium": 4, "hard": 2}
    },
    {
      "created_at": DateTime.parse("2024-08-05T12:15:10.527272"),
      "topic_name": "Operating Systems",
      "score": {"total": 15, "max_score": 20},
      "time_spent": "00:22:00",
      "difficulty_breakdown": {"easy": 8, "medium": 4, "hard": 3}
    },
    {
      "created_at": DateTime.parse("2024-08-06T13:40:05.527272"),
      "topic_name": "Database Systems",
      "score": {"total": 17, "max_score": 20},
      "time_spent": "00:24:00",
      "difficulty_breakdown": {"easy": 9, "medium": 6, "hard": 2}
    },
    {
      "created_at": DateTime.parse("2024-08-07T14:55:35.527272"),
      "topic_name": "Software Engineering",
      "score": {"total": 14, "max_score": 20},
      "time_spent": "00:26:00",
      "difficulty_breakdown": {"easy": 7, "medium": 5, "hard": 2}
    },
    {
      "created_at": DateTime.parse("2024-08-08T15:20:10.527272"),
      "topic_name": "Artificial Intelligence",
      "score": {"total": 16, "max_score": 20},
      "time_spent": "00:23:00",
      "difficulty_breakdown": {"easy": 8, "medium": 6, "hard": 2}
    },
    {
      "created_at": DateTime.parse("2024-08-09T08:35:45.527272"),
      "topic_name": "Advanced Algorithms",
      "score": {"total": 12, "max_score": 20},
      "time_spent": "00:19:00",
      "difficulty_breakdown": {"easy": 6, "medium": 4, "hard": 2}
    },
    {
      "created_at": DateTime.parse("2024-08-10T10:10:10.527272"),
      "topic_name": "Quantum Computing",
      "score": {"total": 11, "max_score": 20},
      "time_spent": "00:29:00",
      "difficulty_breakdown": {"easy": 5, "medium": 4, "hard": 2}
    },
    {
      "created_at": DateTime.parse("2024-08-11T12:25:15.527272"),
      "topic_name": "Machine Learning",
      "score": {"total": 17, "max_score": 20},
      "time_spent": "00:28:00",
      "difficulty_breakdown": {"easy": 9, "medium": 6, "hard": 2}
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
        //title: SvgPicture.asset('assets/images/logo-v1.svg', height: 35, width: 35),
        title: const Text("Study History", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.all(10),
            child: Icon(Icons.search, size: 30, color: Colors.white),
          ),
        ],
      ),
      drawer: const DrawerMenu(),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: studyHistory.length,
        itemBuilder: (context, index) {
          final study = studyHistory[index];
          final DateTime createdAt = study['created_at'];
          final String formattedDate = DateFormat('EEE, dd MMMM, yyyy').format(createdAt);
          final int totalScore = study['score']['total'];
          final int maxScore = study['score']['max_score'];
          final double scorePercentage = (totalScore / maxScore) * 100;
          Color scoreColor;

          if (scorePercentage <= 60) {
            scoreColor = Styles.redHard;
          } else if (scorePercentage > 60 && scorePercentage < 80) {
            scoreColor = Styles.yellowReasonable;
          } else {
            scoreColor = Styles.greenEasy;
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (index == 0 || DateFormat('yyyy-MM-dd').format(studyHistory[index - 1]['created_at']) != DateFormat('yyyy-MM-dd').format(createdAt))
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                  child: Text(
                    formattedDate,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              SizedBox(
                height: 30,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text(
                        "Score: $totalScore/$maxScore",
                        style: TextStyle(fontSize: 14, color: scoreColor),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Time: ${study['time_spent']}",
                        style: const TextStyle(fontSize: 14, color: Styles.blueNeutral),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        "${study['difficulty_breakdown']['easy']}",
                        style: const TextStyle(fontSize: 14, color: Styles.greenEasy),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        "${study['difficulty_breakdown']['medium']}",
                        style: const TextStyle(fontSize: 14, color: Styles.blueNeutral),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        "${study['difficulty_breakdown']['hard']}",
                        style: const TextStyle(fontSize: 14, color: Styles.redHard),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
