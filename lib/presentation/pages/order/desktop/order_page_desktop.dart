import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sehattek_app/core/widgets/molecule/footer.dart';
import 'package:sehattek_app/core/widgets/molecule/header.dart';
import 'package:sehattek_app/core/widgets/molecule/table_order.dart';
import 'package:sehattek_app/presentation/blocs/order/order_bloc.dart';
import 'package:sehattek_app/presentation/blocs/order/order_state.dart';
import 'package:sizer/sizer.dart';

class OrderPageDesktop extends StatelessWidget {
  const OrderPageDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        if (state is OrderStateLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is OrderStateError) {
          return Center(child: Text('Error: ${state.message}'));
        } else if (state is OrderStateSuccess) {
          final listOrder = state.listOrder;

          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
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
          );
        }

        // Handle unexpected states
        return const Center(
          child: Text('Unexpected state. Please try again later.'),
        );
      },
    );
  }
}
