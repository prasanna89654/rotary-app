import 'package:dartz/dartz.dart';
import 'package:rotary/core/error/failure.dart';
import 'package:rotary/data/models/member/member_pagination_request_model.dart';
import 'package:rotary/data/models/member/member_response_model.dart';
import 'package:rotary/data/models/member/search_member_request_model.dart';

abstract class MembersRepository {
  Future<Either<Failure, MemberResponseModel>> getAllMembers(
      MemberPaginationRequestModel params);
  Future<Either<Failure, MemberResponseModel>> searchMember(
      SearchMemberRequestModel params);
}
