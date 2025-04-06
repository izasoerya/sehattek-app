import 'package:flutter/material.dart';
import 'package:sehattek_app/core/widgets/atom/page_button.dart';
import 'package:sizer/sizer.dart';

class ScrollPages extends StatefulWidget {
  final int totalPages;
  final int selectedPage;
  final void Function(int? page) onPageChanged;

  const ScrollPages({
    super.key,
    required this.totalPages,
    required this.selectedPage,
    required this.onPageChanged,
  });

  @override
  State<ScrollPages> createState() => _ScrollPagesState();
}

class _ScrollPagesState extends State<ScrollPages> {
  late int selectedPage = widget.selectedPage;
  late int totalPages = widget.totalPages;

  /// Returns a list of three page numbers to display based on selectedPage.
  List<int> get visiblePages {
    if (totalPages <= 3) {
      return List.generate(totalPages, (index) => index + 1);
    } else if (selectedPage <= 2) {
      return [1, 2, 3];
    } else if (selectedPage >= totalPages - 1) {
      return [totalPages - 2, totalPages - 1, totalPages];
    } else {
      return [selectedPage - 1, selectedPage, selectedPage + 1];
    }
  }

  void _updatePage(int newPage) {
    setState(() {
      selectedPage = newPage;
    });
    widget.onPageChanged(selectedPage);
  }

  @override
  Widget build(BuildContext context) {
    final double iconSize =
        MediaQuery.of(context).size.width < 600 ? 12.sp : 15.sp;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.first_page),
            iconSize: iconSize,
            onPressed: selectedPage > 1 ? () => _updatePage(1) : null,
          ),
          IconButton(
            icon: const Icon(Icons.chevron_left),
            iconSize: iconSize,
            onPressed:
                selectedPage > 1 ? () => _updatePage(selectedPage - 1) : null,
          ),
          ...visiblePages.map((pageNumber) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: PageButton(
                  pageNumber: pageNumber,
                  isSelected: pageNumber == selectedPage,
                  onPressed: () => _updatePage(pageNumber),
                ),
              )),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            iconSize: iconSize,
            onPressed: selectedPage < totalPages
                ? () => _updatePage(selectedPage + 1)
                : null,
          ),
          IconButton(
            icon: const Icon(Icons.last_page),
            iconSize: iconSize,
            onPressed: selectedPage < totalPages
                ? () => _updatePage(totalPages)
                : null,
          ),
        ],
      ),
    );
  }
}
