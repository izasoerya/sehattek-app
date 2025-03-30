import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TableValue extends StatelessWidget {
  final String value;

  const TableValue({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(),
      child: TableCell(
        child: Text(
          value,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontSize: 11.sp,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }
}
