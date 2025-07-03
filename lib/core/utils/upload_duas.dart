import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> uploadDuasFromJson() async {
  final firestore = FirebaseFirestore.instance;

  // JSON faylni o‘qish
  final String jsonString = await rootBundle.loadString('assets/duas.json');
  final List<dynamic> duas = json.decode(jsonString);

  for (final dua in duas) {
    final String id = dua['id'];
    await firestore.collection('duas').doc(id).set(dua);
    print('Uploaded: $id');
  }

  print("Barcha duolar yuklandi!");
}
