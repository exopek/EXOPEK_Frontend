import 'package:exopek_workout_app/theme/ThemeBase.dart';
import 'package:flutter/material.dart';

class CtaButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool? isLoading;
  final double? height;
  final double? fontSizeLable;
  final double? width;
  final Color? color;

  const CtaButton(
      {super.key,
      required this.label,
      this.onPressed,
      this.isLoading,
      this.height = 49,
      this.width,
      this.fontSizeLable = 20,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: MediaQuery.of(context).size.width,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: TextButton(
        style: ButtonStyle(
          overlayColor:
              MaterialStateProperty.all(Colors.white.withOpacity(0.1)),
          backgroundColor: MaterialStateProperty.all(color ?? ThemeBase.of(context).secondary), // 0xFFD12626
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        onPressed: () => onPressed!(),
        child: isLoading == null
            ? Text(
                label,
                style: ThemeBase.of(context).labelMedium.copyWith(
                      fontSize: fontSizeLable,
                      color: Colors.white,
                    ),
              )
            : isLoading! == true
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : Text(
                    label,
                    style: ThemeBase.of(context).labelMedium.copyWith(
                          fontSize: fontSizeLable,
                          color: Colors.white,
                        ),
                  ),
      ),
    );
  }
}
