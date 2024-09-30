import 'dart:io';

import 'package:flashcard_forge_app/models/FlashcardModel.dart';
import 'dart:async';

import 'package:flashcard_forge_app/services/contracts/contracts.dart';

class FlashcardRepository implements FlashcardRepositoryContract {

  @override
  Future<FlashcardModel> updateFlashcard(FlashcardModel flashcard) async {
    return Future.value(flashcard);
  }

  @override
  Future<void> deleteFlashcard(int flashcardId) async {
    return Future.value();
  }

  @override
  Future<List<FlashcardModel>> uploadFile(File file) async {
    return [];
  }
}
