import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_dua_app/core/constants/app_colors.dart';
import 'package:my_dua_app/features/dua/ui/cubit/dua_cubit.dart';
import 'package:my_dua_app/features/dua/ui/pages/dua_details.dart';
import 'package:my_dua_app/injection/service_locator.dart';

class DuaListPage extends StatelessWidget {
  const DuaListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;

    return BlocProvider(
      create: (_) => sl<DuaCubit>()..fetchDuas(),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          title: const Text("Duas", style: TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: AppColors.backgroundColor,
          actions: [
            Icon(Icons.language),
            const SizedBox(width: 8),
            Icon(Icons.brightness_6),
            const SizedBox(width: 16),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Collection of supplications from the Quran and Sunnah.",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ),
              const SizedBox(height: 12),

              // Search bar
              TextField(
                
                decoration: InputDecoration(
                  
                  hintText: 'Search for a dua...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: Colors.white
                ),
              ),
              const SizedBox(height: 12),

              // Category chips
              SizedBox(
                
                height: 40,
                child: ListView(
                
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildCategoryChip("All"),
                    _buildCategoryChip("Morning"),
                    _buildCategoryChip("Evening"),
                    _buildCategoryChip("Protection"),
                    _buildCategoryChip("Forgiveness"),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Dua list
              Expanded(
              
                child: BlocBuilder<DuaCubit, DuaState>(
                
                  builder: (context, state) {
                    if (state is DuaLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is DuaLoaded) {
                      return ListView.builder(
                        itemCount: state.duas.length,
                        itemBuilder: (context, index) {
                          final dua = state.duas[index];
                          final translation = dua.translations[locale];
                          final category = dua.category[locale] ?? '';

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

                                  // Translation
                                  const SizedBox(height: 10),
                                  Text(
                                    translation?.meaning ?? '',
                                    style: const TextStyle(color: Colors.black87),
                                  ),

                                  // Read more & audio
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      ElevatedButton.icon(
                                        onPressed: () {},
                                        icon: const Icon(Icons.play_arrow),
                                        label: const Text("Play"),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.grey[200],
                                          foregroundColor: Colors.black,
                                          elevation: 0,
                                        ),
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
                                        child: const Text("Read More"),
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

  Widget _buildCategoryChip(String title) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        backgroundColor: Colors.white,
        label: Text(title),
        selected: false,
        onSelected: (bool selected) {},
      ),
    );
  }
}
