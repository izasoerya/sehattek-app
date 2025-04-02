import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DatePickerGeneral extends StatefulWidget {
  final void Function(DateTime) onDateSelected;

  const DatePickerGeneral({super.key, required this.onDateSelected});

  @override
  State<DatePickerGeneral> createState() => _DatePickerGeneralState();
}

class _DatePickerGeneralState extends State<DatePickerGeneral> {
  late DateTime? _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Delivery Date',
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontSize: 10.sp,
                fontWeight: FontWeight.bold,
              ),
        ),
        SizedBox(height: 5),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.shade200,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: GestureDetector(
            onTap: () async {
              _selectedDate = await showDatePickerDialog(
                  context: context,
                  minDate: DateTime.now(),
                  maxDate: DateTime.now().add(const Duration(days: 365)),
                  selectedDate: DateTime.now(),
                  splashRadius: 12.sp,
                  selectedCellTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 10.5.sp, // Smaller font size
                    fontWeight: FontWeight.bold, // Bold text
                  ),
                  leadingDateTextStyle: TextStyle(
                    color: Colors.black54,
                    fontSize: 10.5.sp, // Smaller font size
                    fontWeight: FontWeight.bold, // Bold text
                  ),
                  currentDateTextStyle: TextStyle(
                    color: Colors.black54,
                    fontSize: 10.5.sp, // Smaller font size
                    fontWeight: FontWeight.bold, // Bold text
                  ),
                  daysOfTheWeekTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 10.5.sp, // Slightly larger for the header
                    fontWeight: FontWeight.bold, // Bold header text
                  ),
                  enabledCellsTextStyle: TextStyle(
                    color: Colors.blue,
                    fontSize: 10.5.sp, // Smaller font size
                    fontWeight: FontWeight.w600, // Bold text for today
                  ),
                  disabledCellsTextStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 10.5.sp, // Smaller font size
                    fontWeight:
                        FontWeight.normal, // Normal weight for disabled dates
                  ));
              widget.onDateSelected(_selectedDate ?? DateTime.now());
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.date_range_outlined, color: Colors.black54),
                SizedBox(width: 10),
                Text(
                  _selectedDate != null
                      ? '${_selectedDate!.day} / ${_selectedDate!.month} / ${_selectedDate!.year}'
                      : 'Select Date',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 11.sp,
                      ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
