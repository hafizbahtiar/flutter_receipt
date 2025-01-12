import 'package:flutter/material.dart';

class SettingCard extends StatelessWidget {
  const SettingCard({super.key, required this.content});

  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      color: Theme.of(context).colorScheme.surfaceContainer,
      margin: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 2.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      clipBehavior: Clip.antiAlias,
      child: content,
    );
  }
}
