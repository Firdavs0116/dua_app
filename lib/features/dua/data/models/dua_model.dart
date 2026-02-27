import 'package:my_dua_app/features/dua/domain/entities/dua_entity.dart';

class DuaModel extends DuaEntity {
  DuaModel({
    required super.id,
    required super.arabic,
    required super.audioUrl,
    required super.category,
    required super.translations,
    required super.transliteration,
    super.isFavorite = false,
  });

  factory DuaModel.fromJson(Map<String, dynamic> json, String id) {
    final translationsMap = (json["translations"] as Map<String, dynamic>? ?? {});
    final parsedTranslations = translationsMap.map((lang, value) {
      return MapEntry(
        lang,
        Translation(
          title: value["title"] ?? "",
          meaning: value["meaning"] ?? "",
          explanation: value["explanation"] ?? "",
          reference: value["reference"] ?? "",
        ),
      );
    });

    return DuaModel(
      id: id,
      arabic: json["arabic"] ?? "",
      audioUrl: json["audioUrl"] ?? "",
      transliteration: json["transliteration"] ?? "",
      category: Map<String, String>.from(json["category"] ?? {}),
      translations: parsedTranslations,
      isFavorite: json["isFavorite"] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "arabic": arabic,
      "transliteration": transliteration,
      "audioUrl": audioUrl,
      "category": category,
      "isFavorite": isFavorite,
      "translations": translations.map((lang, value) => MapEntry(lang, value.toJson())),
    };
  }
  DuaModel copywith({bool? isFavorite}){
    return DuaModel(
      id: id, 
      arabic: arabic, 
      audioUrl: audioUrl, 
      category: category, 
      translations: translations, 
      transliteration: transliteration,
      isFavorite: isFavorite ?? this.isFavorite);
  }
}
