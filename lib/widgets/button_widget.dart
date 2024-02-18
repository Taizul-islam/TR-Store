import 'package:flutter/material.dart';
import 'package:task_app/core/extension/extensions.dart';

class ButtonWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final String btnText;
  final double radius;
  final Color bgColor;
  final Size btnSize;
  final double fontSize;
  final bool loading;
  final Color txtColor;

  const ButtonWidget(
      {super.key,
      required this.onTap,
      required this.bgColor,
      required this.radius,
      required this.btnText,
      required this.btnSize,
      required this.fontSize,
      required this.txtColor,
      required this.loading});

  @override
  Widget build(BuildContext context) {
    Widget txt = btnText.apply(
        fontWeight: FontWeight.w500, color: txtColor, fontSize: fontSize);
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            elevation: 0,
            maximumSize: btnSize,
            minimumSize: btnSize,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius))),
        onPressed: onTap,
        child: loading
            ? const SizedBox(
                height: 25,
                width: 25,
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              )
            : txt);
  }
}
