import 'package:flutter/material.dart';

class CustomTextFieldButton extends StatefulWidget {
  const CustomTextFieldButton(
      {required this.controller,
      super.key,
      required this.hint,
      this.onTap,
      this.prefixIcon,
      this.suffixIcon});

  final TextEditingController? controller;
  final String hint;
  final void Function()? onTap;
  final IconData? prefixIcon;
  final IconData? suffixIcon;

  @override
  State<CustomTextFieldButton> createState() => _CustomTextFieldButtonState();
}

class _CustomTextFieldButtonState extends State<CustomTextFieldButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextField(
          /* textInputAction: TextInputAction.none, */
          readOnly: true,
          controller: widget.controller,
          maxLines: 1,
          onTap: () => widget.onTap!(),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(
                bottom: 21.0, top: 21.0, left: 16.0, right: 16.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              gapPadding: 4.0,
              borderSide: BorderSide(
                color: Color(0xFF262424),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              gapPadding: 4.0,
              borderSide: BorderSide(
                color: Color(0xFF262424),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              gapPadding: 4.0,
              borderSide: BorderSide(
                color: Color(0xFF262424),
              ),
            ),
            labelText: widget.hint,
            floatingLabelAlignment: FloatingLabelAlignment.start,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelStyle: const TextStyle(
              color: Color(0xFF838282),
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
            ),
            hintText: widget.hint,
            prefixIcon: widget.prefixIcon != null
                ? Icon(
                    widget.prefixIcon,
                    color: Colors.white,
                    size: 16,
                  )
                : null,
            suffixIcon: Padding(
              padding: const EdgeInsets.all(12.0),
              child: GestureDetector(
                onTap: () {},
                child: Container(
                    decoration: ShapeDecoration(
                      color: Colors.transparent,
                      shape: CircleBorder(
                        side: BorderSide(
                          width: 1,
                          color: Color.fromARGB(255, 64, 64, 64),
                        ),
                      ),
                    ),
                    child: widget.suffixIcon != null
                        ? Icon(
                            widget.suffixIcon,
                            color: Color.fromARGB(255, 64, 64, 64),
                            size: 16,
                          )
                        : const SizedBox()),
              ),
            ),
            hintStyle: const TextStyle(
              color: Color(0xFF838282),
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
            ),
          ),
          style: const TextStyle(
            color: Color(0xFF838282),
            fontSize: 16,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
