import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import '../views/result_screen.dart';
import '../models/task.dart';

class QuizController extends GetxController with SingleGetTickerProviderMixin {
  late AnimationController _animationController;
  late Animation _animation;
  Animation get animation => this._animation;

  late PageController _pageController;
  PageController get pageController => this._pageController;

  bool _isAnswered = false;
  bool get isAnswered => this._isAnswered;

  late int _correctAns = 0;
  int get correctAns => this._correctAns;

  late int _selectedAns;
  int get selectedAns => this._selectedAns;

  late int _numOfCorrectAns = 0;
  int get numOfCorrectAns => this._numOfCorrectAns;

  late int _taskNumber = 0;
  int get taskNumber => this.taskNumber;

  late int numOfTasks;

  @override
  void onInit() {
    _animationController =
        AnimationController(duration: Duration(seconds: 20), vsync: this);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController)
      ..addListener(() {
        update();
      });

    _animationController.forward().whenComplete(nextTask);
    _pageController = PageController();
    super.onInit();
  }

  void checkAns(Task task, int selectedIndex) {
    if (_isAnswered) return;
    _isAnswered = true;
    _selectedAns = selectedIndex;

    for (int i = 0; i < task.answers.length; i++) {
      if (task.answers[i].correctness == true) {
        _correctAns = i;
      }
    }

    if (task.answers[_selectedAns].correctness == true) {
      _numOfCorrectAns++;
    }
    _animationController.stop();
    update();

    Future.delayed(Duration(seconds: 3), () {
      nextTask();
    });
  }

  void nextTask() {
    if (_taskNumber != numOfTasks) {
      _isAnswered = false;
      _pageController.nextPage(
          duration: Duration(milliseconds: 250), curve: Curves.ease);
      _animationController.reset();
      _animationController.forward().whenComplete(nextTask);
    } else {
      Get.to(ResultScreen());
    }

  }

  @override
  void onClose() {
    super.onClose();
    _animationController.dispose();
    _pageController.dispose();
  }

  void updateTaskNumber(int index) {
    _taskNumber = index + 1;
  }
}
