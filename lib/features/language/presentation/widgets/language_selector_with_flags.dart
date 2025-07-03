import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_dua_app/features/language/presentation/cubit/locale_cubit.dart';

class LanguageSelectorWithFlags extends StatelessWidget {
  final void Function(Locale) onLocaleChanged;

  const LanguageSelectorWithFlags({
    super.key,
    required this.onLocaleChanged,
  });

  static final List<Map<String, dynamic>> supportedLocales = [
    {'code': 'uz', 'name': 'Oʻzbek', 'flag': 'uz.png'},
    {'code': 'en', 'name': 'English', 'flag': 'en.png'},
    {'code': 'ru', 'name': 'Русский', 'flag': 'ru.png'},
    {'code': 'tr', 'name': 'Türkçe', 'flag': 'tr.png'},
    {'code': 'fr', 'name': 'Français', 'flag': 'fr.png'},
    {'code': 'de', 'name': 'Deutsch', 'flag': 'de.png'},
    {'code': 'id', 'name': 'Indonesia', 'flag': 'id.png'},
    {'code': 'ja', 'name': '日本語', 'flag': 'jp.png'},
    {'code': 'ko', 'name': '한국어', 'flag': 'kr.png'},
    {'code': 'kk', 'name': 'Қазақ', 'flag': 'kz.png'},
    {'code': 'ky', 'name': 'Қырғыз', 'flag': 'kg.png'},
  ];

  @override
  Widget build(BuildContext context) {
    final currentCode = context.watch<LocaleCubit>().state.languageCode;
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: screenWidth * 0.3,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          iconSize: 20,
          value: currentCode,
          items: supportedLocales.map((locale) {
            return DropdownMenuItem<String>(
              value: locale["code"],
              child: Row(
                children: [
                  Image.asset(
                    "assets/flags/${locale["flag"]}",
                    width: 15,
                    height: 15,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.flag),
                  ),
                  const SizedBox(width: 5),
                  Flexible(
                    child: Text(
                      locale["name"],
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: (code) {
            if (code != null) {
              final selected =
                  supportedLocales.firstWhere((l) => l["code"] == code);
              final locale = Locale(selected["code"]);
              context.read<LocaleCubit>().changeLocale(code);
              onLocaleChanged(locale);
            }
          },
        ),
      ),
    );
  }
}
