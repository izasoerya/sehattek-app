import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TableButton extends StatelessWidget {
  final Widget child;

  const TableButton({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 1.sw, vertical: 1.sh),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(5),
        ),
        child: child,
      ),
    );
  }
}
