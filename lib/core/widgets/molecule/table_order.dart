// table_order.dart
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
import 'package:sizer/sizer.dart';

// === CONFIG ===
const List<String> defaultColumnOrder = [
  'Name',
  'Description',
  'Price',
  'Date',
  'Status',
  'Handler'
];

const int defaultItemsPerPage = 10;
const int defaultStartPage = 1;

const Map<String, FlexColumnWidth> columnFlexWidths = {
  'Name': FlexColumnWidth(2),
  'Description': FlexColumnWidth(3),
  'Price': FlexColumnWidth(2),
  'Date': FlexColumnWidth(1.5),
  'Status': FlexColumnWidth(2),
  'Handler': FlexColumnWidth(3),
};

class TableRowData {
  final List<Map<EntitiesServiceProduct, EntitiesStatusProduct>?> rawOrders;
  final List<Map<String, String>> mapIdtoName;

  List<String> filter;
  int itemsPerPage;
  int currentPage;
  String? sortColumn;
  bool sortAscending = true;

  TableRowData({
    required this.rawOrders,
    required this.mapIdtoName,
    this.itemsPerPage = defaultItemsPerPage,
    this.currentPage = defaultStartPage,
    List<String>? filter,
  }) : filter = filter ?? List.from(defaultColumnOrder);

  List<Map<EntitiesServiceProduct, EntitiesStatusProduct>> get filteredOrders {
    final orders = rawOrders
        .whereType<Map<EntitiesServiceProduct, EntitiesStatusProduct>>()
        .toList();

    if (sortColumn != null) {
      orders.sort((a, b) {
        final productA = a.keys.first;
        final productB = b.keys.first;

        int compareResult = 0;
        switch (sortColumn) {
          case 'Name':
            compareResult = productA.name
                .toLowerCase()
                .compareTo(productB.name.toLowerCase());
            if (compareResult == 0) {
              compareResult =
                  productB.orderDate.compareTo(productA.orderDate); // fallback
            }
            break;
          case 'Description':
            compareResult =
                productA.description.compareTo(productB.description);
            break;
          case 'Price':
            compareResult = productA.price.compareTo(productB.price);
            break;
          case 'Date':
            compareResult =
                productB.orderDate.compareTo(productA.orderDate); // DESC
            break;
          case 'Status':
            compareResult = a.values.first.statusType
                .toString()
                .compareTo(b.values.first.statusType.toString());
            break;
          case 'Handler':
            compareResult = a.values.first.uid
                .toString()
                .compareTo(b.values.first.uid.toString());
            break;
        }
        return sortAscending ? compareResult : -compareResult;
      });
    }

    return orders;
  }

  int get totalPages => (filteredOrders.length / itemsPerPage).ceil();

  List<Map<EntitiesServiceProduct, EntitiesStatusProduct>> get visibleOrders {
    int start = (currentPage - 1) * itemsPerPage;
    int end = min(start + itemsPerPage, filteredOrders.length);
    return filteredOrders.sublist(start, end);
  }

  void updateFilter(List<String> newFilter) => filter = newFilter;
  void goToPage(int page) => currentPage = page;
  void sortByColumn(String column) {
    if (sortColumn == column) {
      sortAscending = !sortAscending;
    } else {
      sortColumn = column;
      sortAscending = true;
    }
  }
}

class TableOrder extends StatefulWidget {
  final List<Map<EntitiesServiceProduct, EntitiesStatusProduct>?> listOrder;
  final List<Map<String, String>> mapIdtoName;

  const TableOrder(
      {super.key, this.listOrder = const [], this.mapIdtoName = const []});

  @override
  State<TableOrder> createState() => _TableOrderState();
}

class _TableOrderState extends State<TableOrder> {
  late TableRowData tableData;
  List<EntitiesProvider> providers = [];
  bool isAdmin = false;

  @override
  void initState() {
    super.initState();
    final authState = context.read<AuthenticationBloc>().state;
    isAdmin = authState is UserLoggedIn && authState.admin != null;

    final initialFilter = List.from(defaultColumnOrder);
    if (!isAdmin) initialFilter.remove('Handler');

    tableData = TableRowData(
      rawOrders: widget.listOrder,
      mapIdtoName: widget.mapIdtoName,
      filter: initialFilter.cast<String>(),
    );

    tableData.sortByColumn('Name');
    _loadProviders();
  }

  Future<void> _loadProviders() async {
    final res = await ServiceAuth().fetchListProvider();
    setState(() => providers = res);
  }

  Map<int, TableColumnWidth> get columnWidths {
    final widths = <int, TableColumnWidth>{};
    for (int i = 0; i < tableData.filter.length; i++) {
      widths[i] =
          columnFlexWidths[tableData.filter[i]] ?? const FlexColumnWidth(1);
    }
    return widths;
  }

