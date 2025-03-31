import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TableHeader extends StatelessWidget {
  final String title;

  const TableHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: TableCell(
        child: Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 11.sp,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }
}
