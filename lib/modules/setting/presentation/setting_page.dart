import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_receipt/providers/user_pref_provider.dart';
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
      leading: IconButton(
        tooltip: AppLocalizations.of(context)!.back,
        icon: Icon(
          Icons.arrow_back_ios_new_outlined,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        AppLocalizations.of(context)!.setting,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 5.0,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ListTile(
              title: Text(AppLocalizations.of(context)!.language),
              trailing: _buildLanguageDropdown(context),
            ),
            ListTile(
              title: Text(
                Provider.of<UserPrefsProvider>(context).isDarkMode
                    ? '${AppLocalizations.of(context)!.deactivate} ${AppLocalizations.of(context)!.darkMode}'
                    : '${AppLocalizations.of(context)!.activate} ${AppLocalizations.of(context)!.darkMode}',
              ),
              trailing: _buildDarkModeSwitch(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageDropdown(BuildContext context) {
    final prefsProvider = Provider.of<UserPrefsProvider>(context, listen: false);
    final prefsWatch = Provider.of<UserPrefsProvider>(context);

    return DropdownButton<String>(
      value: prefsWatch.languageCode,
      onChanged: (value) => prefsProvider.setLanguageCode(value!),
      items: {'ms': 'Bahasa Melayu', 'en': 'English'}
          .entries
          .map((entry) => DropdownMenuItem<String>(
                value: entry.key,
                child: Text(entry.value),
              ))
          .toList(),
    );
  }

  Widget _buildDarkModeSwitch(BuildContext context) {
    return Switch(
      value: Provider.of<UserPrefsProvider>(context).isDarkMode,
      onChanged: (value) => Provider.of<UserPrefsProvider>(context, listen: false).setDarkMode(value),
    );
  }
}
