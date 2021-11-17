import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/quiz_controller.dart';
import '../models/task.dart';
import 'progress_bar_widget.dart';
import 'question_card_widget.dart';

class BodyWidget extends StatefulWidget {
  final List<Task> tasks;
  const BodyWidget({
    Key? key,
    required this.tasks,
  }) : super(key: key);

  @override
  _BodyWidgetState createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  late List<Task> tasks;
  late int qnNumber;

  @override
  Widget build(BuildContext context) {
    QuizController _quizController = Get.put(QuizController());
    tasks = widget.tasks;
    _quizController.numOfTasks = tasks.length;
    //qnNumber = _quizController.taskNumber;
    return Stack(
      children: [
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ProgressBarWidget(),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text.rich(
                  TextSpan(
                    text: "Question",
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: Colors.yellow),
                    children: [
                      TextSpan(
                          text: "/${_quizController.numOfTasks}",
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(color: Colors.yellow))
                    ],
                  ),
                ),
              ),
              Divider(thickness: 1.5),
              SizedBox(height: 20),
              Expanded(
                child: PageView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  controller: _quizController.pageController,
                  onPageChanged: _quizController.updateTaskNumber,
                  itemCount: tasks.length,
                  itemBuilder: (context, index) => QuestionCardWidget(
                    task: tasks[index],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
