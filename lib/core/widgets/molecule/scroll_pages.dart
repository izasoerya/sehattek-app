import 'package:flutter/material.dart';
import 'package:sehattek_app/core/widgets/atom/page_button.dart';
import 'package:sizer/sizer.dart';
import 'dart:math';

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
    // print('totalPages: $totalPages, selectedPage: $selectedPage');
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
    selectedPage = newPage;
    widget.onPageChanged(selectedPage);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Double left arrow: Go to first page
          IconButton(
            icon: const Icon(Icons.first_page),
            onPressed: () => _updatePage(1),
          ),
          // Single left arrow: Previous page
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () => _updatePage(max(selectedPage - 1, 1)),
          ),
          // Animated group of page buttons (only 3 visible at a time)
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 100),
            transitionBuilder: (child, animation) => SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.1, 0),
                end: const Offset(0, 0),
              ).animate(animation),
              child: child,
            ),
            child: Row(
              // The key changes when visiblePages changes so AnimatedSwitcher animates.
              key: ValueKey<List<int>>(visiblePages),
              children: visiblePages.map((pageNumber) {
                return PageButton(
                  pageNumber: pageNumber,
                  isSelected: pageNumber == selectedPage,
                  onPressed: () => _updatePage(pageNumber),
                );
              }).toList(),
            ),
          ),
          // Single right arrow: Next page
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: () => _updatePage(min(selectedPage + 1, totalPages)),
          ),
          // Double right arrow: Go to last page
          IconButton(
            icon: const Icon(Icons.last_page),
            onPressed: () => _updatePage(totalPages),
          ),
        ],
      ),
    );
  }
}
