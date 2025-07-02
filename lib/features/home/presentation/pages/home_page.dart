import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_dua_app/core/constants/app_colors.dart';
import 'package:my_dua_app/core/widgets/app_card.dart';
import 'package:my_dua_app/features/dua/ui/pages/dua_list_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: Text(AppLocalizations.of(context)!.homeTitle),
        actions: [
          Padding(padding: EdgeInsets.symmetric(horizontal: 16),
          child:IconButton(onPressed: () {}, icon: Icon(Icons.person)) ,)
          
        ],
      ),
      body: SingleChildScrollView(
        
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.backgroundColor
          ),
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
                goToText: "Zikrlarga o'tish",
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
      ),
    );
  }
}
