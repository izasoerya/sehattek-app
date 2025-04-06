import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sehattek_app/core/widgets/molecule/header.dart';
import 'package:sehattek_app/core/widgets/molecule/table_order.dart';
import 'package:sehattek_app/ddd/service/service_auth.dart';
import 'package:sehattek_app/ddd/service/service_order.dart';
import 'package:sehattek_app/presentation/blocs/auth/auth_bloc.dart';
import 'package:sehattek_app/presentation/blocs/auth/auth_state.dart';
import 'package:sehattek_app/presentation/blocs/order/order_bloc.dart';
import 'package:sehattek_app/presentation/blocs/order/order_state.dart';
import 'package:sizer/sizer.dart';

class OrderPageMobile extends StatelessWidget {
  const OrderPageMobile({super.key});

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

          // Fetch service runner list and provider names
          return FutureBuilder<List<Map<String, String>>>(
            future: _fetchMapIdToName(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                final mapIdtoName = snapshot.data!;

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
                        child: TableOrder(
                          listOrder: listOrder,
                          mapIdtoName: mapIdtoName,
                        ),
                      ),
                      SizedBox(height: 10.sh),
                    ],
                  ),
                );
              }

              // Handle unexpected states
              return const Center(
                child: Text('Unexpected error occurred.'),
              );
            },
          );
        }

        // Handle unexpected states
        return const Center(
          child: Text('Unexpected state. Please try again later.'),
        );
      },
    );
  }

  Future<List<Map<String, String>>> _fetchMapIdToName(
      BuildContext context) async {
    final authUser = context.read<AuthenticationBloc>().state;

    // Ensure the user is logged in and has a valid provider or admin UID
    String? providerUid;
    if (authUser is UserLoggedIn) {
      if (authUser.user != null) {
        providerUid = authUser.user!.uid;
        print('User ID: $providerUid');
      } else if (authUser.admin != null) {
        providerUid = authUser.admin!.uid;
        print('Admin ID: $providerUid');
      }
    }

    if (providerUid == null) {
      throw Exception('No valid provider or admin UID found.');
    }

    try {
      // Fetch the service runner list using the provider UID
      final serviceRunners = await ServiceOrder().readListRunner(providerUid);

      // Fetch providers based on runner UID and map them to names
      final List<Map<String, String>> mapIdtoName = [];
      for (final runner in serviceRunners) {
        final provider =
            await ServiceAuth().fetchProviderByUid(runner.uidProvider);
        if (provider != null) {
          mapIdtoName.add({
            'uid': runner.uidServiceProduct,
            'handlerUid': runner.uidProvider,
            'name': '${provider.name}\n${provider.email}',
          });
        }
      }

      return mapIdtoName;
    } catch (e) {
      throw Exception('Failed to fetch service runner or provider data: $e');
    }
  }
}
