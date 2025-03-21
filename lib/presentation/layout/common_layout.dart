import 'package:flutter/material.dart';

class CommonLayout extends StatelessWidget {
  final Widget child;
  const CommonLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeData().scaffoldBackgroundColor,
      body: child,
    );
  }
}
