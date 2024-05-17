import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:gemini_ai_app/model.dart/chat_model.dart';
import 'package:gemini_ai_app/utils/app_colors.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';
import '../../widgets/custom_button.dart';

class ChatController extends GetxController {
  final _chatController = TextEditingController();
  TextEditingController get chatController => _chatController;
  // List<String> listDatas = [];
  List<ChatModel> messageList = [];
  bool isLoading = false;
  Uint8List? imagePath;
  Future<void> searchContent() async {
    if (_chatController.text.isEmpty && imagePath == null) {
      Get.snackbar("Empty message", "Please write something or choose image",
          colorText: AppColors.offwhiteColor);
      return;
    }
    final model = ChatModel(message: _chatController.text, image: imagePath);
    messageList.add(model);

    isLoading = true;
    update();
    try {
      final model = GenerativeModel(
        model: "gemini-1.5-pro-latest",
        apiKey: "AIzaSyDiDdWJDkXR2ALPQGQI1PKsG1UZcqziBwc",
      );
      final prompt = _chatController.text;
      final content = [
        Content.text(prompt),
        if (imagePath != null) Content.data("image/png", imagePath!)
      ];
      _chatController.clear();
      final response = await model.generateContent(content);
      final geminiResponse = ChatModel(message: response.text ?? "");
      messageList.add(geminiResponse);
    } catch (e) {
      isLoading = false;
      imagePath = null;
      messageList.removeAt(messageList.length - 1);
      Get.snackbar("Error", e.toString(), colorText: AppColors.offwhiteColor);
    }

    imagePath = null;
    isLoading = false;
    _chatController.clear();

    update();
  }

  Future<Uint8List?> pickImage(bool fromGallery) async {
    ImagePicker picker = ImagePicker();
    final result = await picker.pickImage(
        source: fromGallery ? ImageSource.gallery : ImageSource.camera);
    if (result == null) {
      return null;
    }
    return result.readAsBytes();
  }

  void modelBottomSheet() async {
    await showModalBottomSheet(
        backgroundColor: AppColors.primaryColor,
        context: Get.context!,
        builder: (context) {
          return Container(
            height: 200,
            color: AppColors.offwhiteColor.withOpacity(0.1),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                      name: "Camera",
                      onTap: () async {
                        Get.back();
                        imagePath = await pickImage(false);
                        update();
                      }),
                  const SizedBox(height: 20),
                  CustomButton(
                      name: "Gallery",
                      onTap: () async {
                        Get.back();
                        imagePath = await pickImage(true);
                        update();
                      }),
                ],
              ),
            ),
          );
        });
  }
}
