import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_dua_app/assets/images/images.dart';
import 'package:my_dua_app/core/constants/app_colors.dart';
import 'package:my_dua_app/features/dua/data/datasources/dua_locale_datasource.dart';
import 'package:my_dua_app/features/dua/data/datasources/dua_remote_datasource.dart';
import 'package:my_dua_app/features/dua/data/repositories/dua_repository_impl.dart';
import 'package:my_dua_app/features/dua/domain/entities/dua_entity.dart';
import 'package:my_dua_app/features/dua/ui/pages/dua_list_page.dart';
import 'package:my_dua_app/features/favorites/ui/presentation/pages/favorite_page.dart';
import 'package:my_dua_app/features/profile/ui/pages/profile_page.dart';
import 'package:my_dua_app/features/zikr/presentation/pages/zikr_list_page.dart';
import 'package:my_dua_app/injection/service_locator.dart';

class HomePage extends StatefulWidget {
  final void Function(Locale) onLocaleChange;
  final void Function(dynamic) onThemeToggle;

  const HomePage({
    super.key,
    required this.onLocaleChange,
    required this.onThemeToggle,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String selectedImage;
  int _currentIndex = 0;
  DuaEntity? _randomDua;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();

    // Random image
    final random = Random();
    selectedImage = networkImages[random.nextInt(networkImages.length)];

    // Fetch dua
    _fetchRandomDua();
  }

  Future<void> _fetchRandomDua() async {
    try {
      final repo = DuaRepositoryImpl(
        remoteDataSource: DuaRemoteDataSourceImpl(
          firestore: FirebaseFirestore.instance,
        ),
        localeDatasource: DuaLocaleDatasourceImpl(prefs: sl()),
      );
      final allDuas = await repo.getDuas();

      if (!mounted) return;

      final today = DateTime.now();
      final hash = today.year + today.month + today.day;
      final index = hash % allDuas.length;

      setState(() {
        _randomDua = allDuas[index];
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final langCode = Localizations.localeOf(context).languageCode;

    return Scaffold(
      
      backgroundColor: AppColors.backgroundColor,
      body: IndexedStack(
        index: _currentIndex,
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment:CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 35),
                Text("Home", style: TextStyle(fontSize: 25),),
                const SizedBox(height: 15),
                Text("Daily duas", style: TextStyle(fontSize: 18),),
                const SizedBox(height: 10),
                _buildRandomDuaCard(langCode),
              ],
            ),
          ),

          /// Dua page
          const DuaListPage(),

          /// Zikr page
          const ZikrListPage(),

          /// Tasbeeh (you can replace this with your TasbeehPage)
          const FavoritePage(),

          /// Profile page
          const ProfilePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: AppColors.mainWords,
        selectedFontSize: 12,
        selectedItemColor: Colors.amber,
        unselectedIconTheme: const IconThemeData(color: Colors.blueAccent),
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: "Dua"),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_awesome),
            label: "Zikr",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorites"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  Widget _buildRandomDuaCard(String langCode) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 400,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            image: DecorationImage(
              image: NetworkImage(selectedImage),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              borderRadius: BorderRadius.circular(16),
            ),
            child:
                _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : _error != null
                    ? Text(
                      'Xatolik: $_error',
                      style: const TextStyle(color: Colors.white),
                    )
                    : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _randomDua!.arabic,
                          style: const TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _randomDua!.translations[langCode]?.meaning ?? '',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
          ),
        ),
      ],
    );
  }
}
