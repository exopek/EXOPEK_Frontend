import 'package:flutter/material.dart';

class SearchBarButton extends StatefulWidget {
  const SearchBarButton(
      {required this.onTap,
      super.key,
      required this.xsize,
      required this.hint,
      this.enabled = true});

  final void Function() onTap;
  final double xsize;
  final String hint;
  final bool enabled;

  @override
  State<SearchBarButton> createState() => _SearchBarButtonState();
}

class _SearchBarButtonState extends State<SearchBarButton> {
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
                width: MediaQuery.sizeOf(context).width * 0.9,
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
              child: GestureDetector(
                onTap: widget.onTap,
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.8,
                  height: 16,
                  child: TextFormField(
                    onTap: widget.onTap,
                    enabled: widget.enabled,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: widget.hint,
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
