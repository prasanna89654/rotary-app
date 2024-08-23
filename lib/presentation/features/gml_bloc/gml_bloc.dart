import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:rotary/core/error/failure.dart';
import 'package:rotary/data/models/gml/gml_model.dart';
import 'package:rotary/domain/repository/gml_repository/gml_repository.dart';
import 'package:rotary/domain/usecases/gml_usecase/get_gml_usecase.dart';

import '../../../core/use_cases.dart/use_cases.dart';

part 'gml_event.dart';
part 'gml_state.dart';

class GmlBloc extends Bloc<GmlEvent, GmlState> {
  GmlRepository gmlRepository;
  GetGmlUsecase getGmlUsecase;
  GmlBloc(this.gmlRepository, this.getGmlUsecase) : super(GmlInitial()) {
    on<GmlEvent>((event, emit) async {
      if (event is GetAllGmlEvent) {
        emit(GmlInitial());
        emit(await _loadGml(await getGmlUsecase.call(NoParams())));
      }
    });
  }

  Future<GmlState> _loadGml(Either<Failure, List<GmlModel>> either) async {
    return either.fold((l) => GmlError(l.failureMessage), (r) => GmlLoaded(r));
  }
}
