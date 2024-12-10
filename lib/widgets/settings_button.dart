import 'package:flutter/material.dart';
import '../constants/colors.dart';

class SettingsButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SettingsButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.settings, color: tdBlue),
      onPressed: onPressed,
    );
  }
}
