import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_dua_app/features/dua/ui/cubit/dua_cubit.dart';
import 'package:my_dua_app/features/dua/ui/pages/dua_details.dart';
import 'package:my_dua_app/injection/service_locator.dart';

class DuaListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;

    return BlocProvider(
      create: (_) => sl<DuaCubit>()..fetchDuas(),
      child: Scaffold(
        appBar: AppBar(title: Text("Duo ro'yxati")),
        body: BlocBuilder<DuaCubit, DuaState>(
          builder: (context, state) {
            if (state is DuaLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is DuaLoaded) {
              return ListView.separated(
                itemCount: state.duas.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final dua = state.duas[index];
                  final translation = dua.translations[locale];
                  final category = dua.category[locale] ?? '';

                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 3,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(12),
                      title: Text(
                        translation?.title ?? '',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 6),
                          Text(
                            dua.arabic,
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            dua.transliteration,
                            style: const TextStyle(fontStyle: FontStyle.italic),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            translation?.meaning ?? 'null',
                            style: TextStyle(color: Colors.black87),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            translation?.explanation ?? 'explanation null',
                            style: TextStyle(color: Colors.grey[700], fontSize: 13),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            category,
                            style: const TextStyle(
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                              color: Colors.blueGrey,
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DuaDetailsPage(dua: dua),
                          ),
                        );
                      },
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
    );
  }
}
