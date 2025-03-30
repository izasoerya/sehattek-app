abstract class OrderEvent {}

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
