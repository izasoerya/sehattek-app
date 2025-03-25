import 'package:flutter/material.dart';

class CardContainer extends StatefulWidget {
  final String icon;
  final String title;
  final String value;

  const CardContainer({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  State<CardContainer> createState() => _CardContainerState();
}

class _CardContainerState extends State<CardContainer> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovered = true; // Set the hover state to true
        });
      },
      onExit: (_) {
        setState(() {
          _isHovered = false; // Set the hover state to false
        });
      },
      child: Container(
        width: 175,
        height: 175,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: _isHovered ? 5 : 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: AnimatedOpacity(
          opacity: _isHovered ? 0.8 : 1.0,
          duration: Duration(milliseconds: 500),
          child: AnimatedScale(
            scale: _isHovered ? 1.05 : 1.0, // Scale the card on hover
            duration: Duration(milliseconds: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('icon/${widget.icon}.png', height: 50),
                SizedBox(height: 8),
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.value,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
