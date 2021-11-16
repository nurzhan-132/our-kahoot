import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import '../controllers/quiz_controller.dart';

class OptionWidget extends StatelessWidget {
  const OptionWidget({
    Key? key,
    required this.text,
    required this.index,
    this.press,
  }) : super(key: key);
  final String text;
  final int index;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuizController>(
        init: QuizController(),
        builder: (controller) {
          Color getTheRightColor() {
            if (controller.isAnswered) {
              if (index == controller.correctAns) {
                return Colors.green;
              } else if (index == controller.selectedAns &&
                  controller.selectedAns != controller.correctAns) {
                return Colors.red;
              }
            }
            return Colors.grey;
          }

          IconData getTheRightIcon() {
            return getTheRightColor() == Colors.red ? Icons.close : Icons.done;
          }

          return InkWell(
            onTap: press,
            child: Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(color: getTheRightColor()),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${index + 1}) $text",
                    style: TextStyle(color: getTheRightColor(), fontSize: 16),
                  ),
                  Container(
                    height: 26,
                    width: 26,
                    decoration: BoxDecoration(
                      color: getTheRightColor() == Colors.grey
                          ? Colors.transparent
                          : getTheRightColor(),
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: getTheRightColor()),
                    ),
                    child: getTheRightColor() == Colors.grey ? null : Icon(getTheRightIcon(), size: 16),
                  )
                ],
              ),
            ),
          );
        });
  }
}
