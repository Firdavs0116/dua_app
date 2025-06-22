import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_dua_app/features/language/presentation/cubit/locale_cubit.dart';

class LanguageSelector  extends StatelessWidget{
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: Localizations.localeOf(context).languageCode,
      
      items: [
        DropdownMenuItem(
          value: "en",
          child: Text("English")
          ),
          DropdownMenuItem(
          value: "uz",
          child: Text("Uzbek")
          ),
          DropdownMenuItem(
          value: "id",
          child: Text("Indonesian")
          ),
          DropdownMenuItem(
          value: "tr",
          child: Text("Turkce")
          ),
          DropdownMenuItem(
          value: "de",
          child: Text("Deutch")
          ),
          DropdownMenuItem(
          value: "fr",
          child: Text("France")
          ),
          DropdownMenuItem(
          value: "kr",
          child: Text("Korean")
          ),
          DropdownMenuItem(
          value: "jp",
          child: Text("Japanese")
          ),
          DropdownMenuItem(
          value: "ru",
          child: Text("Russian")
          ),
          
      ], 
      onChanged: (value){
        if (value != null){
          context.read<LocaleCubit>().changeLocale(value);
        }
      }
      );
  }
}