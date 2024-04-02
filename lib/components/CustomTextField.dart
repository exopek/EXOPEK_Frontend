import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {required this.controller,
      super.key,
      this.focusNode,
      required this.hint,
      required this.xsize,
      this.onChanged,
      this.onClear,
      this.icon});

  final TextEditingController? controller;
  final String hint;
  final FocusNode? focusNode;
  final void Function(String)? onChanged;
  final void Function()? onClear;
  final double xsize;
  final Icon? icon;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width * widget.xsize,
        height: 67,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: MediaQuery.sizeOf(context).width * widget.xsize,
                height: 67,
                decoration: ShapeDecoration(
                  color: Color(0x00262323),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: Color(0xFF262424)),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            Positioned(
              left: -30,
              top: 25,
              child: SizedBox(
                  width: 124,
                  height: 16,
                  child: widget.icon ??
                      Icon(
                        Icons.search,
                        color: Color(0xFF838282),
                        size: 16,
                      )),
            ),
            Positioned(
              left: 53,
              top: 32,
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width * widget.xsize - 53,
                height: 16,
                child: TextFormField(
                  controller: widget.controller,
                  focusNode: widget.focusNode,
                  onChanged: (value) {
                    if (widget.onChanged != null) widget.onChanged!(value);
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(bottom: 17.0),
                    border: InputBorder.none,
                    hintText: widget.hint,
                    hintStyle: const TextStyle(
                      color: Color(0xFF838282),
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  style: const TextStyle(
                    color: Color(0xFF838282),
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                  onTapOutside: (event) => widget.focusNode!.unfocus(),
                ),
              ),
            ),
            if (widget.controller!.text.isNotEmpty)
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                child: IconButton(
                  onPressed: () => widget.onClear!(),
                  icon: const Icon(
                    Icons.clear,
                    color: Color(0xFF838282),
                    size: 16,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
