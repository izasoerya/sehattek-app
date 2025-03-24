import 'package:flutter/widgets.dart';
import 'package:sehattek_app/core/widgets/molecule/header.dart';

class DashboardPageDesktop extends StatelessWidget {
  const DashboardPageDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Header(),
      ],
    );
  }
}
