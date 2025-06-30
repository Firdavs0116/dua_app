
part of "dua_cubit.dart";
abstract class DuaState extends Equatable {
  const DuaState();

  @override
  List<Object?> get props => [];
}

class DuaInitial extends DuaState {
  const DuaInitial();
}

class DuaLoading extends DuaState {
  const DuaLoading();
}

class DuaLoaded extends DuaState {
  final List<DuaEntity> duas;
  const DuaLoaded(this.duas);

  @override
  List<Object?> get props => [duas];
}

class DuaError extends DuaState {
  final String message;
  const DuaError(this.message);

  @override
  List<Object?> get props => [message];
}
