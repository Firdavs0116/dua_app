import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_dua_app/core/widgets/app_card.dart';
import 'package:my_dua_app/features/dua/ui/pages/dua_list_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.homeTitle),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.mode_night_rounded)),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_rounded)),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            HomeCard(
              icon: Icons.chrome_reader_mode_outlined,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => DuaListPage()),
                );
              },
              title: "Dua",
              description: 'Duolar',
              goToText: "Duolarga oish",
              color: Colors.black,
            ),
            SizedBox(height: 10),

            HomeCard(
              icon: Icons.chrome_reader_mode_outlined,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => DuaListPage()),
                );
              },
              title: "Zikr",
              description: 'Zikrlar',
              goToText: '',
              color: Colors.black,
            ),
            SizedBox(height: 10),
            HomeCard(
              icon: Icons.chrome_reader_mode_outlined,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => DuaListPage()),
                );
              },
              title: "Tasbeeh",
              description: '',
              goToText: "Tasbeeh ga o'tish",
              color: Colors.black,
            ),
            SizedBox(height: 10),

            HomeCard(
              icon: Icons.chrome_reader_mode_outlined,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => DuaListPage()),
                );
              },
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
