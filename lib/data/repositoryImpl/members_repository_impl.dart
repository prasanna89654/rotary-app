import 'package:rotary/core/network/network_info.dart';
import 'package:rotary/data/data_sources/members/members_remote_data_sources.dart';
import 'package:rotary/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:rotary/data/data_sources/user/user_local_data_sources.dart';
import 'package:rotary/data/models/member/member_pagination_request_model.dart';
import 'package:rotary/data/models/member/member_response_model.dart';
import 'package:rotary/data/models/member/search_member_request_model.dart';
import 'package:rotary/domain/repository/members_repository/members_repository.dart';

class MembersRepositoryImpl implements MembersRepository {
  final NetworkInfo networkInfo;
  final MembersRemoteDataSource membersRemoteDataSource;
  final UserLocalDataSources userLocalDataSources;

  MembersRepositoryImpl({
    required this.networkInfo,
    required this.membersRemoteDataSource,
    required this.userLocalDataSources,
  });
  @override
  Future<Either<Failure, MemberResponseModel>> getAllMembers(
      MemberPaginationRequestModel memberPaginationRequestModel) async {
    // if (await networkInfo.isConnected) {
    try {
      final token = await userLocalDataSources.getUserToken();
      final result = await membersRemoteDataSource.getAllMembers(
          token, memberPaginationRequestModel);
      return Right(result);
    } catch (e) {
      print("Members" + e.toString());
      return Left(parseFailure(e));
    }
    // } else {
    //   return Left(NetworkFailure());
    // }
  }

  @override
  Future<Either<Failure, MemberResponseModel>> searchMember(
      SearchMemberRequestModel params) async {
    if (await networkInfo.isConnected) {
      try {
        final token = await userLocalDataSources.getUserToken();
        final result =
            await membersRemoteDataSource.searchMember(token, params);
        return Right(result);
      } catch (e) {
        return Left(parseFailure(e));
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
