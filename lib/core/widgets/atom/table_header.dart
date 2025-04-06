import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TableHeader extends StatelessWidget {
  final String title;
  final bool isSorted;
  final bool isAscending;

  const TableHeader({
    super.key,
    required this.title,
    this.isSorted = false,
    this.isAscending = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 1.5.sw, vertical: 2.sh),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 11.5.sp,
                  fontWeight: FontWeight.bold,
                ),
          ),
          if (isSorted)
            Icon(
              isAscending ? Icons.arrow_upward : Icons.arrow_downward,
              size: 16,
            ),
        ],
      ),
    );
  }
}
