import 'package:flutter/material.dart';

class TableButton extends StatelessWidget {
  final Widget child;

  const TableButton({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(5),
        ),
        child: child,
      ),
    );
  }
}
