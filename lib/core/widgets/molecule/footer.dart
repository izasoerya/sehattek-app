import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white54,
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '© 2023 Trackker Enterprise. All rights reserved.',
                style: TextStyle(fontSize: 14.0),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  // Handle privacy policy action
                },
                child: Text('Privacy Policy'),
              ),
              Text(' | '),
              TextButton(
                onPressed: () {
                  // Handle terms of service action
                },
                child: Text('Terms of Service'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
