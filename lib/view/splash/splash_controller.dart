import 'package:gemini_ai_app/view/chat/chat_view.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  void getIntoApp() {
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAll(const ChatView());
    });
  }

  @override
  void onInit() {
    getIntoApp();
    super.onInit();
  }
}
