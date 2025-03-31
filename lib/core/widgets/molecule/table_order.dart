import 'package:flutter/material.dart';
import 'package:sehattek_app/core/widgets/atom/button_general.dart';
import 'package:sehattek_app/core/widgets/atom/custom_table_cell.dart';
import 'package:sehattek_app/core/widgets/atom/table_header.dart';
import 'package:sehattek_app/core/widgets/atom/multi_select_dropdown_button.dart';
import 'package:sehattek_app/ddd/domain/entities/entities_service_product.dart';
import 'package:sehattek_app/ddd/domain/entities/entities_status_product.dart';

class TableOrder extends StatefulWidget {
  final List<Map<EntitiesServiceProduct, EntitiesStatusProduct>> listOrder;

  const TableOrder({
    super.key,
    this.listOrder = const [],
  });

  @override
  State<TableOrder> createState() => _TableOrderState();
}

class _TableOrderState extends State<TableOrder> {
  List<String> get tableHeaders => dropdownValues;
  List<String> dropdownValues = [
    'Name',
    'Description',
    'Price',
    'Date',
    'Status'
  ];

  List<List<String>> get tableData {
    return widget.listOrder.map((order) {
      final product = order.keys.first;
      final status = order.values.first;
      List<String> row = [];
      if (dropdownValues.contains('Name')) {
        row.add(product.name);
      }
      if (dropdownValues.contains('Description')) {
        row.add(product.description);
      }
      if (dropdownValues.contains('Price')) {
        row.add(product.price.toString());
      }
      if (dropdownValues.contains('Date')) {
        row.add(product.orderDate.toString().substring(0, 10));
      }
      if (dropdownValues.contains('Status')) {
        row.add(status.statusType.toString());
      }
      return row;
    }).toList();
  }

  Map<int, TableColumnWidth> get columnWidths {
    final widths = <int, TableColumnWidth>{};
    for (int i = 0; i < tableHeaders.length; i++) {
      widths[i] = FlexColumnWidth(i == 1 ? 2 : 1);
    }
    return widths;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Order List',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 14, fontWeight: FontWeight.bold)),
              IntrinsicWidth(
                child: MultiSelectDropdownButton(
                  items: ['Name', 'Description', 'Price', 'Date', 'Status'],
                  selectedItems: dropdownValues,
                  onSelectionChanged: (selected) {
                    setState(() => dropdownValues = selected);
                  },
                ),
              ),
              const SizedBox(width: 20),
              ButtonGeneral(
                icon: Icon(Icons.add_circle_outline, color: Colors.white),
                label: Text('Tambahkan'),
                onPressed: () {},
              ),
            ],
          ),
        ),
        Table(
          columnWidths: columnWidths,
          children: [
            TableRow(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                border: Border.symmetric(
                    horizontal:
                        BorderSide(color: Colors.grey.withOpacity(0.2))),
              ),
              children: tableHeaders
                  .map((header) => TableHeader(title: header))
                  .toList(),
            ),
            ...tableData.map(
              (row) => TableRow(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.withOpacity(0.2)),
                  ),
                ),
                children:
                    row.map((value) => CustomTableCell(label: value)).toList(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
