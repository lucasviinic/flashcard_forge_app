import 'package:flashcard_forge_app/models/TopicModel.dart';
import 'dart:async';

import 'package:flashcard_forge_app/services/contracts/contracts.dart';

class TopicRepository implements TopicRepositoryContract {

  @override
  Future<TopicModel> updateTopic(TopicModel topic) async {
    return Future.value(topic);
  }

  @override
  Future<void> deleteTopic(int topicId) async {
    return Future.value();
  }
}
