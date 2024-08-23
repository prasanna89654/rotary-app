import 'package:dartz/dartz.dart';
import 'package:rotary/core/error/failure.dart';
import 'package:rotary/core/use_cases.dart/use_cases.dart';
import 'package:rotary/data/models/member/search_member_request_model.dart';
import 'package:rotary/domain/repository/members_repository/members_repository.dart';

import '../../../data/models/member/member_response_model.dart';

abstract class SearchMemberUsecase
    implements
        UseCases<Either<Failure, MemberResponseModel>,
            SearchMemberRequestModel> {}

class SearchMemberUsecaseImpl implements SearchMemberUsecase {
  MembersRepository membersRepository;
  SearchMemberUsecaseImpl({required this.membersRepository});
  @override
  Future<Either<Failure, MemberResponseModel>> call(
      SearchMemberRequestModel params) {
    return membersRepository.searchMember(params);
  }
}
