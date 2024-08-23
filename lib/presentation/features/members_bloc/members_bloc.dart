import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:rotary/core/error/failure.dart';
import 'package:rotary/data/models/member/member_pagination_request_model.dart';
import 'package:rotary/data/models/member/member_response_model.dart';
import 'package:rotary/data/models/member/search_member_request_model.dart';
import 'package:rotary/domain/usecases/members_usecase/get_all_members_usecase.dart';
import 'package:rotary/domain/usecases/members_usecase/search_members_usecase.dart';
import 'package:rotary/presentation/features/auth_bloc/auth_bloc.dart';

part 'members_event.dart';
part 'members_state.dart';

class MembersBloc extends Bloc<MembersEvent, MembersState> {
  GetAllMembersUseCase getAllMembersUseCase;
  SearchMemberUsecase searchMemberUsecase;
  AuthBloc authenticationBloc;

  MembersBloc(this.getAllMembersUseCase, this.searchMemberUsecase,
      this.authenticationBloc)
      : super(MembersInitial()) {
    authenticationBloc.stream.listen((state) {
      print('authenticationBloc.stream.listen');
      if (state is AuthInitial) {
        print("Member Bloc isAuth: ${state.isAuthenticated}");
        if (state.isAuthenticated) {
          add(GetAllMembersEvent());
        } else {
          return;
        }
      }
    });

    on<MembersEvent>((event, emit) {});
    on<GetAllMembersEvent>((event, emit) async {
      emit(MembersLoadingState());
      emit(await _mapEventGetAllMembersToState(await getAllMembersUseCase
          .call(MemberPaginationRequestModel(page: 1, isLastPage: false))));
    });
    on<LoadNextPageMembersEvent>((event, emit) async {
      emit(MembersLoadingNextDataState());
      emit(await _mapEventLoadNextPageMembersToState(
          await getAllMembersUseCase.call(event.memberPaginationRequestModel)));
    });
    on<SearchMembersEvent>((event, emit) async {
      emit(MembersLoadingState());
      emit(await _mapEventSearchMembersToState(
          await searchMemberUsecase.call(event.searchMemberRequestModel)));
    });
  }
  late MemberResponseModel memberResponseModel;
  Future<MembersState> _mapEventGetAllMembersToState(
      Either<Failure, MemberResponseModel> either) async {
    return either.fold((l) {
      // if(l is UnAuthorizedFailure) {
      //   return
      // }
      return MembersErrorState(l.failureMessage);
    }, (r) {
      memberResponseModel = r;
      return MembersLoadedState(memberResponseModel);
    });
  }

  Future<MembersState> _mapEventLoadNextPageMembersToState(
      Either<Failure, MemberResponseModel> either) async {
    return either.fold((l) => MembersErrorState(l.failureMessage), (r) {
      memberResponseModel.currentPage = r.currentPage;
      memberResponseModel.lastPage = r.lastPage;
      memberResponseModel.members.addAll(r.members);

      return MembersLoadedState(memberResponseModel);
    });
  }

  Future<MembersState> _mapEventSearchMembersToState(
      Either<Failure, MemberResponseModel> either) async {
    return either.fold((l) => MembersErrorState(l.failureMessage), (r) {
      memberResponseModel = r;
      return MembersLoadedState(memberResponseModel);
    });
  }
}
