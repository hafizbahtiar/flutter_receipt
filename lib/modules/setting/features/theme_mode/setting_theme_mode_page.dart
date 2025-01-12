import 'package:flutter/material.dart';
import 'package:flutter_receipt/providers/user_pref_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingThemeModePage extends StatelessWidget {
  const SettingThemeModePage({super.key});

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
        AppLocalizations.of(context)!.mode,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final providerUserPrefs = Provider.of<UserPrefsProvider>(context, listen: false);
    final watchUserPrefs = Provider.of<UserPrefsProvider>(context, listen: true);

    return ListView(
      children: [
        RadioListTile<ThemeMode>(
          title: Text(AppLocalizations.of(context)!.lightMode),
          value: ThemeMode.light,
          groupValue: watchUserPrefs.themeMode,
          onChanged: (ThemeMode? value) {
            if (value != null) {
              providerUserPrefs.setThemeMode(value);
            }
          },
        ),
        RadioListTile<ThemeMode>(
          title: Text(AppLocalizations.of(context)!.darkMode),
          value: ThemeMode.dark,
          groupValue: watchUserPrefs.themeMode,
          onChanged: (ThemeMode? value) {
            if (value != null) {
              providerUserPrefs.setThemeMode(value);
            }
          },
        ),
        RadioListTile<ThemeMode>(
          title: Text(AppLocalizations.of(context)!.systemMode),
          value: ThemeMode.system,
          groupValue: watchUserPrefs.themeMode,
          onChanged: (ThemeMode? value) {
            if (value != null) {
              providerUserPrefs.setThemeMode(value);
            }
          },
        ),
      ],
    );
  }
}
