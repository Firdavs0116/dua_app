import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_dua_app/features/dua/domain/entities/dua_entity.dart';
import 'package:my_dua_app/features/dua/domain/usecases/get_duas_usecase.dart';

part "dua_state.dart";
class DuaCubit extends Cubit<DuaState> {
  final GetDuasUsecase getDuasUsecase;

  DuaCubit({required this.getDuasUsecase}) : super(DuaInitial());

  Future<void> fetchDuas() async {
    if (isClosed) return;
    emit(DuaLoading());
    try {
      final duas = await getDuasUsecase();
      if (!isClosed) emit(DuaLoaded(duas));
    } catch (e) {
      if (!isClosed) emit(DuaError("Failed to load duas"));
    }
  }
}