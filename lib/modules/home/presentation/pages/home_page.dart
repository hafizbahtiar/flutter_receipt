import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_receipt/core/constants/hero_tag.dart';
import 'package:flutter_receipt/data/models/income_model.dart';
import 'package:flutter_receipt/modules/home/providers/home_provider.dart';
import 'package:flutter_receipt/routes/router_name.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeProvider()..init(),
      child: Consumer<HomeProvider>(
        builder: (BuildContext context, HomeProvider provider, Widget? child) {
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
      title: Text(
        AppLocalizations.of(context)!.helloWorld,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
            ),
      ),
      actions: [
        IconButton(
          color: Theme.of(context).colorScheme.onPrimary,
          tooltip: AppLocalizations.of(context)!.setting,
          icon: Icon(Icons.settings),
          onPressed: () => Navigator.pushNamed(context, RouterName.settings),
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context, HomeProvider provider) {
    if (provider.isLoading) {
      return Center(child: CircularProgressIndicator.adaptive());
    }

    if (provider.incomeRecords.isEmpty) {
      return Center(
        child: Text('${AppLocalizations.of(context)!.none} ${AppLocalizations.of(context)!.transaction}'),
      );
    }

    return RefreshIndicator.adaptive(
      onRefresh: () => provider.fetchAllIncome(),
      child: ListView.builder(
        itemCount: provider.incomeRecords.length,
        itemBuilder: (context, index) {
          final category = provider.incomeRecords[index];
          return _item(context, category, provider);
        },
      ),
    );
  }

  FloatingActionButton _buildFloatingActionButton(BuildContext context, HomeProvider provider) {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      tooltip: AppLocalizations.of(context)!.createNew,
      heroTag: HeroTag.createNew,
      onPressed: () async {
        final isRefresh = await Navigator.pushNamed(context, RouterName.homeAdd) as bool? ?? false;
        if (isRefresh) provider.fetchAllIncome();
      },
      child: const Icon(Icons.create),
    );
  }

  Widget _item(
    BuildContext context,
    IncomeModel item,
    HomeProvider provider,
  ) {
    return ListTile(
      title: Text('RM ${item.amount.toString()} (${provider.incomeCategoriesMap[item.categoryId]})'),
      subtitle: Text('Created At: ${item.createdAt}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () async => _showDeleteDialog(context, item, provider),
            icon: Icon(Icons.delete),
          ),
        ],
      ),
    );
  }

  Future<dynamic> _showDeleteDialog(
    BuildContext context,
    IncomeModel item,
    HomeProvider provider,
  ) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog.adaptive(
          title: Text('${AppLocalizations.of(context)!.delete} ${AppLocalizations.of(context)!.incomeCategory}'),
          content: Text(AppLocalizations.of(context)!.deleteDialogContent('test')),
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
                await provider.deleteIncome(item.id!);
                provider.fetchAllIncome();
              },
            ),
          ],
        );
      },
    );
  }
}
