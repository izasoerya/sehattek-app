import 'package:flutter/material.dart';

class ButtonGeneral extends StatelessWidget {
  final Text label;
  final Icon? icon;
  final void Function()? onPressed;

  const ButtonGeneral({
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
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) icon!,
            SizedBox(width: icon != null ? 10 : 0),
            label,
          ],
        ),
      ),
    );
  }
}
