import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sehattek_app/core/widgets/atom/button_general.dart';
import 'package:sehattek_app/core/widgets/atom/custom_table_cell.dart';
import 'package:sehattek_app/core/widgets/atom/dropdown_table.dart';
import 'package:sehattek_app/core/widgets/atom/multi_select_toggle_button.dart';
import 'package:sehattek_app/core/widgets/atom/table_header.dart';
import 'package:sehattek_app/core/widgets/molecule/new_order_popup.dart';
import 'package:sehattek_app/core/widgets/molecule/scroll_pages.dart';
import 'package:sehattek_app/ddd/domain/entities/entities_provider.dart';
import 'package:sehattek_app/ddd/domain/entities/entities_service_product.dart';
import 'package:sehattek_app/ddd/domain/entities/entities_status_product.dart';
import 'package:sehattek_app/ddd/service/service_auth.dart';
import 'package:sehattek_app/presentation/blocs/auth/auth_bloc.dart';
import 'package:sehattek_app/presentation/blocs/auth/auth_state.dart';
import 'package:sehattek_app/presentation/blocs/order/order_bloc.dart';
import 'package:sehattek_app/presentation/blocs/order/order_event.dart';

class TableRowData {
  final List<Map<EntitiesServiceProduct, EntitiesStatusProduct>?> rawOrders;

  List<String> filter = ['Name', 'Description', 'Price', 'Date', 'Status'];
  int itemsPerPage = 10;
  int currentPage = 1;

  TableRowData({required this.rawOrders});

  List<Map<EntitiesServiceProduct, EntitiesStatusProduct>> get filteredOrders {
    return rawOrders
        .whereType<Map<EntitiesServiceProduct, EntitiesStatusProduct>>()
        .toList();
  }

  int get totalPages => (filteredOrders.length / itemsPerPage).ceil();

  List<Map<EntitiesServiceProduct, EntitiesStatusProduct>> get visibleOrders {
    int start = (currentPage - 1) * itemsPerPage;
    int end = min(start + itemsPerPage, filteredOrders.length);
    return filteredOrders.sublist(start, end);
  }

  void updateFilter(List<String> newFilter) => filter = newFilter;
  void goToPage(int page) => currentPage = page;
}

class TableOrder extends StatefulWidget {
  final List<Map<EntitiesServiceProduct, EntitiesStatusProduct>?> listOrder;

  const TableOrder({super.key, this.listOrder = const []});

  @override
  State<TableOrder> createState() => _TableOrderState();
}

class _TableOrderState extends State<TableOrder> {
  late TableRowData tableData;

  @override
  void initState() {
    super.initState();
    tableData = TableRowData(rawOrders: widget.listOrder);
  }

  Map<int, TableColumnWidth> get columnWidths {
    final widths = <int, TableColumnWidth>{};
    for (int i = 0; i < tableData.filter.length; i++) {
      widths[i] = FlexColumnWidth(i == 1 ? 2 : 1);
    }
    return widths;
  }

  List<Widget> _buildRow(
      EntitiesServiceProduct product, EntitiesStatusProduct status) {
    List<Widget> row = [];
    if (tableData.filter.contains('Name')) {
      row.add(CustomTableCell(label: product.name));
    }
    if (tableData.filter.contains('Description')) {
      row.add(CustomTableCell(label: product.description));
    }
    if (tableData.filter.contains('Price')) {
      row.add(CustomTableCell(label: product.price.toString()));
    }
    if (tableData.filter.contains('Date')) {
      row.add(CustomTableCell(
          label: product.orderDate.toString().substring(0, 10)));
    }
    if (tableData.filter.contains('Status')) {
      row.add(CustomTableCell(
        child: DropdownTable(
          statusType: status.statusType,
          onChanged: (newStatus) => context.read<OrderBloc>().add(
                OrderEventUpdateStatus(newStatus, product.uid),
              ),
        ),
      ));
    }
    return row;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12.5, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MultiSelectToggleButton(
                items: ['Name', 'Description', 'Price', 'Date', 'Status'],
                selectedItems: tableData.filter,
                onSelectionChanged: (selected) {
                  setState(() => tableData.updateFilter(selected));
                },
              ),
              Builder(
                builder: (context) {
                  final authState = context.read<AuthenticationBloc>().state;
                  if (authState is UserLoggedIn && authState.admin != null) {
                    return ButtonGeneral(
                      icon: Icon(Icons.add_circle_outline, color: Colors.white),
                      label: Text('Tambahkan'),
                      onPressed: () => showModalCreateOrder(context),
                    );
                  }
                  return SizedBox();
                },
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
              ),
              children: tableData.filter
                  .map((header) => TableHeader(title: header))
                  .toList(),
            ),
            ...tableData.visibleOrders.map(
              (rowMap) {
                final product = rowMap.keys.first;
                final status = rowMap.values.first;
                return TableRow(
                  decoration: BoxDecoration(color: Colors.white),
                  children: _buildRow(product, status),
                );
              },
            )
          ],
        ),
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
                  'Showing ${tableData.visibleOrders.length} of ${tableData.filteredOrders.length}'),
              ScrollPages(
                totalPages: tableData.totalPages,
                selectedPage: tableData.currentPage,
                onPageChanged: (page) {
                  setState(() => tableData.goToPage(page!));
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Future<dynamic> showModalCreateOrder(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) => FutureBuilder(
        future: ServiceAuth().fetchListProvider(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            return NewOrderPopup(
              listProvider: snapshot.data!,
              onSubmit: (Map<EntitiesServiceProduct, EntitiesProvider> data) =>
                  context.read<OrderBloc>().add(
                      OrderEventCreate(data.keys.first, data.values.first.uid)),
            );
          }
          return Center(
            child: Text('No data available'),
          );
        }),
  );
}
