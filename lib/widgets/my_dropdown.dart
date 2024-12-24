import 'package:flutter/material.dart';

class MyDropdown extends StatelessWidget {
  final TextEditingController? controller;
  final bool isLoading;
  final bool enableSearch;
  final bool enableFilter;
  final double? height;
  final String label;
  final String? errorLabel;
  final String? selectedValue;
  final Map<String, dynamic>? items;
  final Function(String?) onSelected;

  const MyDropdown({
    super.key,
    this.items,
    this.selectedValue,
    required this.onSelected,
    this.isLoading = false,
    required this.label,
    this.errorLabel,
    this.height,
    this.controller,
    this.enableSearch = true,
    this.enableFilter = false,
  });

  @override
  Widget build(BuildContext context) {
    final validSelectedValue = (items != null && items!.isNotEmpty && items!.containsKey(selectedValue))
        ? selectedValue
        : (items != null && items!.isNotEmpty ? items!.keys.first : null);

    return LayoutBuilder(
      builder: (context, constraints) {
        return DropdownMenu<String>(
          initialSelection: validSelectedValue,
          controller: controller,
          dropdownMenuEntries: (items ?? {}).entries.map((entry) {
            return DropdownMenuEntry<String>(
              value: entry.key.toString(),
              label: entry.value.toString(),
            );
          }).toList(),
          enableSearch: enableSearch,
          enableFilter: enableFilter,
          menuHeight: 300,
          width: constraints.maxWidth,
          label: Text(label),
          errorText: errorLabel,
          onSelected: onSelected,
        );
      },
    );
  }
}
