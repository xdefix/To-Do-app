import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: TextField(
          decoration: InputDecoration(
          hintText: AppLocalizations.of(context)!.dev_text,
          ),
        ),
      ),
    );
  }
}
