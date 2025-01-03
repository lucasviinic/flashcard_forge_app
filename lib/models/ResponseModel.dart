import 'package:flashcard_forge_app/models/FlashcardModel.dart';

class FlashcardListResponseModel {
  final List<FlashcardModel> flashcards;
  final int count;

  FlashcardListResponseModel({required this.flashcards, required this.count});

  factory FlashcardListResponseModel.fromJson(Map<String, dynamic> json) {
    return FlashcardListResponseModel(
      flashcards: (json['flashcards'] as List<dynamic>)
          .map((item) => FlashcardModel.fromJson(item))
          .toList(),
      count: json['count'] as int,
    );
  }
}
