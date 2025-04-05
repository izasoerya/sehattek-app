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
    final res = await ServiceOrder().createOrder(event.order, event.providerId);
    if (res.isLeft) {
      final res2 = await ServiceOrder().readListOrder(event.providerId);
      if (res2.isLeft) {
        emit(OrderStateSuccess(res2.left));
      } else {
        emit(OrderStateError(res2.right.message));
      }
    } else {
      emit(OrderStateError(res.right.message));
    }
  }

  void _onFetchListOrderWithStatus(
      OrderEventFetchListWithStatus event, Emitter<OrderState> emit) async {
    emit(OrderStateLoading());
    final res = await ServiceOrder().readListOrder(event.providerId);
    if (res.isLeft) {
      emit(OrderStateSuccess(res.left));
    } else {
      emit(OrderStateError(res.right.message));
    }
  }

  void _onUpdateStatusOrder(
      OrderEventUpdateStatus event, Emitter<OrderState> emit) async {
    emit(OrderStateLoading());
    final newOrder = await ServiceOrder()
        .updateStatusOrder(event.statusType, event.productId);
    final res2 = await ServiceOrder().readListOrder(newOrder.uidProvider);
    if (res2.isLeft) {
      emit(OrderStateSuccess(res2.left));
    } else {
      emit(OrderStateError(res2.right.message));
    }
  }
}