  List<Widget> _buildRow(
      EntitiesServiceProduct product, EntitiesStatusProduct status) {
    List<Widget> row = [];

    for (final column in defaultColumnOrder) {
      if (!tableData.filter.contains(column)) continue;

      switch (column) {
        case 'Name':
          row.add(CustomTableCell(label: product.name));
          break;
        case 'Description':
          row.add(CustomTableCell(label: product.description));
          break;
        case 'Price':
          row.add(CustomTableCell(label: product.price.toString()));
          break;
        case 'Date':
          row.add(CustomTableCell(
            label: product.orderDate.toString().substring(0, 10),
          ));
          break;
        case 'Status':
          row.add(CustomTableCell(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: DropdownTable(
                statusType: status.statusType,
                onChanged: (newStatus) => context.read<OrderBloc>().add(
                      OrderEventUpdateStatus(newStatus, product.uid),
                    ),
              ),
            ),
          ));
          break;
        case 'Handler':
          final handlerUid = widget.mapIdtoName.firstWhere(
            (map) => map['uid'] == product.uid,
            orElse: () => {'handlerUid': ''},
          )['handlerUid'];
          final isValid = providers.any((p) => p.uid == handlerUid);

          row.add(
            SizedBox(
              width: 50,
              child: CustomTableCell(
                child: Expanded(
                  child: DropdownButtonFormField<String>(
                    value: isValid ? handlerUid : null,
                    isDense: true,
                    isExpanded: true,
                    decoration: const InputDecoration(border: InputBorder.none),
                    items: providers
                        .map((provider) => DropdownMenuItem<String>(
                              value: provider.uid,
                              child: Text(
                                '${provider.name} (${provider.email})',
                                maxLines: 2,
                                style: TextStyle(fontSize: 10.5.sp),
                                softWrap: true,
                                overflow: TextOverflow.visible,
                              ),
                            ))
                        .toList(),
                    onChanged: (String? newUid) {
                      final authUser = context.read<AuthenticationBloc>().state;
                      final currentUserUid = authUser is UserLoggedIn
                          ? authUser.user?.uid ?? authUser.admin?.uid
                          : null;
                      if (newUid != null && currentUserUid != null) {
                        context.read<OrderBloc>().add(
                              OrderEventUpdateRunnerProviderId(
                                newUid,
                                currentUserUid,
                                product.uid,
                              ),
                            );
                      }
                    },
                  ),
                ),
              ),
            ),
          );
          break;
      }
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
                items: isAdmin
                    ? defaultColumnOrder
                    : defaultColumnOrder.where((e) => e != 'Handler').toList(),
                selectedItems: tableData.filter,
                onSelectionChanged: (selected) =>
                    setState(() => tableData.updateFilter(selected)),
              ),
              if (isAdmin)
                ButtonGeneral(
                  icon: Icon(Icons.add_circle_outline, color: Colors.white),
                  label: Text('Tambahkan'),
                  onPressed: () => showModalCreateOrder(context),
                ),
            ],
          ),
        ),
        Table(
          columnWidths: columnWidths,
          border: TableBorder.all(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10.0),
          ),
          children: [
            TableRow(
              decoration: BoxDecoration(color: Colors.grey.shade200),
              children: defaultColumnOrder
                  .where((header) => tableData.filter.contains(header))
                  .map((header) => GestureDetector(
                        onTap: () =>
                            setState(() => tableData.sortByColumn(header)),
                        child: TableHeader(
                          title: header,
                          isSorted: tableData.sortColumn == header,
                          isAscending: tableData.sortAscending,
                        ),
                      ))
                  .toList(),
            ),
            ...tableData.visibleOrders.map((rowMap) {
              final product = rowMap.keys.first;
              final status = rowMap.values.first;
              return TableRow(
                decoration: BoxDecoration(color: Colors.white),
                children: _buildRow(product, status),
              );
            }),
          ],
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 12.5, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(10.0)),
            border: Border(
                top: BorderSide(color: Colors.grey.shade200, width: 2.5)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  'Showing ${tableData.visibleOrders.length} of ${tableData.filteredOrders.length}'),
              ScrollPages(
                totalPages: tableData.totalPages,
                selectedPage: tableData.currentPage,
                onPageChanged: (page) =>
                    setState(() => tableData.goToPage(page!)),
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
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          return NewOrderPopup(
              listProvider: snapshot.data!,
              onSubmit: (Map<EntitiesServiceProduct, EntitiesProvider> data) {
                context.read<OrderBloc>().add(
                      OrderEventCreate(data.keys.first, data.values.first.uid),
                    );
                Navigator.of(context).pop();
              });
        }
        return Center(child: Text('No data available'));
      },
    ),
  );
}
