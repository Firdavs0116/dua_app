import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_dua_app/core/constants/app_colors.dart';
import 'package:my_dua_app/features/dua/domain/entities/dua_entity.dart';

class DuaDetailsPage extends StatelessWidget {
  final DuaEntity dua;

  const DuaDetailsPage({super.key, required this.dua});

  @override
  Widget build(BuildContext context) {
    final localeCode = Localizations.localeOf(context).languageCode;
    print("dua details page ga kirdi");
    final translation = dua.translations[localeCode] ?? dua.translations['en'];
    final title = translation?.title ?? '';
    final meaning = translation?.meaning ?? '';
    final explanation = translation?.explanation ?? '';
    final reference = translation?.reference ?? '';
    final category = dua.category[localeCode] ?? '';

    print("Current locale: $localeCode");
    print("Title: ${translation?.title}");
    print("Explanation: ${translation?.explanation}");

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(title: Text(title),
      backgroundColor: AppColors.backgroundColor,),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(category, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 12),

              Text(
                dua.arabic,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  height: 2,
                ),
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
              ),
              const SizedBox(height: 12),

              Text(
                dua.transliteration,
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 12),

              Text(
                AppLocalizations.of(context)!.meaning,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(meaning),
              const SizedBox(height: 12),

              Text(
                AppLocalizations.of(context)!.explanation,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(explanation),
              const SizedBox(height: 12),

              Text(
                AppLocalizations.of(context)!.reference,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),

              Text(reference),
              const SizedBox(height: 24),
              // Text("Nimadur"),
              ElevatedButton(
                onPressed: () {
                  // TODO: implement audio playback
                },
                child: Text(AppLocalizations.of(context)!.playAudio),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
