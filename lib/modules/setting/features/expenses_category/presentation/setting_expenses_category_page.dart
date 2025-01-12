import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_receipt/data/models/category_model.dart';
import 'package:flutter_receipt/modules/setting/features/expenses_category/providers/setting_expenses_category_provider.dart';
import 'package:provider/provider.dart';

class SettingExpensesCategoryPage extends StatefulWidget {
  const SettingExpensesCategoryPage({super.key});

  @override
  State<SettingExpensesCategoryPage> createState() => _SettingExpensesCategoryPageState();
}

class _SettingExpensesCategoryPageState extends State<SettingExpensesCategoryPage> {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SettingExpensesCategoryProvider()..init(),
      child: Consumer<SettingExpensesCategoryProvider>(
        builder: (BuildContext context, SettingExpensesCategoryProvider provider, Widget? child) {
          return Scaffold(
            appBar: _buildAppBar(context),
            body: _buildBody(context, provider),
            floatingActionButton: _buildFloatingActionButton(context, provider),
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
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
        AppLocalizations.of(context)!.expensesCategory,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, SettingExpensesCategoryProvider provider) {
    if (provider.isLoading) {
      return Center(child: CircularProgressIndicator.adaptive());
    }

    if (provider.expensesCategories.isEmpty) {
      return Center(
        child: Text('${AppLocalizations.of(context)!.none} ${AppLocalizations.of(context)!.expensesCategory}'),
      );
    }

    return RefreshIndicator.adaptive(
      onRefresh: () => provider.fetchExpensesCategories(),
      child: ListView.builder(
        itemCount: provider.expensesCategories.length,
        itemBuilder: (context, index) {
          final category = provider.expensesCategories[index];
          return _item(context, category, provider);
        },
      ),
    );
  }

  FloatingActionButton _buildFloatingActionButton(BuildContext context, SettingExpensesCategoryProvider provider) {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      tooltip: AppLocalizations.of(context)!.add,
      child: Icon(Icons.add),
      onPressed: () async => _showBottomSheet(context, false, provider),
    );
  }

  Widget _item(
    BuildContext context,
    CategoryModel item,
    SettingExpensesCategoryProvider provider,
  ) {
    return ListTile(
      title: Text(item.name),
      subtitle: Text('Created At: ${item.createdAt}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () async => _showBottomSheet(context, true, provider, item: item),
            icon: Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () async => _showDeleteDialog(context, item, provider),
            icon: Icon(Icons.delete),
          ),
        ],
      ),
    );
  }

  Future<dynamic> _showBottomSheet(
    BuildContext context,
    bool isEdit,
    SettingExpensesCategoryProvider provider, {
    CategoryModel? item,
  }) {
    _nameController.clear();
    provider.setName('');
    if (item != null) {
      _nameController.text = item.name;
      provider.setName(item.name);
    }
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          minChildSize: 0.25,
          maxChildSize: 1.0,
          initialChildSize: 0.25,
          expand: false,
          builder: (BuildContext context, ScrollController scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        '${isEdit ? AppLocalizations.of(context)!.edit : AppLocalizations.of(context)!.add} ${AppLocalizations.of(context)!.expensesCategory}',
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(labelText: AppLocalizations.of(context)!.name),
                      onChanged: (value) => provider.setName(value),
                    ),
                    SizedBox(height: 10.0),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          foregroundColor: Theme.of(context).colorScheme.onPrimary,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                          padding: EdgeInsets.symmetric(vertical: 14.0),
                        ),
                        onPressed: () async {
                          Navigator.pop(context);
                          if (!isEdit) {
                            final isSuccess = await provider.addExpensesCategory();
                            if (isSuccess && context.mounted) provider.fetchExpensesCategories();
                          }

                          if (isEdit && item != null) {
                            final isSuccess = await provider.updateExpensesCategory(item.id!);
                            if (isSuccess && context.mounted) provider.fetchExpensesCategories();
                          }
                          _nameController.clear();
                        },
                        child: Text(isEdit ? AppLocalizations.of(context)!.update : AppLocalizations.of(context)!.save),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<dynamic> _showDeleteDialog(
    BuildContext context,
    CategoryModel item,
    SettingExpensesCategoryProvider provider,
  ) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog.adaptive(
          title: Text('${AppLocalizations.of(context)!.delete} ${AppLocalizations.of(context)!.expensesCategory}'),
          content: Text(AppLocalizations.of(context)!.deleteDialogContent(item.name)),
          actions: <Widget>[
            TextButton(
              child: Text(AppLocalizations.of(context)!.cancel),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text(
                AppLocalizations.of(context)!.delete,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
              onPressed: () async {
                Navigator.of(context).pop();
                await provider.deleteExpensesCategory(item.id!);
                provider.fetchExpensesCategories();
              },
            ),
          ],
        );
      },
    );
  }
}
