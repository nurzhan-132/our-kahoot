// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BirthdayWidget extends StatefulWidget {
  final DateTime? birthday;
  final ValueChanged<DateTime?> onChangedBirthday;

  const BirthdayWidget({
    Key? key,
    this.birthday,
    required this.onChangedBirthday,
  }) : super(key: key);

  @override
  _BirthdayWidgetState createState() => _BirthdayWidgetState();
}

class _BirthdayWidgetState extends State<BirthdayWidget> {
  final controller = TextEditingController();
  final focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    setDate();
  }

  @override
  void didUpdateWidget(covariant BirthdayWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    //setDate();
  }

  void setDate() => setState(() {
        controller.text = widget.birthday == null
            ? ''
            : DateFormat.yMd().format(widget.birthday);
      });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FocusBuilder(
      onChangeVisibility: (isVisible) {
        if (isVisible) {
          selectDate(context);
        } else {
          controller.text = DateFormat.yMd().format(widget.birthday);

          FocusScope.of(context).requestFocus(FocusNode());
        }
      },
      focusNode: focusNode,
      builder: (hasFocus) => Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        width: size.width * 0.8,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            color: const Color.fromRGBO(244, 190, 199, 1),
            borderRadius: BorderRadius.circular(29)),
        child: TextFormField(
          controller: controller,
          validator: (value) => value!.isEmpty ? 'Is Required' : null,
          decoration: const InputDecoration(
            prefixText: ' ',
            hintText: 'Your birthday',
            prefixIcon: Icon(
              Icons.calendar_today_rounded,
              color: Colors.white,
            ),
            border: InputBorder.none,
            hoverColor: Colors.yellow,
          ),
        ),
      ),
    );
  }

  Future selectDate(BuildContext context) async {
    final birthday = await showDatePicker(
      context: context,
      initialDate: widget.birthday ?? DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
    );

    if (birthday == null) return;

    widget.onChangedBirthday(birthday);
  }
}

class FocusBuilder extends StatefulWidget {
  final FocusNode focusNode;
  final Widget Function(bool hasFocus) builder;
  final ValueChanged<bool> onChangeVisibility;

  const FocusBuilder({
    required this.focusNode,
    required this.builder,
    required this.onChangeVisibility,
    Key? key,
  }) : super(key: key);

  @override
  _FocusBuilderState createState() => _FocusBuilderState();
}

class _FocusBuilderState extends State<FocusBuilder> {
  @override
  Widget build(BuildContext context) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => widget.onChangeVisibility(true),
        child: Focus(
          focusNode: widget.focusNode,
          onFocusChange: widget.onChangeVisibility,
          child: widget.builder(widget.focusNode.hasFocus),
        ),
      );
}
