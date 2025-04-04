import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sehattek_app/ddd/service/service_order.dart';
import 'package:sehattek_app/presentation/blocs/order/order_event.dart';
import 'package:sehattek_app/presentation/blocs/order/order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderStateInitial()) {
    on<OrderEventCreate>(_onCreateOrder);
    on<OrderEventUpdateStatus>(_onUpdateStatusOrder);
    on<OrderEventFetchListWithStatus>(_onFetchListOrderWithStatus);
  }

  void _onCreateOrder(OrderEventCreate event, Emitter<OrderState> emit) async {
    emit(OrderStateLoading());
    try {
      await ServiceOrder().createOrder(event.order, event.providerId);
      final res2 = await ServiceOrder().readListOrder(event.providerId);
      emit(OrderStateSuccess(res2));
    } catch (e) {
      emit(OrderStateError('An unexpected error occurred'));
    }
  }

  void _onFetchListOrderWithStatus(
      OrderEventFetchListWithStatus event, Emitter<OrderState> emit) async {
    emit(OrderStateLoading());
    try {
      final res = await ServiceOrder().readListOrder(event.providerId);
      emit(OrderStateSuccess(res));
    } catch (e) {
      emit(OrderStateError('An unexpected error occurred'));
    }
  }

  void _onUpdateStatusOrder(
      OrderEventUpdateStatus event, Emitter<OrderState> emit) async {
    emit(OrderStateLoading());
    try {
      final newOrder = await ServiceOrder()
          .updateStatusOrder(event.statusType, event.productId);
      final res = await ServiceOrder().readListOrder(newOrder[0].uidProvider);
      emit(OrderStateSuccess(res));
    } catch (e) {
      emit(OrderStateError('An unexpected error occurred'));
    }
  }
}
