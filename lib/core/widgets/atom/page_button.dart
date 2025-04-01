import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class PageButton extends StatefulWidget {
  final int pageNumber;
  final bool isSelected;
  final VoidCallback onPressed;

  const PageButton({
    super.key,
    required this.pageNumber,
    required this.onPressed,
    this.isSelected = false,
  });

  @override
  State<PageButton> createState() => _PageButtonState();
}

class _PageButtonState extends State<PageButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() {
        isHovered = true;
      }),
      onExit: (_) => setState(() {
        isHovered = false;
      }),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 30,
          height: 30,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            color: widget.isSelected
                ? Colors.blue
                : isHovered
                    ? Colors.blue.withOpacity(0.4)
                    : Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: widget.isSelected
                ? Border.all(color: Colors.white, width: 2)
                : null,
          ),
          child: Center(
            child: Text(
              '${widget.pageNumber}',
              style: TextStyle(
                color: widget.isSelected ? Colors.white : Colors.black,
                fontSize: 10.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
