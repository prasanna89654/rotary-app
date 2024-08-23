import 'package:equatable/equatable.dart';

/// [Type] = Response
/// [T] = parameters

abstract class UseCases<TResult, TParams> {
  Future<TResult> call(TParams params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
