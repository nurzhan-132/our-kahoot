// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/quiz_controller.dart';
import '../models/task.dart';
import 'option_widget.dart';

class QuestionCardWidget extends StatelessWidget {
  const QuestionCardWidget({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    QuizController _controller = Get.put(QuizController());
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          Text(
            task.questionText,
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(color: Colors.black),
          ),
          const SizedBox(height: 10),
          ...List.generate(
            task.answers.length,
            (index) => OptionWidget(
              index: index,
              text: task.answers[index].answerText,
              press: () => _controller.checkAns(task, index),
            ),
          )
        ],
      ),
    );
  }
}
