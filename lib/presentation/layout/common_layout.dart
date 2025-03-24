import 'package:flutter/material.dart';

class CommonLayout extends StatelessWidget {
  final Widget child;
  const CommonLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(220, 234, 254, 1), // Start color
              Color.fromRGBO(239, 246, 255, 1), // End color
            ],
            begin: Alignment.centerRight, // Gradient starts at the top
            end: Alignment.centerLeft, // Gradient ends at the bottom
          ),
        ),
        child: child,
      ),
    );
  }
}
