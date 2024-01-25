import 'package:flutter/material.dart';

class PreFilterSelection extends StatelessWidget {
  const PreFilterSelection(
      {super.key, required this.name, required this.onTap});
  final String name;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 65,
        child: Stack(
          children: [
            Positioned(
              left: 26,
              top: 24,
              child: Text(
                name,
                style: TextStyle(
                  color: Color(0xFF838282),
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: 390,
                height: 65,
                decoration: BoxDecoration(
                  color: Color(0x00D9D9D9),
                  border: Border(
                    bottom: BorderSide(width: 0.50, color: Color(0xFF838282)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
