import 'package:flutter/material.dart';
import '../constants/colors.dart';

class LanguageToggleButton extends StatelessWidget {
  final VoidCallback onPressed;

  const LanguageToggleButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.language, color: tdBlue),
      onPressed: onPressed,
    );
  }
}
