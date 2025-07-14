import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

Future<void> uploadZikrsfromJson() async {
  final firestore = FirebaseFirestore.instance;

  final String jsonString = await rootBundle.loadString("assets/zikrs.json");
  final List<dynamic> zikrs = json.decode(jsonString);

  for ( final zikr in zikrs ){
    final String id =  zikr["id"];
    await firestore.collection("zikr").doc(id).set(zikr);
    print("Zikr yuklanyapti");
  }
  print("Zikrlar yuklanib bo'ldi");
}