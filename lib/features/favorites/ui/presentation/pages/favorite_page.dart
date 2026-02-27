import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_dua_app/features/dua/data/models/dua_model.dart';
import 'package:my_dua_app/features/dua/ui/cubit/dua_cubit.dart';

class FavoriteDuaPage extends StatelessWidget {
  const FavoriteDuaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sevimli Duolar")),
      body: BlocBuilder<DuaCubit, DuaState>(
        builder: (context, state) {
          if (state is DuaLoaded) {
            final favs = state.duas.where((d) => (d as DuaModel).isFavorite).toList();
            if (favs.isEmpty) {
              return const Center(child: Text("Sevimlilar yo'q"));
            }
            return ListView.builder(
              itemCount: favs.length,
              itemBuilder: (_, i) {
                final dua = favs[i];
                return ListTile(
                  title: Text(dua.translations['uz']?.title ?? ''),
                  trailing: Icon(Icons.star, color: Colors.amber),
                );
              },
            );
          } else if (state is DuaLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const Center(child: Text("Ma'lumot yo'q"));
          }
        },
      ),
    );
  }
}
