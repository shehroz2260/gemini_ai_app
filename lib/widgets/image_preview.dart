import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ImageViewer extends StatelessWidget {
  final Uint8List imagePath;
  const ImageViewer({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: Get.width,
            height: Get.height,
            child: InteractiveViewer(
              child: Image.memory(
                imagePath,
                width: Get.width,
                height: Get.height,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 20,
            child: SafeArea(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.black26,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.close),
                  color: Colors.white,
                  onPressed: () => Get.back(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
