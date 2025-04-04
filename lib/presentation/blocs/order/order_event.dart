import 'package:sehattek_app/core/utils/enumeration.dart';
import 'package:sehattek_app/ddd/domain/entities/entities_service_product.dart';

abstract class OrderEvent {}

class OrderEventCreate extends OrderEvent {
  final EntitiesServiceProduct order;
  final String providerId;

  OrderEventCreate(this.order, this.providerId);
}

class OrderEventFetch extends OrderEvent {
  final String orderId;

  OrderEventFetch(this.orderId);
}

class OrderEventFetchList extends OrderEvent {
  final String providerId;

  OrderEventFetchList(this.providerId);
}

class OrderEventFetchListWithStatus extends OrderEvent {
  final String providerId;

  OrderEventFetchListWithStatus(this.providerId);
}

class OrderEventUpdateStatus extends OrderEvent {
  final String productId;
  final StatusType statusType;

  OrderEventUpdateStatus(this.statusType, this.productId);
}
