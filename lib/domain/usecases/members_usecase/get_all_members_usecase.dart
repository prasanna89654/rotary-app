import 'package:dartz/dartz.dart';
import 'package:rotary/core/error/failure.dart';
import 'package:rotary/core/use_cases.dart/use_cases.dart';
import 'package:rotary/data/models/member/member_pagination_request_model.dart';
import 'package:rotary/data/models/member/member_response_model.dart';
import 'package:rotary/domain/repository/members_repository/members_repository.dart';

abstract class GetAllMembersUseCase
    implements
        UseCases<Either<Failure, MemberResponseModel>,
            MemberPaginationRequestModel> {}

class GetAllMembersUseCaseImpl implements GetAllMembersUseCase {
  MembersRepository membersRepository;
  GetAllMembersUseCaseImpl({required this.membersRepository});
  @override
  Future<Either<Failure, MemberResponseModel>> call(
      MemberPaginationRequestModel params) {
    return membersRepository.getAllMembers(params);
  }
}
