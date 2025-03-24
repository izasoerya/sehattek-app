import 'package:flutter/material.dart';

class TextButtonGeneral extends StatelessWidget {
  final String text;
  final void Function() onPressed;

  const TextButtonGeneral(
      {super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Colors.blueAccent,
              decoration: TextDecoration.underline,
              decorationColor: Colors.blueAccent,
            ),
      ),
    );
  }
}
