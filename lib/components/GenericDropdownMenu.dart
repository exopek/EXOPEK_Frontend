import 'package:flutter/material.dart';

class GenericDropdownMenu<T> extends StatefulWidget {
  final List<T> items;
  final T? value;
  final void Function(T?) onChanged;
  final Widget? hint;

  GenericDropdownMenu({
    required this.items,
    required this.onChanged,
    this.value,
    this.hint,
  });

  @override
  _GenericDropdownMenuState<T> createState() => _GenericDropdownMenuState<T>();
}

class _GenericDropdownMenuState<T> extends State<GenericDropdownMenu<T>> {
  T? _selectedValue;
  double containerHeight = 37;
  bool showSelections = false;
  T selectedTime = "" as T;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: AnimatedContainer(
        width: 132, // Hier mit MediaQuery.of(context).size.width * 0.3 ersetzen
        height: containerHeight,
        decoration: ShapeDecoration(
          color: showSelections ? Color(0xFF262626) : Colors.transparent,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: Color(0xFF262626)),
            borderRadius: BorderRadius.circular(13.25),
          ),
        ), duration: const Duration(milliseconds: 500),
        child: GestureDetector(
          onTap: () {
            
            setState(() {
              containerHeight = widget.items.length * 37;
              showSelections = true;
              
            });
          },
          child: showSelections ? Column(
            
            children: [
              for (var index = 0; index < widget.items.length; index++)
                Expanded(
                  child: Container(
                      height: 37,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: index == widget.items.length -1 ? Colors.transparent : Colors.white,
                            width: 0.1,
                          ),
                        ),
                      ),
                      child: Center(
                        child: TextField(
                          //widget.items[index] as String,
                          controller: TextEditingController(text: widget.items[index].toString()),
                          textAlign: TextAlign.center,
                          readOnly: true,
                          onTap: () {
                            setState(() {
                        containerHeight = 37;
                        showSelections = false;
                        selectedTime = widget.items[index];
                        
                        widget.onChanged!(widget.items[index]);
                      });
                          },
                          onTapOutside: (event) {
                            setState(() {
                              containerHeight = 37;
                              showSelections = false;
                            });
                          },
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          )
                        ),
                      ),
                    ),
                  
                )
            
            ]) : Container(
            height: 37,
            
            decoration: BoxDecoration(
              color: Colors.transparent),
              child: Center(
              child: Text(
                widget.value.toString() as String,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
                        ),
            ),
        )
      ),
    
    );
  }
}