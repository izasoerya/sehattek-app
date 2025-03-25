import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sehattek_app/core/widgets/atom/card_container.dart';
import 'package:sehattek_app/core/widgets/molecule/footer.dart';
import 'package:sehattek_app/core/widgets/molecule/header.dart';
import 'package:sizer/sizer.dart';

class DashboardPageDesktop extends StatelessWidget {
  const DashboardPageDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Header(),
        SizedBox(height: 10.sh),
        Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text('Streamline Your Process',
                      style: Theme.of(context).textTheme.headlineLarge),
                  SizedBox(height: 2.h),
                  Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                      style: Theme.of(context).textTheme.headlineSmall),
                  SizedBox(height: 5.sh),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(flex: 3),
                      CardContainer(
                          icon: 'checkout',
                          title: 'Active Orders',
                          value: '10'),
                      Spacer(),
                      CardContainer(
                        icon: 'history',
                        title: 'Total Orders',
                        value: '10',
                      ),
                      Spacer(),
                      CardContainer(
                        icon: 'done',
                        title: 'Success Orders',
                        value: '10',
                      ),
                      Spacer(flex: 3),
                    ],
                  ),
                ],
              ),
              Footer(),
            ],
          ),
        ),
      ],
    );
  }
}
