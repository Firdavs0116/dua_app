import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_dua_app/core/constants/app_colors.dart';
import 'package:my_dua_app/features/dua/ui/cubit/dua_cubit.dart';
import 'package:my_dua_app/features/dua/ui/pages/dua_details.dart';
import 'package:my_dua_app/injection/service_locator.dart';
import 'package:my_dua_app/l10n/app_localizations.dart';

class DuaListPage extends StatefulWidget {
  const DuaListPage({super.key});

  @override
  State<DuaListPage> createState() => _DuaListPageState();
}

class _DuaListPageState extends State<DuaListPage> {
  String _searchQuery = '';
  String _selectedCategory = 'All'; // Default category

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;

    return BlocProvider(
      create: (_) => sl<DuaCubit>()..fetchDuas(),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.duas),
          backgroundColor: AppColors.backgroundColor,
          
          
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppLocalizations.of(context)!.duaIntro,
                  style: const TextStyle(fontSize: 16, color: Colors.black54),
                ), 
              ),
              const SizedBox(height: 12),

              // Search bar
              TextField(
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value.toLowerCase();
                  });
                },
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.searchHint,
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 12),

              // Category chips
              SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildCategoryChip(context, "All"),
                    _buildCategoryChip(context, "Morning"),
                    _buildCategoryChip(context, "Evening"),
                    _buildCategoryChip(context, "Protection"),
                    _buildCategoryChip(context, "Forgiveness"),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Dua List
              Expanded(
                child: BlocBuilder<DuaCubit, DuaState>(
                  builder: (context, state) {
                    if (state is DuaLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is DuaLoaded) {
                      // Filter duas based on search query and selected category
                      final filteredDuas = state.duas.where((dua) {
                        final translation = dua.translations[locale] ?? dua.translations['en'];
                        print("Category bo'shmi: ${translation!.title}");
                        final matchesSearch = translation.meaning.toLowerCase().contains(_searchQuery) ?? false;
                        final matchesCategory = _selectedCategory == 'All' || dua.category[locale]!.contains(_selectedCategory) ?? false;
                        return matchesSearch && matchesCategory;
                      }).toList();

                      return ListView.builder(
                        itemCount: filteredDuas.length,
                        itemBuilder: (context, index) {
                          final dua = filteredDuas[index];
                          final translation = dua.translations[locale] ?? dua.translations['en'];
                          final category = dua.category[locale] ?? dua.category['en'] ?? '';
                          
                          return Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            elevation: 3,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Arabic
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      dua.arabic,
                                      textDirection: TextDirection.rtl,
                                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(height: 10),

                                  // Transliteration
                                  Text(
                                    dua.transliteration,
                                    style: const TextStyle(fontStyle: FontStyle.italic),
                                  ),

                                  const SizedBox(height: 10),

                                  // Translation
                                  Text(
                                    translation?.meaning ?? '',
                                    style: const TextStyle(color: Colors.black87),
                                  ),

                                  const SizedBox(height: 10),

                                  // Category
                                  Text(
                                    category,
                                    style: const TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
                                  ),

                                  const SizedBox(height: 10),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          //audio uchun to'ldirish
                                        },
                                        icon: Icon(Icons.play_circle_fill_rounded, size: 40),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => DuaDetailsPage(dua: dua),
                                            ),
                                          );
                                        },
                                        child: Text(AppLocalizations.of(context)!.readMore),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                    if (state is DuaError) {
                      return Center(child: Text(state.message));
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryChip(BuildContext context, String title) {
    final isSelected = _selectedCategory == title;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        backgroundColor: Colors.white,
        label: Text(title),
        selected: isSelected,
        selectedColor: AppColors.mainWords, // Tanlangan rang
        onSelected: (bool selected) {
          setState(() {
            _selectedCategory = selected ? title : 'All'; // Kategoriya tanlanganda
          });
        },
      ),
    );
  }
}
