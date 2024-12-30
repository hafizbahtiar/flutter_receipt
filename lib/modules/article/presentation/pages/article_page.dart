// lib/presentation/pages/article_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_receipt/modules/article/presentation/providers/article_provider.dart';
import 'package:flutter_receipt/modules/article/presentation/widgets/article_item_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ArticlePage extends StatelessWidget {
  const ArticlePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ArticleProvider()..init(),
      child: Consumer<ArticleProvider>(
        builder: (BuildContext context, ArticleProvider provider, Widget? _) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                tooltip: AppLocalizations.of(context)!.back,
                icon: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text(
                AppLocalizations.of(context)!.article,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
            body: provider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : provider.errorMessage != null
                    ? Center(child: Text(provider.errorMessage!))
                    : ListView.builder(
                        itemCount: provider.articles.length,
                        itemBuilder: (context, index) {
                          return ArticleItemWidget(article: provider.articles[index]);
                        },
                      ),
          );
        },
      ),
    );
  }
}
