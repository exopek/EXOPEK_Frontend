import 'package:flutter/material.dart';

class CtaButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const CtaButton({super.key, required this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 49,
      width: MediaQuery.of(context).size.width,
      decoration: ShapeDecoration(
        //color: Color(0xFFD12626),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: TextButton(
        style: ButtonStyle(
          overlayColor:
              MaterialStateProperty.all(Colors.white.withOpacity(0.1)),
          backgroundColor: MaterialStateProperty.all(Color(0xFFD12626)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        onPressed: () => onPressed!(),
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
