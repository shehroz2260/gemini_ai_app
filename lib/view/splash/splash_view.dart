import 'package:flutter/material.dart';

import 'package:gemini_ai_app/utils/app_assets.dart';
import 'package:gemini_ai_app/utils/app_colors.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'splash_controller.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Lottie.asset(AppAssets.geminiAnimation)),
          ],
        ),
      ),
    );
  }
}
