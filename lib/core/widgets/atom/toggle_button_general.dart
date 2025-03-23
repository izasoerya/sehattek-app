import 'package:flutter/material.dart';

class ToggleButtonGeneral extends StatefulWidget {
  const ToggleButtonGeneral({super.key});

  @override
  State<ToggleButtonGeneral> createState() => _ToggleButtonGeneralState();
}

class _ToggleButtonGeneralState extends State<ToggleButtonGeneral> {
  bool _isAdmin = true;
  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      constraints: BoxConstraints(
        minWidth: 100,
        minHeight: 30,
        maxHeight: 30,
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
        });
      },
      children: [
        Row(
          children: [
            Icon(Icons.person, size: 15),
            const SizedBox(width: 7.5),
            Text('Admin'),
          ],
        ),
        Row(
          children: [
            Icon(Icons.person, size: 15),
            const SizedBox(width: 7.5),
            Text('Provider'),
          ],
        ),
      ],
    );
  }
}
