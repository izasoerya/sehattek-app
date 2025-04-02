import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ToggleButtonGeneral extends StatefulWidget {
  final void Function(bool)? onChanged;

  const ToggleButtonGeneral({super.key, this.onChanged});

  @override
  State<ToggleButtonGeneral> createState() => _ToggleButtonGeneralState();
}

class _ToggleButtonGeneralState extends State<ToggleButtonGeneral> {
  bool _isAdmin = true;
  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width * 0.08,
        minHeight: 5.sh,
      ),
      borderRadius: BorderRadius.circular(5),
      isSelected: [_isAdmin, !_isAdmin],
      color: Colors.blueAccent,
      selectedColor: Colors.white,
      fillColor: Colors.blueAccent,
      borderColor: Colors.blueAccent,
      selectedBorderColor: Colors.blueAccent,
      onPressed: (index) {
        setState(() {
          _isAdmin = index == 0;
          widget.onChanged!(_isAdmin);
        });
      },
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person, size: 13.sp),
            SizedBox(width: 5.sp),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Admin',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: _isAdmin ? Colors.white : Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                      )),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person, size: 13.sp),
            SizedBox(width: 5.sp),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Provider',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: _isAdmin ? Colors.blueAccent : Colors.white,
                        fontWeight: FontWeight.bold,
                      )),
            ),
          ],
        ),
      ],
    );
  }
}
