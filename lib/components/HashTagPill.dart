import 'package:exopek_workout_app/theme/ThemeBase.dart';
import 'package:flutter/material.dart';

class HashTagPill extends StatelessWidget {
  final String text;
  final Color? color;
  final Color? textColor;
  final Function(String)? onTap;

  const HashTagPill(
      {super.key, required this.text, this.color, this.textColor, this.onTap});

  @override
  Widget build(BuildContext context) {
    final textWidget = Text(
      text,
      style: TextStyle(
        color: textColor ?? ThemeBase.of(context).secondaryText,
        fontSize: 10,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w300,
      ),
    );
    return textWidget.data != null
        ? GestureDetector(
            onTap: onTap != null ? () => onTap!(text) : null,
            child: Container(
                
                decoration: ShapeDecoration(
                  color: color ?? ThemeBase.of(context).secondaryBackground,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Center(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
                      child: textWidget),
                )),
          )
        : Container();
  }
}
