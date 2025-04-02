import 'dart:math';
import 'package:sehattek_app/ddd/service/service_auth.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sehattek_app/core/utils/enumeration.dart';
import 'package:sehattek_app/core/widgets/atom/button_general.dart';
import 'package:sehattek_app/core/widgets/atom/custom_table_cell.dart';
import 'package:sehattek_app/core/widgets/atom/table_button.dart';
import 'package:sehattek_app/core/widgets/atom/table_header.dart';
import 'package:sehattek_app/core/widgets/atom/multi_select_dropdown_button.dart';
import 'package:sehattek_app/core/widgets/atom/dropdown_table.dart';
import 'package:sehattek_app/core/widgets/molecule/new_order_popup.dart';
import 'package:sehattek_app/core/widgets/molecule/scroll_pages.dart';
import 'package:sehattek_app/ddd/domain/entities/entities_service_product.dart';
import 'package:sehattek_app/ddd/domain/entities/entities_status_product.dart';
import 'package:sehattek_app/presentation/blocs/order/order_bloc.dart';
import 'package:sehattek_app/presentation/blocs/order/order_event.dart';

/// A model to hold row data along with the uid for internal use.
class TableRowData {
  final String uid;
  final List<String> displayRow;

  TableRowData({required this.uid, required this.displayRow});
}

class TableOrder extends StatefulWidget {
  final List<Map<EntitiesServiceProduct, EntitiesStatusProduct>?> listOrder;

  const TableOrder({super.key, this.listOrder = const []});

  @override
  State<TableOrder> createState() => _TableOrderState();
}

class _TableOrderState extends State<TableOrder> {
  // Dropdown fields that determine which columns to show
  List<String> dropdownValues = [
    'Name',
    'Description',
    'Price',
    'Date',
    'Status'
  ];

  // Pagination state
  int currentPage = 1;
  final int itemsPerPage = 10;

  /// Full table data extracted from listOrder as a list of TableRowData.
  List<TableRowData> get tableData {
    List<TableRowData> data = [];
    for (int i = 0; i < widget.listOrder.length; i++) {
      final order = widget.listOrder[i];
      if (order == null) {
        data.add(TableRowData(uid: '', displayRow: ['']));
        continue;
      }
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
      data.add(TableRowData(uid: product.uid, displayRow: row));
    }
    data.sort((a, b) => a.displayRow[0].compareTo(b.displayRow[0]));
    return data;
  }

  /// Data to display for the current page.
  List<TableRowData> get visibleData {
    int start = max(0, (currentPage - 1) * itemsPerPage);
    int end = min(start + itemsPerPage, tableData.length);
    if (start < tableData.length) {
      return tableData.sublist(start, end);
    } else {
      return [];
    }
  }

  /// Control column widths.
  Map<int, TableColumnWidth> get columnWidths {
    final widths = <int, TableColumnWidth>{};
    for (int i = 0; i < dropdownValues.length; i++) {
      // For example, make the second column wider.
      widths[i] = FlexColumnWidth(i == 1 ? 2 : 1);
    }
    return widths;
  }

  @override
  Widget build(BuildContext context) {
    final totalPages = (tableData.length / itemsPerPage).ceil();

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          // Header row with export, dropdown, and add button.
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
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context) => FutureBuilder(
                        future: ServiceAuth().fetchListProvider(),
                        builder: (context, snapshot) {
                          print('snapshot: ${snapshot.data}');
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }
                          return NewOrderPopup();
                        }),
                  ),
                ),
              ],
            ),
          ),
          // Table displaying headers and visible data rows.
          Table(
            columnWidths: columnWidths,
            children: [
              // Header row.
              TableRow(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  border: Border.symmetric(
                    horizontal: BorderSide(color: Colors.grey.withOpacity(0.2)),
                  ),
                ),
                children: dropdownValues
                    .map((header) => TableHeader(title: header))
                    .toList(),
              ),
              // Data rows.
              ...visibleData.map(
                (rowData) => TableRow(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(color: Colors.grey.withOpacity(0.2)),
                    ),
                  ),
                  children: rowData.displayRow.asMap().entries.map((entry) {
                    // Sort by name
                    int index = entry.key;
                    String cellValue = entry.value;
                    if (index == 4) {
                      return CustomTableCell(
                        label: cellValue,
                        child: DropdownTable(
                          statusType: StatusType.fromString(cellValue),
                          onChanged: (newStatus) => context
                              .read<OrderBloc>()
                              .add(
                                OrderEventUpdateStatus(newStatus, rowData.uid),
                              ),
                        ),
                      );
                    } else {
                      return CustomTableCell(
                        label: cellValue,
                        child: Text(
                          cellValue,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontSize: 11.sp),
                        ),
                      );
                    }
                  }).toList(),
                ),
              ),
            ],
          ),
          // Footer with page info and pagination controls.
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12.5, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(10.0)),
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
      ),
    );
  }
}
