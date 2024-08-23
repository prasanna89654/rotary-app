import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:rotary/core/error/failure.dart';
import 'package:rotary/core/use_cases.dart/use_cases.dart';
import 'package:rotary/data/models/resources/resource_description_model.dart';
import 'package:rotary/data/models/resources/resource_details/resources_detail_response_model.dart';
import 'package:rotary/data/models/resources/resources_model.dart';
import 'package:rotary/domain/usecases/resources_usecase/get_resource_description_usecase.dart';
import 'package:rotary/domain/usecases/resources_usecase/get_resources_details_usecase.dart';
import 'package:rotary/domain/usecases/resources_usecase/get_resources_usecase.dart';

part 'resources_event.dart';
part 'resources_state.dart';

class ResourcesBloc extends Bloc<ResourcesEvent, ResourcesState> {
  GetResourcesUseCase getResourcesUseCase;
  GetResourcesDetailsUseCase getResourcesDetailsUseCase;
  GetResourceDescriptionUseCase getResourceDescriptionUseCase;
  ResourcesBloc(this.getResourcesUseCase, this.getResourcesDetailsUseCase,
      this.getResourceDescriptionUseCase)
      : super(ResourcesInitial()) {
    on<ResourcesEvent>((event, emit) {});
    on<GetAllResourcesEvent>((event, emit) async {
      emit(ResourcesLoadingState());
      emit(await _mapEventGetAllResourcesToState(
          await getResourcesUseCase.call(NoParams())));
    });
    on<GetResourcesDetailsEvent>((event, emit) async {
      emit(ResourcesLoadingState());
      emit(await _mapEventGetResourceDetailsToState(
          await getResourcesDetailsUseCase.call(event.id)));
    });
    on<GetResourceDescriptionEvent>((event, emit) async {
      emit(ResourcesLoadingState());
      emit(await _mapEventGetResourceDescriptionToState(
          await getResourceDescriptionUseCase.call(event.id)));
    });
  }

  ResourcesDetailResponseModel? _resourcesDetailResponseModel;
  List<ResourcesModel>? _resourcesModel;
  // ResourceDescriptionModel _resourceDescriptionModel;

  Future<ResourcesState> _mapEventGetAllResourcesToState(
      Either<Failure, List<ResourcesModel>> either) async {
    return either.fold((l) => ResourcesErrorState(l.failureMessage), (r) {
      _resourcesModel = r;
      return ResourcesDetailLoadedState(_resourcesModel, null, null);
    });
  }

  Future<ResourcesState> _mapEventGetResourceDetailsToState(
      Either<Failure, ResourcesDetailResponseModel> either) async {
    return either.fold((l) => ResourcesErrorState(l.failureMessage), (r) {
      _resourcesDetailResponseModel = r;
      return ResourcesDetailLoadedState(
          _resourcesModel, _resourcesDetailResponseModel, null);
    });
  }

  Future<ResourcesState> _mapEventGetResourceDescriptionToState(
      Either<Failure, ResourceDescriptionModel> either) async {
    return await either.fold(
      (l) => ResourcesErrorState(l.failureMessage),
      (r) => ResourcesDetailLoadedState(
          _resourcesModel, _resourcesDetailResponseModel, r),
    );
  }
}
