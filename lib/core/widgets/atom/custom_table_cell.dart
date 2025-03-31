import 'package:flutter/material.dart';
import 'package:sehattek_app/core/utils/enumeration.dart';
import 'package:sehattek_app/core/widgets/atom/dropdown_table.dart';
import 'package:sizer/sizer.dart';

class CustomTableCell extends StatefulWidget {
  final String label;

  const CustomTableCell({super.key, required this.label});

  @override
  State<CustomTableCell> createState() => _CustomTableCellState();
}

class _CustomTableCellState extends State<CustomTableCell> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(),
      child: !widget.label.contains('Status')
          ? Text(
              widget.label,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 11.sp,
                  ),
            )
          : DropdownTable(statusType: StatusType.fromString(widget.label)),
    );
  }
}
