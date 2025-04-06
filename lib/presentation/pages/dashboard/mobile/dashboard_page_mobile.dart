import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sehattek_app/core/utils/enumeration.dart';
import 'package:sehattek_app/core/widgets/atom/card_container.dart';
import 'package:sehattek_app/core/widgets/molecule/footer.dart';
import 'package:sehattek_app/core/widgets/molecule/header.dart';
import 'package:sehattek_app/ddd/domain/entities/entities_service_product.dart';
import 'package:sehattek_app/ddd/domain/entities/entities_status_product.dart';
import 'package:sehattek_app/presentation/blocs/auth/auth_bloc.dart';
import 'package:sehattek_app/presentation/blocs/auth/auth_state.dart';
import 'package:sehattek_app/presentation/blocs/order/order_bloc.dart';
import 'package:sehattek_app/presentation/blocs/order/order_event.dart';
import 'package:sehattek_app/presentation/blocs/order/order_state.dart';
import 'package:sizer/sizer.dart';

class DashboardPageMobile extends StatefulWidget {
  const DashboardPageMobile({super.key});

  @override
  State<DashboardPageMobile> createState() => _DashboardPageMobileState();
}

class _DashboardPageMobileState extends State<DashboardPageMobile> {
  @override
  void initState() {
    super.initState();
    final authUser = context.read<AuthenticationBloc>().state;
    if (authUser is UserLoggedIn) {
      if (authUser.user != null) {
        print('User ID: ${authUser.user!.uid}');
        context
            .read<OrderBloc>()
            .add(OrderEventFetchListWithStatus(authUser.user!.uid));
      } else if (authUser.admin != null) {
        print('Admin ID: ${authUser.admin!.uid}');
        context
            .read<OrderBloc>()
            .add(OrderEventFetchListWithStatus(authUser.admin!.uid));
      }
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        List<Map<EntitiesServiceProduct, EntitiesStatusProduct>> data = [];
        if (state is OrderStateLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is OrderStateSuccess) {
          data = state.listOrder;
          return Column(
            children: [
              Header(),
              SizedBox(height: 5.sh),
              Column(
                children: [
                  Text('Streamline Your Process',
                      style: Theme.of(context).textTheme.headlineLarge),
                  SizedBox(height: 2.h),
                  Text('Manage your orders and track their status in one place',
                      style: Theme.of(context).textTheme.headlineSmall),
                  SizedBox(height: 5.sh),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(flex: 1),
                      CardContainer(
                        fontSizeTitle: 15.sp,
                        fontSizeValue: 25.sp,
                        icon: 'checkout',
                        title: 'In Progress Orders',
                        value: data
                            .where((element) =>
                                element.values.first.statusType ==
                                StatusType.inProgress)
                            .length
                            .toString(),
                      ),
                      Spacer(),
                      CardContainer(
                        fontSizeTitle: 15.sp,
                        fontSizeValue: 25.sp,
                        icon: 'history',
                        title: 'Total Orders',
                        value: data.length.toString(),
                      ),
                      Spacer(),
                      CardContainer(
                        fontSizeTitle: 15.sp,
                        fontSizeValue: 25.sp,
                        icon: 'done',
                        title: 'Success Orders',
                        value: data
                            .where((element) =>
                                element.values.first.statusType ==
                                StatusType.complete)
                            .length
                            .toString(),
                      ),
                      Spacer(flex: 1),
                    ],
                  ),
                ],
              ),
              Spacer(),
              Footer(),
            ],
          );
        }
        return const Center(
          child: Text('Error loading data'),
        );
      },
    );
  }
}
