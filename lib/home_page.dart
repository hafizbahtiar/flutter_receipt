import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_receipt/widgets/my_dropdown.dart';
import 'package:flutter_receipt/providers/user_pref_provider.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final prefsProvider = Provider.of<UserPrefsProvider>(context, listen: false);
    final prefsWatch = Provider.of<UserPrefsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.helloWorld),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              MyDropdown(
                selectedValue: prefsWatch.languageCode,
                onSelected: (value) => prefsProvider.setLanguageCode(value!),
                label: AppLocalizations.of(context)!.language,
                items: {'ms': 'Bahasa Melayu', 'en': 'English'},
              ),
              Switch(
                value: prefsWatch.isDarkMode,
                onChanged: (value) => prefsProvider.setDarkMode(value),
              ),
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        label: Row(
          spacing: 5.0,
          children: [
            const Icon(Icons.add),
            Text(AppLocalizations.of(context)!.add),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
