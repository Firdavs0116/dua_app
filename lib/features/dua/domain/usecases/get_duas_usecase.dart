import 'package:my_dua_app/features/dua/domain/entities/dua_entity.dart';
import 'package:my_dua_app/features/dua/domain/repository/dua_repository.dart';

class GetDuasUsecase {
  final DuaRepository repository;
   GetDuasUsecase(this.repository);

   Future<List<DuaEntity>> call() async{
    return await repository.getDuas();
   }
}