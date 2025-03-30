import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sehattek_app/ddd/service/service_order.dart';
import 'package:sehattek_app/presentation/blocs/order/order_event.dart';
import 'package:sehattek_app/presentation/blocs/order/order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderStateInitial()) {
    // on<OrderEventFetch>(_onFetchOrder);
    // on<OrderEventFetchList>(_onFetchListOrder);
    on<OrderEventFetchListWithStatus>(_onFetchListOrderWithStatus);
  }

  // void _onFetchOrder(OrderEventFetch event, Emitter<OrderState> emit) async {
  //   emit(OrderStateLoading());
  //   try {
  //     final res = await ServiceOrder().readListProduct(event.orderId);
  //     emit(OrderStateSuccess(res.map((e) => e).toList()));
  //   } catch (e) {
  //     emit(OrderStateError('An unexpected error occurred'));
  //   }
  // }

  // void _onFetchListOrder(
  //     OrderEventFetchList event, Emitter<OrderState> emit) async {
  //   emit(OrderStateLoading());
  //   try {
  //     final res = await ServiceOrder().readListProduct(event.providerId);
  //     emit(OrderStateSuccess(res.map((e) => e).toList()));
  //   } catch (e) {
  //     emit(OrderStateError('An unexpected error occurred'));
  //   }
  // }

  void _onFetchListOrderWithStatus(
      OrderEventFetchListWithStatus event, Emitter<OrderState> emit) async {
    emit(OrderStateLoading());
    try {
      final res = await ServiceOrder().readListOrder(event.providerId);
      emit(OrderStateSuccess(res.map((e) => e).toList()));
    } catch (e) {
      emit(OrderStateError('An unexpected error occurred'));
    }
  }
}
