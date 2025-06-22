import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_dua_app/features/language/presentation/widgets/language_selector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_dua_app/features/language/presentation/cubit/locale_cubit.dart';
import 'package:my_dua_app/features/auth/presentation/pages/login_page.dart';

class LanguageSelectorPage extends StatelessWidget {
  final void Function(Locale) onLocaleChange;

  const LanguageSelectorPage({
    super.key,
    required this.onLocaleChange,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LocaleCubit, Locale>(
        listener: (context, state) {
          // Til o'zgarganda LoginPage ga o'tish
          onLocaleChange(state);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => LoginPage(
                onLocaleChange: onLocaleChange,
                onThemeToggle: (_) {}, // kerak bo'lsa toggle yuboring
              ),
            ),
          );
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)!.selectLanguage,
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 20),
                const LanguageSelector(), // Dropdown
              ],
            ),
          ),
        ),
      ),
    );
  }
}
