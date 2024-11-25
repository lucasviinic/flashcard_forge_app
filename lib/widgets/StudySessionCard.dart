import 'package:flashcard_forge_app/models/StudySessionModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StudySessionCard extends StatelessWidget {
  final StudySessionModel session;

  const StudySessionCard({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    String day = DateFormat.d().format(session.createdAt!);
    String month = DateFormat.MMM().format(session.createdAt!).toUpperCase();

    double scorePercentage = (session.correctAnswerCount / session.totalQuestions) * 100;

    Color percentageColor = scorePercentage < 60
        ? Colors.red
        : scorePercentage < 75
            ? Colors.orange
            : Colors.green;

    return SizedBox(
      height: MediaQuery.of(context).size.height * .08,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Column(
                    children: [
                      Text(day, style: const TextStyle(fontSize: 19)),
                      Text(month, style: const TextStyle(color: Colors.green)),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      session.topicName,
                      style: const TextStyle(fontSize: 19),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Row(
                      children: [
                        Text(
                          "${session.hardQuestionCount}",
                          style: const TextStyle(fontSize: 15, color: Colors.red),
                        ),
                        Text(
                          " ${session.mediumQuestionCount}",
                          style: const TextStyle(fontSize: 15, color: Colors.blue),
                        ),
                        Text(
                          " ${session.easyQuestionCount}",
                          style: const TextStyle(fontSize: 15, color: Colors.green),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("${scorePercentage.toStringAsFixed(2)}%", style: TextStyle(fontSize: 19, color: percentageColor)),
                      Text(session.totalTimeSpent, style: const TextStyle(fontSize: 15, color: Colors.grey)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
