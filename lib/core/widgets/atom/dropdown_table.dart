import 'package:flutter/material.dart';
import 'package:sehattek_app/core/utils/enumeration.dart';
import 'package:sizer/sizer.dart';

class DropdownTable extends StatefulWidget {
  final StatusType statusType;

  const DropdownTable({super.key, required this.statusType});

  @override
  State<DropdownTable> createState() => _DropdownTableState();
}

class _DropdownTableState extends State<DropdownTable> {
  late StatusType selectedStatusType = widget.statusType;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedStatusType.status,
      icon: SizedBox(),
      underline: SizedBox(),
      items: StatusType.values.map((e) {
        return DropdownMenuItem<String>(
          value: e.status,
          child: Container(
            height: 30,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              color: () {
                if (e == StatusType.pending) {
                  return Colors.orange.shade100;
                } else if (e == StatusType.complete) {
                  return Colors.green.shade100;
                } else if (e == StatusType.cancel) {
                  return Colors.red.shade100;
                } else if (e == StatusType.inProgress) {
                  return Colors.blue.shade100;
                } else {
                  return Colors.white;
                }
              }(),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              e.status,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 10.5.sp,
                  ),
            ),
          ),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          selectedStatusType = StatusType.fromString(newValue!);
        });
      },
    );
  }
}
