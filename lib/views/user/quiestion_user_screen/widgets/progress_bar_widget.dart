// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/controllers/quiz_controller.dart';

class ProgressBarWidget extends StatelessWidget {
  const ProgressBarWidget({
    Key? key,
  }) : super(key: key);

  final int duration = 20;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 35,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF3F4768), width: 3),
        borderRadius: BorderRadius.circular(50),
      ),
      child: GetBuilder<QuizController>(
        init: QuizController(),
        builder: (controller) {
          return Stack(
            children: [
              LayoutBuilder(
                builder: (context, constraints) => Container(
                  width: constraints.maxWidth * controller.animation.value,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      gradient: const LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Colors.blue,
                          Colors.red,
                        ],
                      )),
                ),
              ),
              Positioned.fill(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Text(
                        "${duration - (controller.animation.value * duration).round()} sec")
                  ],
                ),
              ))
            ],
          );
        },
      ),
    );
  }
}
