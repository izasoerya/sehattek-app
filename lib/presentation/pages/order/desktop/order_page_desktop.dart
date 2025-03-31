import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sehattek_app/core/widgets/molecule/footer.dart';
import 'package:sehattek_app/core/widgets/molecule/header.dart';
import 'package:sehattek_app/core/widgets/molecule/table_order.dart';
import 'package:sehattek_app/ddd/domain/entities/entities_service_product.dart';
import 'package:sehattek_app/ddd/domain/entities/entities_status_product.dart';
import 'package:sehattek_app/presentation/blocs/auth/auth_bloc.dart';
import 'package:sehattek_app/presentation/blocs/auth/auth_state.dart';
import 'package:sehattek_app/presentation/blocs/order/order_bloc.dart';
import 'package:sehattek_app/presentation/blocs/order/order_event.dart';
import 'package:sehattek_app/presentation/blocs/order/order_state.dart';
import 'package:sehattek_app/presentation/router/router.dart';
import 'package:sizer/sizer.dart';

class OrderPageDesktop extends StatefulWidget {
  const OrderPageDesktop({super.key});

  @override
  State<OrderPageDesktop> createState() => _OrderPageDesktopState();
}

class _OrderPageDesktopState extends State<OrderPageDesktop> {
  List<Map<EntitiesServiceProduct, EntitiesStatusProduct>> listOrder = [];

  @override
  void initState() {
    super.initState();
    final authState = context.read<AuthenticationBloc>().state;
    if (authState is UserLoggedIn) {
      context
          .read<OrderBloc>()
          .add(OrderEventFetchListWithStatus(authState.user.uid));
    } else {
      router.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderBloc, OrderState>(
      listener: (context, state) {
        if (state is OrderStateSuccess) {
          setState(() => listOrder = state.listOrder);
        }
      },
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Header(),
            SizedBox(height: 10.sh),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5.w),
              constraints: BoxConstraints(minHeight: 60.h),
              child: TableOrder(listOrder: listOrder),
            ),
            SizedBox(height: 10.sh),
            Footer(),
          ],
        ),
      ),
    );
  }
}
