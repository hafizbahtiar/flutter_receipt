import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_receipt/modules/home/features/home_add_provider.dart';
import 'package:flutter_receipt/widgets/my_dropdown.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeAddPage extends StatefulWidget {
  const HomeAddPage({super.key});

  @override
  State<HomeAddPage> createState() => _HomeAddPageState();
}

class _HomeAddPageState extends State<HomeAddPage> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _dateController.text = DateFormat('dd/MM/yyyy (EEE) HH:mm').format(DateTime.now());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeAddProvider()..init(),
      child: Consumer<HomeAddProvider>(
        builder: (BuildContext context, HomeAddProvider provider, Widget? child) {
          return Scaffold(
            appBar: _buildAppBar(context, provider),
            body: _buildBody(context, provider),
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, HomeAddProvider provider) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      leading: IconButton(
        color: Theme.of(context).colorScheme.onPrimary,
        tooltip: AppLocalizations.of(context)!.back,
        icon: Icon(Icons.adaptive.arrow_back),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        '${AppLocalizations.of(context)!.add} ${provider.transactionTypeMap[provider.selectedIndex] == 'income' ? AppLocalizations.of(context)!.income : AppLocalizations.of(context)!.expenses}',
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, HomeAddProvider provider) {
    final DateTime firstDate = DateTime(2000);
    final DateTime lastDate = DateTime(2100);

    return ListView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Wrap(
                spacing: 10.0,
                children: [
                  if (provider.transactionType != null && provider.transactionType!.isNotEmpty)
                    ...provider.transactionType!.map(
                      (item) {
                        return _buildSegmentButton(
                          label: AppLocalizations.of(context)!.income,
                          index: item.id,
                          isSelected: provider.selectedIndex == item.id,
                          onPressed: () => provider.setSelectedIndex(item.id),
                        );
                      },
                    ),
                ],
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: _dateController,
                onChanged: (value) => provider.setDate(value),
                decoration: InputDecoration(labelText: AppLocalizations.of(context)!.date),
                readOnly: true,
                onTap: () async {
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: firstDate,
                    lastDate: lastDate,
                  );
                  if (pickedDate != null && context.mounted) {
                    final TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(DateTime.now()),
                    );
                    if (pickedTime != null) {
                      final DateTime combinedDateTime = DateTime(
                        pickedDate.year,
                        pickedDate.month,
                        pickedDate.day,
                        pickedTime.hour,
                        pickedTime.minute,
                      );
                      setState(() {
                        _dateController.text = DateFormat('dd/MM/yyyy (EEE) HH:mm').format(combinedDateTime);
                      });
                      provider.setDate(DateFormat('yyyy-MM-dd HH:mm:ss').format(combinedDateTime));
                    }
                  }
                },
              ),
              const SizedBox(height: 10.0),
              TextField(
                controller: _amountController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.amount,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onChanged: (value) {
                  final double? amount = double.tryParse(value);
                  if (amount != null) {
                    provider.setAmount(amount);
                  }
                },
              ),
              const SizedBox(height: 10.0),
              MyDropdown(
                onSelected: (value) => provider.transactionTypeMap[provider.selectedIndex] == 'income'
                    ? provider.setSelectedIncomeCategoryId(value!)
                    : provider.setSelectedExpensesCategoryId(value!),
                selectedValue: provider.transactionTypeMap[provider.selectedIndex] == 'income'
                    ? provider.selectedIncomeCategoryId
                    : provider.selectedExpensesCategoryId,
                label: AppLocalizations.of(context)!.category,
                items: provider.transactionTypeMap[provider.selectedIndex] == 'income'
                    ? provider.incomeCategoriesMap.map((key, value) => MapEntry(key.toString(), value))
                    : provider.expensesCategoriesMap.map((key, value) => MapEntry(key.toString(), value)),
              ),
              const SizedBox(height: 10.0),
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14.0),
                  ),
                  onPressed: () async {
                    if (provider.transactionTypeMap[provider.selectedIndex] == 'income') {
                      final isSuccess = await provider.addIncome();
                      if (isSuccess && context.mounted) Navigator.pop(context, isSuccess);
                    }
                  },
                  child: Text(AppLocalizations.of(context)!.save),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSegmentButton({
    required String label,
    required int index,
    required bool isSelected,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width / 2 - 21.0,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.surface,
          foregroundColor:
              isSelected ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.onSurface,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          padding: EdgeInsets.symmetric(
            vertical: 15.0,
            horizontal: 10.0,
          ),
        ),
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}
