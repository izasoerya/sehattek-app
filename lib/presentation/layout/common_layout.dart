import 'package:flutter/material.dart';
import 'package:sehattek_app/presentation/layout/theme.dart';

class CommonLayout extends StatelessWidget {
  final Widget child;
  CommonLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: child,
    );
  }
}
