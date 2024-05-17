import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatController extends GetxController {
  final _chatController = TextEditingController();
  TextEditingController get chatController => _chatController;
  List<String> listDatas = [];
  bool isLoading = false;
  Future<void> searchContent() async {
    if (_chatController.text.isNotEmpty) {
      listDatas.add(_chatController.text);

      isLoading = true;
      update();
      final model = GenerativeModel(
        model: 'gemini-1.5-flash-latest',
        apiKey: "",
      );

      final prompt = _chatController.text;
      final content = [Content.text(prompt)];
      _chatController.clear();
      final response = await model.generateContent(content);

      listDatas.add(response.text ?? "");

      isLoading = false;

      _chatController.clear();
    }
    update();
  }
}
