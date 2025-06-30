import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/dua_model.dart';

abstract class DuaRemoteDataSource {
  Future<List<DuaModel>> getDuas();
}

class DuaRemoteDataSourceImpl implements DuaRemoteDataSource {
  final FirebaseFirestore firestore;

  DuaRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<DuaModel>> getDuas() async {
    final snapshot = await firestore.collection('duas').get();
    return snapshot.docs.map((doc) => DuaModel.fromJson(doc.data(), doc.id)).toList();
  }
}
