import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String name;
  final Color? btnColor;
  final Color? textColor;
  final void Function() onTap;
  const CustomButton({
    super.key,
    required this.name,
    this.btnColor,
    this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: Get.width,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
            color: btnColor ?? Colors.blue,
            borderRadius: const BorderRadius.all(Radius.circular(49))),
        child: Text(
          name,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.offwhiteColor),
        ),
      ),
    );
  }
}
