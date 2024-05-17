import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gemini_ai_app/utils/app_colors.dart';
import 'package:gemini_ai_app/view/chat/chat_controller.dart';
import 'package:gemini_ai_app/widgets/image_preview.dart';
import 'package:gemini_ai_app/widgets/spinkle_three_dot.dart';
import 'package:get/get.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChatController());
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: AppColors.offwhiteColor.withOpacity(0.1),
        foregroundColor: Colors.white,
        title: const Text('Gemini AI Generator'),
        centerTitle: true,
      ),
      body: GetBuilder<ChatController>(builder: (_) {
        return Column(
          children: [
            controller.messageList.isEmpty
                ? Expanded(
                    child: Center(
                      child: Text(
                        "Search Something Over Here !!",
                        style: TextStyle(
                            color: AppColors.offwhiteColor, fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                : Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      itemCount: controller.messageList.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          height: 10,
                        );
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return Align(
                          alignment: index.isOdd
                              ? Alignment.centerLeft
                              : Alignment.centerRight,
                          child: Card(
                            color: index.isOdd
                                ? AppColors.offwhiteColor.withOpacity(0.5)
                                : Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (index.isEven &&
                                    controller.messageList[index].image != null)
                                  ClipRRect(
                                    borderRadius: controller.messageList[index]
                                            .message.isNotEmpty
                                        ? const BorderRadius.only(
                                            topLeft: Radius.circular(12),
                                            topRight: Radius.circular(12))
                                        : const BorderRadius.all(
                                            Radius.circular(12)),
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.to(ImageViewer(
                                            imagePath: controller
                                                .messageList[index].image!));
                                      },
                                      child: Image.memory(
                                        controller.messageList[index].image!,
                                        fit: BoxFit.fill,
                                        height: 250,
                                        width: 200,
                                      ),
                                    ),
                                  ),
                                if (controller
                                    .messageList[index].message.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      controller.messageList[index].message,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            color: index.isOdd
                                                ? Colors.white
                                                : Colors.blue,
                                          ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
            if (controller.isLoading)
              const SpinKitThreeBounce(color: Colors.blue, size: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: TextStyle(color: AppColors.offwhiteColor),
                      controller: controller.chatController,
                      onTapOutside: (event) {
                        FocusScope.of(context).unfocus();
                      },
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                            onTap: controller.modelBottomSheet,
                            child: controller.imagePath != null
                                ? Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(25)),
                                      child: Image.memory(
                                        controller.imagePath!,
                                        width: 30,
                                        height: 30,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                : const Icon(Icons.attach_file,
                                    color: Colors.blue)),
                        hintStyle: TextStyle(color: AppColors.offwhiteColor),
                        hintText: "How can i help you...",
                        contentPadding: const EdgeInsets.all(10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  controller.isLoading
                      ? const CircularProgressIndicator(color: Colors.blue)
                      : InkWell(
                          onTap: () async {
                            await controller.searchContent();
                          },
                          child: const Icon(
                            Icons.send,
                            size: 25,
                            color: Colors.blue,
                          ),
                        )
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
