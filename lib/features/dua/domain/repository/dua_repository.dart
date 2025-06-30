import 'package:my_dua_app/features/dua/domain/entities/dua_entity.dart';

abstract class DuaRepository {
  Future<List<DuaEntity>> getDuas();
}