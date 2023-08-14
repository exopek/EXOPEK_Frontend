import 'package:flutter/material.dart';

class SearchBarCustom extends StatefulWidget {
  const SearchBarCustom(
      {required this.controller, super.key, required this.xsize});

  final TextEditingController? controller;
  final double xsize;

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
                width: 311,
                height: 32,
                decoration: ShapeDecoration(
                  color: Color(0xFF0C0C0C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
            Positioned(
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
                width: 124,
                height: 16,
                child: TextFormField(
                  controller: widget.controller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Training finden',
                    hintStyle: TextStyle(
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
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
