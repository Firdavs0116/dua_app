import 'package:my_dua_app/features/dua/data/datasources/dua_remote_datasource.dart';
import 'package:my_dua_app/features/dua/domain/entities/dua_entity.dart';
import 'package:my_dua_app/features/dua/domain/repository/dua_repository.dart';

class DuaRepositoryImpl implements DuaRepository {
  final DuaRemoteDataSource remoteDataSource;

  DuaRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<DuaEntity>> getDuas() async {
    return await remoteDataSource.getDuas();
  }
}
