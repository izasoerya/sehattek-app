import 'package:flutter/material.dart';

class ButtonOauth extends StatelessWidget {
  final Text label;
  final IconData? icon;
  final void Function()? onPressed;

  const ButtonOauth({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          backgroundColor: ThemeData().colorScheme.secondary,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) Icon(icon),
            SizedBox(width: icon != null ? 10 : 0),
            label,
          ],
        ),
      ),
    );
  }
}
