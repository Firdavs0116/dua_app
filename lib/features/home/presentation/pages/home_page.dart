import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
import 'package:google_fonts/google_fonts.dart';

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
  bool _isFavorite = false; // Favorite tugmasi holatini saqlash

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

      // Log the dua and its translations
      print("Selected Dua: ${_randomDua!.arabic}");
      print("Translations: ${_randomDua!.translations}");

    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  void _addToFavorites() {
    if (_randomDua != null) {
      FirebaseFirestore.instance.collection('favorites').add({
        'arabic': _randomDua!.arabic,
        'meaning': _randomDua!.translations[Localizations.localeOf(context).languageCode]?.meaning ?? '',
        'transliteration': _randomDua!.transliteration,
      }).then((value) {
        setState(() {
          _isFavorite = true; // Favorite qo'shilganda holatni yangilash
        });
        print("Dua added to favorites");
      }).catchError((error) {
        print("Failed to add dua to favorites: $error");
      });
    }
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite; // Favorite holatini o'zgartirish
    });

    if (_isFavorite) {
      _addToFavorites(); // Agar sevimli bo'lsa, qo'shish
    } else {
      // Bu yerda sevimli duasini olib tashlash funksiyasini qo'shishingiz mumkin
      print("Dua removed from favorites");
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 35),
                Text(
                  "Home",
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Daily duas",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.grey[700],
                  ),
                ),
                _buildRandomDuaCard(langCode),
              ],
            ),
          ),
          const DuaListPage(),
          const ZikrListPage(),
           FavoriteDuaPage(),
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
          BottomNavigationBarItem(icon: Icon(Icons.auto_awesome), label: "Zikr"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorites"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  Widget _buildRandomDuaCard(String langCode) {
    final screenHeight = MediaQuery.of(context).size.height;
    final cardHeight = screenHeight * 0.45;

    return Container(
      height: cardHeight,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: NetworkImage(selectedImage),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Colors.black.withOpacity(0.6), Colors.transparent],
          ),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  )
                : _error != null
                    ? Center(
                        child: Text(
                          'Xatolik: $_error',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            _randomDua!.arabic,
                            style: GoogleFonts.amiri(
                              fontSize: 26,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _randomDua!.translations[langCode]?.meaning ?? 'manosi yoq',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Colors.white70,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ],
                      ),
            // Tugmalarni joylashtirish
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: _toggleFavorite,
                  icon: Icon(
                    _isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: _isFavorite ? Colors.red : Colors.white, // Rangi o'zgaradi
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // Audio tugmasi uchun kelajakda funksionallik qo'shish
                    print("Audio button pressed");
                  },
                  icon: const Icon(Icons.audiotrack, color: Colors.white), // Audio ikonkasi
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
