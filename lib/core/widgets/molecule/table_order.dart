import 'dart:math';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:sehattek_app/core/widgets/atom/button_general.dart';
import 'package:sehattek_app/core/widgets/atom/custom_table_cell.dart';
import 'package:sehattek_app/core/widgets/molecule/scroll_pages.dart';
import 'package:sehattek_app/core/widgets/atom/table_button.dart';
import 'package:sehattek_app/core/widgets/atom/table_header.dart';
import 'package:sehattek_app/core/widgets/atom/multi_select_dropdown_button.dart';
import 'package:sehattek_app/ddd/domain/entities/entities_service_product.dart';
import 'package:sehattek_app/ddd/domain/entities/entities_status_product.dart';

class TableOrder extends StatefulWidget {
  final List<Map<EntitiesServiceProduct, EntitiesStatusProduct>?> listOrder;

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

  // Pagination state
  int currentPage = 1;
  final int itemsPerPage = 6;

  // Full table data extracted from listOrder
  List<List<String>> get tableData {
    return widget.listOrder.map((order) {
      if (order == null) return ['']; // Null is waiting for data
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

  // Data to display for the current page
  List<List<String>> get visibleData {
    int start = max(0, (currentPage - 1) * itemsPerPage);
    int end = min(start + itemsPerPage, tableData.length);
    if (start < tableData.length) {
      return tableData.sublist(start, end);
    } else {
      return [];
    }
  }

  // Control column widths
  Map<int, TableColumnWidth> get columnWidths {
    final widths = <int, TableColumnWidth>{};
    for (int i = 0; i < tableHeaders.length; i++) {
      widths[i] = FlexColumnWidth(i == 1 ? 2 : 1);
    }
    return widths;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.listOrder[0] == null) {
      return Center(child: CircularProgressIndicator());
    }
    final totalPages = (tableData.length / itemsPerPage).ceil();

    return Column(
      children: [
        // Header row with export, dropdown, and add button
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 12.5, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TableButton(
                    child: Row(
                      children: [
                        Icon(Icons.upload_sharp, color: Colors.grey),
                        const SizedBox(width: 10),
                        Text(
                          'Export Data',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontSize: 11.sp),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  MultiSelectDropdownButton(
                    items: ['Name', 'Description', 'Price', 'Date', 'Status'],
                    selectedItems: dropdownValues,
                    onSelectionChanged: (selected) {
                      setState(() => dropdownValues = selected);
                    },
                  ),
                ],
              ),
              ButtonGeneral(
                icon: Icon(Icons.add_circle_outline, color: Colors.white),
                label: Text('Tambahkan'),
                onPressed: () {},
              ),
            ],
          ),
        ),
        // Table displaying headers and visible data rows
        Table(
          columnWidths: columnWidths,
          children: [
            TableRow(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                border: Border.symmetric(
                  horizontal: BorderSide(
                    color: Colors.grey.withOpacity(0.2),
                  ),
                ),
              ),
              children: tableHeaders
                  .map((header) => TableHeader(title: header))
                  .toList(),
            ),
            ...visibleData.map(
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
        // Footer with page info and pagination controls
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12.5, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(10.0)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Showing ${visibleData.length} of ${tableData.length}',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 11.sp),
              ),
              ScrollPages(
                totalPages: totalPages,
                selectedPage: currentPage,
                onPageChanged: (page) {
                  setState(() => currentPage = page!);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
