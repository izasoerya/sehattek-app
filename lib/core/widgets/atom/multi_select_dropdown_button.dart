import 'package:flutter/material.dart';

class MultiSelectDropdownButton extends StatefulWidget {
  final List<String> items;
  final List<String> selectedItems;
  final Function(List<String>) onSelectionChanged;

  const MultiSelectDropdownButton({
    super.key,
    required this.items,
    required this.selectedItems,
    required this.onSelectionChanged,
  });

  @override
  State<MultiSelectDropdownButton> createState() =>
      _MultiSelectDropdownButtonState();
}

class _MultiSelectDropdownButtonState extends State<MultiSelectDropdownButton> {
  late List<String> _selectedItems;

  @override
  void initState() {
    super.initState();
    _selectedItems = List.from(widget.selectedItems);
  }

  void _showMultiSelectDialog() async {
    final List<String>? results = await showDialog<List<String>>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Select Options'),
              content: SingleChildScrollView(
                child: Column(
                  children: widget.items.map((item) {
                    final bool isSelected = _selectedItems.contains(item);
                    return CheckboxListTile(
                      title: Text(item),
                      value: isSelected,
                      onChanged: (bool? checked) {
                        setState(() {
                          if (checked ?? false) {
                            _selectedItems.add(item);
                          } else {
                            _selectedItems.remove(item);
                          }

                          // Custom sort: Name, Description, Price, Date, Status
                          const order = [
                            'Name',
                            'Description',
                            'Price',
                            'Date',
                            'Status'
                          ];
                          _selectedItems.sort((a, b) =>
                              order.indexOf(a).compareTo(order.indexOf(b)));
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              actions: [
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () => Navigator.pop(context, widget.selectedItems),
                ),
                ElevatedButton(
                  child: const Text('OK'),
                  onPressed: () => Navigator.pop(context, _selectedItems),
                ),
              ],
            );
          },
        );
      },
    );

    if (results != null) {
      setState(() => _selectedItems = results);
      widget.onSelectionChanged(results);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _showMultiSelectDialog,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.filter_list_alt,
              color: Colors.grey,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                _selectedItems.isEmpty ? 'Filter' : _selectedItems.join(', '),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
