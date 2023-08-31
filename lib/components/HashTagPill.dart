import 'package:flutter/material.dart';

class HashTagPill extends StatelessWidget {
  final String text;

  const HashTagPill({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final textWidget = Text(
      text,
      style: TextStyle(
        color: Color(0xFF838282),
        fontSize: 10,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w300,
      ),
    );
    print(textWidget.data);
    print(textWidget.data);
    return textWidget.data != null
        ? Container(
            //width: 68,
            height: 21,
            constraints: BoxConstraints(
              maxWidth: textWidget.data!.length.toDouble() * 8.0,
              minWidth: textWidget.data!.length.toDouble() *
                  8.0, /* textWidget.textSpan!.toPlainText().length * 10.0, */
            ),
            decoration: ShapeDecoration(
              color: Color(0xFF262424),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Center(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: textWidget),
            ))
        : Container();
  }
}
