import 'package:flutter/material.dart';

class SearchBarCustom extends StatefulWidget {
  const SearchBarCustom(
      {required this.controller,
      super.key,
      required this.xsize,
      this.focusNode,
      required this.hint,
      this.onChanged,
      this.onClear});

  final TextEditingController? controller;
  final double xsize;
  final String hint;
  final FocusNode? focusNode;
  final void Function(String)? onChanged;
  final void Function()? onClear;

  @override
  State<SearchBarCustom> createState() => _SearchBarCustomState();
}

class _SearchBarCustomState extends State<SearchBarCustom> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width * widget.xsize,
        height: 32,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: MediaQuery.sizeOf(context).width * widget.xsize,
                height: 32,
                decoration: ShapeDecoration(
                  color: const Color(0xFF0C0C0C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
            const Positioned(
              left: -30,
              top: 8,
              child: SizedBox(
                  width: 124,
                  height: 16,
                  child: Icon(
                    Icons.search,
                    color: Color(0xFF838282),
                    size: 16,
                  )),
            ),
            Positioned(
              left: 53,
              top: 15,
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width * widget.xsize,
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
