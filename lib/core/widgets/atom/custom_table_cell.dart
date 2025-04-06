import 'package:flutter/material.dart';
import 'package:sehattek_app/core/utils/enumeration.dart';
import 'package:sizer/sizer.dart';

class CustomTableCell extends StatefulWidget {
  final String? label;
  final Widget? child;

  const CustomTableCell({super.key, this.label, this.child});

  @override
  State<CustomTableCell> createState() => _CustomTableCellState();
}

class _CustomTableCellState extends State<CustomTableCell> {
  StatusType type = StatusType.pending;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 1.sw, vertical: 2.sh),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            widget.label != null
                ? Expanded(
                    child: Text(
                      widget.label!,
                      style: TextStyle(
                        fontSize: 11.5.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                  )
                : widget.child!,
          ],
        ));
  }
}
