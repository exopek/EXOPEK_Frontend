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
      this.icon,
      this.numberKeyboard,
      this.obscureText = false,
      this.errorText = ''});

  final TextEditingController? controller;
  final String hint;
  final FocusNode? focusNode;
  final void Function(String)? onChanged;
  final void Function()? onClear;
  final void Function()? onTap;
  final bool Function(String)? onValidate;
  final IconData? icon;
  final bool? numberKeyboard;
  final bool obscureText;
  final String errorText;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _hasError;
  late bool _obscureText;

  @override
  void initState() {
    _hasError = false;
    _obscureText = widget.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          TextField(
            keyboardType: widget.numberKeyboard != null && widget.numberKeyboard!
                ? TextInputType.number
                : TextInputType.text,
            controller: widget.controller,
            focusNode: widget.focusNode,
            obscureText: _obscureText,
            onTap: () {
              if (widget.onTap != null) widget.onTap!();
            },
            onChanged: (value) {
              setState(() {
                _hasError =
                    widget.onValidate != null && !widget.onValidate!(value);
              });
              if (widget.onChanged != null) widget.onChanged!(value);
            },
            maxLines: 1,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(
                  bottom: 21.0, top: 21.0, left: 16.0, right: 16.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                gapPadding: 4.0,
                borderSide: BorderSide(
                  color: _hasError ? Colors.red : Color(0xFF262424),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                gapPadding: 4.0,
                borderSide: BorderSide(
                  color: _hasError ? Colors.red : Color(0xFF262424),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                gapPadding: 4.0,
                borderSide: BorderSide(
                  color: _hasError ? Colors.red : Color(0xFF262424),
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
              prefixIcon: widget.icon != null
                  ? Icon(
                      widget.icon,
                      color: Colors.white,
                      size: 16,
                    )
                  : null,
              suffixIcon: widget.controller!.text.isNotEmpty &&
                      widget.focusNode!.hasFocus
                  ? widget.obscureText ? Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        child: Container(
                          decoration: const ShapeDecoration(
                            color: Colors.transparent,
                            shape: CircleBorder(
                              side: BorderSide(
                                width: 1,
                                color: Color.fromARGB(255, 64, 64, 64),
                              ),
                            ),
                          ),
                          child: _obscureText ? const Icon(
                            Icons.visibility_off,
                            color: Color.fromARGB(255, 64, 64, 64),
                            size: 16,
                          ) : const Icon(
                            Icons.visibility,
                            color: Color.fromARGB(255, 64, 64, 64),
                            size: 16,
                          ),
                        ),
                      ),
                    ) : Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.controller!.clear();
                            if (widget.onClear != null) widget.onClear!();
                          });
                        },
                        child: Container(
                          decoration: const ShapeDecoration(
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
                    )
                  : null,
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
          if (_hasError)
            Positioned(
              left: 16,
              bottom: 0,
              child: Text(
                widget.errorText,
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                    fontFamily: 'Inter',
                    height: 2),
              ),
            ),
        ],
      ),
    );
  }
}
