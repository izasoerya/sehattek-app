import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sehattek_app/ddd/service/service_order.dart';
import 'package:sehattek_app/presentation/blocs/order/order_event.dart';
import 'package:sehattek_app/presentation/blocs/order/order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderStateInitial()) {
    on<OrderEventFetch>((event, emit) async {
      emit(OrderStateLoading());
      try {
        final res = await ServiceOrder().readListOrder(event.orderId);
        emit(OrderStateSuccess(res.map((e) => e!).toList()));
      } catch (e) {
        emit(OrderStateError('An unexpected error occurred'));
      }
    });
    on<OrderEventFetchList>((event, emit) async {
      emit(OrderStateLoading());
      try {
        final res = await ServiceOrder().readListOrder(event.providerId);
        emit(OrderStateSuccess(res.map((e) => e!).toList()));
      } catch (e) {
        emit(OrderStateError('An unexpected error occurred'));
      }
    });
  }
}
