import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AuthContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;

  const AuthContainer(
      {super.key, required this.child, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 25.sw,
      height: 65.sh,
      padding: const EdgeInsets.only(
        left: 30,
        right: 30,
        top: 20,
        bottom: 15,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}
