import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_dua_app/core/constants/app_colors.dart';
import 'package:my_dua_app/core/widgets/app_card.dart';
import 'package:my_dua_app/core/widgets/tasbeeh_chart_widget.dart';
import 'package:my_dua_app/features/dua/ui/pages/dua_list_page.dart';
import 'package:my_dua_app/features/language/presentation/widgets/language_selector_with_flags.dart';
import 'package:my_dua_app/features/zikr/presentation/pages/zikr_list_page.dart';

class HomePage extends StatelessWidget {
  final void Function(Locale) onLocaleChange;
  final void Function(dynamic) onThemeToggle;

  const HomePage({
    super.key,
    required this.onLocaleChange,
    required this.onThemeToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: Text(AppLocalizations.of(context)!.homeTitle),
        actions: [
          LanguageSelectorWithFlags(onLocaleChanged: onLocaleChange),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            // 📊 Tasbeeh statistikasi charti
            // TasbeehChartWidget(weeklyCounts: [12]),
            // const SizedBox(height: 10),
            HomeCard(
              icon: Icons.chrome_reader_mode_outlined,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => DuaListPage()),
              ),
              title: "Dua",
              description: 'Duolar',
              goToText: "Duolarga o'tish",
              color: Colors.black,
            ),
            const SizedBox(height: 10),
            HomeCard(
              icon: Icons.chrome_reader_mode_outlined,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ZikrListPage()),
              ),
              title: "Zikr",
              description: 'Zikrlar',
              goToText: "Zikrlarga o'tish",
              color: Colors.black,
            ),
            const SizedBox(height: 10),
            HomeCard(
              icon: Icons.chrome_reader_mode_outlined,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => DuaListPage()),
              ),
              title: "Tasbeeh",
              description: '',
              goToText: "Tasbeeh ga o'tish",
              color: Colors.black,
            ),
            const SizedBox(height: 10),
            HomeCard(
              icon: Icons.chrome_reader_mode_outlined,
              onTap: () => {},
              title: "Kelajakda",
              description: '',
              goToText: "Qo'shilishi kutilmoqda",
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
