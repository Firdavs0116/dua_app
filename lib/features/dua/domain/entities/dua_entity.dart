class DuaEntity{
  final String id;
  final String arabic;
  final String transliteration;
  final String audioUrl;
  final Map<String, String> category;
  final Map<String, Translation> translations;

  DuaEntity({
    required this.id,
    required this.arabic,
    required this.audioUrl,
    required this.category,
    required this.translations,
    required this.transliteration
  });
}
class Translation {
  final String title;
  final String meaning;
  final String explanation;
  final String reference;

  Translation({
    required this.title,
    required this.meaning,
    required this.explanation,
    required this.reference,
  });

  // 🔧 Firestore'ga yozish uchun kerakli metod
  Map<String, dynamic> toJson() => {
        'title': title,
        'meaning': meaning,
        'explanation': explanation,
        'reference': reference,
      };
}
