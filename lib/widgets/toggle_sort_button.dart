import 'package:flutter/material.dart';
import '../constants/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        isSortedByDate
            ? AppLocalizations.of(context)!.sort_name
            : AppLocalizations.of(context)!.sort_date,
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
