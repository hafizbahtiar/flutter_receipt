import 'package:flutter/material.dart';
import 'package:flutter_receipt/modules/setting/presentation/setting_card.dart';
import 'package:flutter_receipt/routes/router_name.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
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
        AppLocalizations.of(context)!.setting,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    const divider = Padding(
      padding: EdgeInsets.symmetric(horizontal: 50.0),
      child: Divider(thickness: 0.9, height: 0.5),
    );

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 15.0),
      children: <Widget>[
        SettingCard(
          content: Column(
            children: [
              ListTile(
                leading: Icon(Icons.category),
                title: Text(AppLocalizations.of(context)!.incomeCategory),
                onTap: () => Navigator.pushNamed(context, RouterName.settingsIncomeCategory),
                trailing: Icon(Icons.arrow_forward_ios_outlined),
              ),
              divider,
              ListTile(
                leading: Icon(Icons.category),
                title: Text(AppLocalizations.of(context)!.expensesCategory),
                onTap: () => Navigator.pushNamed(context, RouterName.settingsExpensesCategory),
                trailing: Icon(Icons.arrow_forward_ios_outlined),
              ),
              divider,
              ListTile(
                leading: Icon(Icons.percent),
                title: Text(AppLocalizations.of(context)!.tax),
                onTap: () => Navigator.pushNamed(context, RouterName.settingsTax),
                trailing: Icon(Icons.arrow_forward_ios_outlined),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10.0),
        SettingCard(
          content: Column(
            children: [
              ListTile(
                leading: Icon(Icons.language),
                title: Text(AppLocalizations.of(context)!.language),
                onTap: () => Navigator.pushNamed(context, RouterName.settingsLanguage),
                trailing: Icon(Icons.arrow_forward_ios_outlined),
              ),
              divider,
              ListTile(
                leading: Icon(Icons.color_lens),
                title: Text(AppLocalizations.of(context)!.theme),
                onTap: () => Navigator.pushNamed(context, RouterName.settingsThemeMode),
                trailing: Icon(Icons.arrow_forward_ios_outlined),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
