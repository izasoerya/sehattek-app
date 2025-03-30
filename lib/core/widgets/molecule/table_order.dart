import 'package:flutter/material.dart';
import 'package:sehattek_app/core/widgets/atom/table_header.dart';
import 'package:sehattek_app/core/widgets/atom/table_value.dart';
import 'package:sehattek_app/ddd/domain/entities/entities_service_product.dart';
import 'package:sehattek_app/ddd/domain/entities/entities_status_product.dart';

class TableOrder extends StatelessWidget {
  final List<EntitiesServiceProduct> listProduct;
  final List<Map<EntitiesServiceProduct, EntitiesStatusProduct>> listOrder;

  const TableOrder(
      {super.key, this.listProduct = const [], this.listOrder = const []});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5.0,
            spreadRadius: 1.0,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(1),
          1: FlexColumnWidth(2),
          2: FlexColumnWidth(1),
          3: FlexColumnWidth(1),
          4: FlexColumnWidth(1),
        },
        children: [
          TableRow(
            decoration: BoxDecoration(
              color: Colors.grey.withValues(alpha: 0.2),
              border: Border(
                bottom: BorderSide(color: Colors.grey.withValues(alpha: 0.2)),
              ),
            ),
            children: [
              TableHeader(title: 'Name'),
              TableHeader(title: 'Description'),
              TableHeader(title: 'Price'),
              TableHeader(title: 'Date'),
              TableHeader(title: 'Status'),
            ],
          ),
          ...listOrder.map((order) {
            return TableRow(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey.withValues(alpha: 0.2)),
                ),
              ),
              children: [
                TableValue(value: order.keys.first.name),
                TableValue(value: order.keys.first.description),
                TableValue(value: order.keys.first.price.toString()),
                TableValue(value: order.keys.first.orderDate.toString()),
                TableValue(value: order.values.first.statusType.toString()),
              ],
            );
          }),
        ],
      ),
    );
  }
}
