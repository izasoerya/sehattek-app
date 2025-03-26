import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CommonLayout extends StatelessWidget {
  final Widget child;
  const CommonLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: () {
            if (GoRouterState.of(context).uri.toString() == '/login' ||
                GoRouterState.of(context).uri.toString() == '/register') {
              LinearGradient(
                colors: [
                  Color.fromRGBO(220, 234, 254, 1), // Start color
                  Color.fromRGBO(239, 246, 255, 1), // End color
                ],
                begin: Alignment.centerRight, // Gradient starts at the top
                end: Alignment.centerLeft, // Gradient ends at the bottom
              );
            } else {
              LinearGradient(
                colors: [
                  Colors.grey.shade400, // Start color
                  Colors.grey.shade400, // End color
                ],
                begin: Alignment.topCenter, // Gradient starts at the top
                end: Alignment.bottomCenter, // Gradient ends at the bottom
              );
            }
          }(),
        ),
        child: child,
      ),
    );
  }
}
