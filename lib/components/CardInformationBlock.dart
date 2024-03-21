import 'package:flutter/material.dart';

class CardInformationBlock extends StatelessWidget {
  final String value;
  final IconData? icon;

  CardInformationBlock({required this.value, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Icon(
            icon ?? Icons.chat_bubble_rounded,
            color: Color(0xFF838282),
            size: 14,
          ),
          SizedBox(
            width: 3,
          ),
          Text(
            value,
            style: TextStyle(
              color: Color(0xFF838282),
              fontSize: 10,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
        ],
      ),
    );
  }
}
