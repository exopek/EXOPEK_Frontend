import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {required this.controller,
      super.key,
      this.focusNode,
      required this.hint,
      this.onChanged,
      this.onClear,
      this.onTap,
      this.onValidate,
      this.icon});

  final TextEditingController? controller;
  final String hint;
  final FocusNode? focusNode;
  final void Function(String)? onChanged;
  final void Function()? onClear;
  final void Function()? onTap;
  final bool Function(String)? onValidate;
  final IconData? icon;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _hasError;

  @override
  void initState() {
    _hasError = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        height: 67,
        width: MediaQuery.of(context).size.width,
        decoration: ShapeDecoration(
          color: Color(0x00262323),
          shape: RoundedRectangleBorder(
            side: BorderSide(
                width: 1, color: _hasError ? Colors.red : Color(0xFF262424)),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Stack(
          children: [
            Row(
              children: [
                if (widget.icon != null)
                  Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Icon(
                        widget.icon,
                        color: Colors.white,
                        size: 16,
                      )),
                Expanded(
                  child: Center(
                    child: Container(
                      child: TextField(
                        controller: widget.controller,
                        focusNode: widget.focusNode,
                        onTap: () {
                          if (widget.onTap != null) widget.onTap!();
                        },
                        onChanged: (value) {
                          setState(() {
                              _hasError = widget.onValidate != null &&
                                  !widget.onValidate!(value);
                          });
                          if (widget.onChanged != null) widget.onChanged!(value);
                        },
                        maxLines: 1,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              bottom: 0.0, left: 16.0, right: 16.0),
                          border: InputBorder.none,
                          hintText: widget.hint,
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
                        /* onEditingComplete: () {
                          setState(() {
                            widget.focusNode!.unfocus();
                          });
                        },
                        onFieldSubmitted: (value) {
                          setState(() {
                            widget.focusNode!.unfocus();
                          });
                        }, */
                        onTapOutside: (event) {
                          setState(() {
                            widget.focusNode!.unfocus();
                          });
                        },
                      ),
                    ),
                  ),
                ),
                if (widget.controller!.text.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.controller!.clear();
                          if (widget.onClear != null) widget.onClear!();
                        });
                      },
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
                        child: const Icon(
                          Icons.clear,
                          color: Color.fromARGB(255, 64, 64, 64),
                          size: 16,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            if (_hasError)
              Positioned(
                left: 16,
                bottom: 0,
                child: Text(
                  'Password min 10 characters and 1 number',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                    fontFamily: 'Inter',
                    
                    height: 2
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
