import 'package:flutter/material.dart';
import '../constants/colors.dart';

class ToggleSortButton extends StatelessWidget {
  final bool isSortedByDate;
  final VoidCallback onToggleSort;

  const ToggleSortButton({
    Key? key,
    required this.isSortedByDate,
    required this.onToggleSort,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onToggleSort,
      style: ElevatedButton.styleFrom(
        backgroundColor: tdBlue,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      ),
      child: Text(
        isSortedByDate ? 'Sort by Name' : 'Sort by Date',
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
