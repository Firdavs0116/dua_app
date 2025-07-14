import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_dua_app/core/constants/app_colors.dart';
import 'package:my_dua_app/features/dua/ui/cubit/dua_cubit.dart';
import 'package:my_dua_app/features/dua/ui/pages/dua_details.dart';
import 'package:my_dua_app/injection/service_locator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          title: Text(AppLocalizations.of(context)!.duas),
          backgroundColor: AppColors.backgroundColor,
          actions: const [
            Icon(Icons.language),
            SizedBox(width: 8),
            Icon(Icons.brightness_6),
            SizedBox(width: 16),
          ],
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

              // Search bar (future implementation)
              TextField(
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.searchHint,
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 12),

              // Category chips (optional filtering)
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
                      return ListView.builder(
                        itemCount: state.duas.length,
                        itemBuilder: (context, index) {
                          final dua = state.duas[index];
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

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      ElevatedButton.icon(
                                        onPressed: () {
                                          // TODO: audio player
                                        },
                                        icon: const Icon(Icons.play_arrow),
                                        label: Text(AppLocalizations.of(context)!.playAudio),
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
