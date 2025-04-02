import 'package:flutter/material.dart';
import 'package:sehattek_app/core/utils/enumeration.dart';

class CustomTableCell extends StatefulWidget {
  final Widget? child;
  final String label;

  const CustomTableCell({super.key, required this.label, this.child});

  @override
  State<CustomTableCell> createState() => _CustomTableCellState();
}

class _CustomTableCellState extends State<CustomTableCell> {
  StatusType type = StatusType.pending;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40,
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 7.5),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(),
        child: widget.child);
  }
}
