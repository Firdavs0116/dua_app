import 'package:my_dua_app/features/dua/data/datasources/dua_locale_datasource.dart';
import 'package:my_dua_app/features/dua/data/datasources/dua_remote_datasource.dart';
import 'package:my_dua_app/features/dua/domain/entities/dua_entity.dart';
import 'package:my_dua_app/features/dua/domain/repository/dua_repository.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class DuaRepositoryImpl implements DuaRepository {
  final DuaRemoteDataSource remoteDataSource;
  final DuaLocaleDatasource localeDatasource;

  DuaRepositoryImpl({
    required this.remoteDataSource,
    required this.localeDatasource});

  @override
  Future<List<DuaEntity>> getDuas() async {
    final connectivity = await Connectivity().checkConnectivity();
    if(connectivity != ConnectivityResult.none){
      final remoteDuas = await remoteDataSource.getDuas();
      await localeDatasource.cacheDuas(remoteDuas);
      return remoteDuas;
    }
    else{
      return await localeDatasource.getCachedDuas();
    }
  
  }

  Future<DuaEntity> getRandomDua() async {
    final list = await remoteDataSource.getDuas();
    list.shuffle();
    return list.first;
  }

}
