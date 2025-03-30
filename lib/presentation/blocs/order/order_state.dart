import 'package:sehattek_app/ddd/domain/entities/entities_service_product.dart';

abstract class OrderState {}

class OrderStateInitial extends OrderState {}

class OrderStateLoading extends OrderState {}

class OrderStateSuccess extends OrderState {
  final List<EntitiesServiceProduct> listOrder;

  OrderStateSuccess(this.listOrder);
}

class OrderStateError extends OrderState {
  final String message;

  OrderStateError(this.message);
}
