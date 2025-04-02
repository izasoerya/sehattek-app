import 'package:flutter/material.dart';

class ButtonOauth extends StatelessWidget {
  final String label;
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
          backgroundColor: Colors.grey.shade500,
          side: BorderSide(color: Colors.grey.shade200),
          elevation: 0,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Icon(
                icon,
                color: Colors.white,
              ),
            SizedBox(width: icon != null ? 10 : 0),
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
