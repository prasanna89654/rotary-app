import 'package:dio/dio.dart';
import 'package:rotary/core/error/exceptions.dart';
import 'package:rotary/core/network/network_utils.dart';
import 'package:rotary/core/resources/app_url.dart';
import 'package:rotary/data/models/member/member_pagination_request_model.dart';
import 'package:rotary/data/models/member/member_response_model.dart';
import 'package:rotary/data/models/member/search_member_request_model.dart';

abstract class MembersRemoteDataSource {
  Future<MemberResponseModel> getAllMembers(
      String token, MemberPaginationRequestModel params);
  Future<MemberResponseModel> searchMember(
      String token, SearchMemberRequestModel params);
}

class MembersRemoteDataSourceImpl implements MembersRemoteDataSource {
  final NetworkUtil networkUtil;

  MembersRemoteDataSourceImpl({required this.networkUtil});
  @override
  Future<MemberResponseModel> getAllMembers(
      String token, MemberPaginationRequestModel params) async {
    try {
      final response = await networkUtil.get(AppUrl.BASE_URL + AppUrl.MEMBERS,
          token: token, query: {"page": params.page.toString()});
      MemberResponseModel memberResponseModel = MemberResponseModel.fromJson(
          networkUtil.parseNormalResponse(response));
      return memberResponseModel;
    } on TypeError catch (e) {
      throw DataTypeException(exceptionMessage: e.toString());
    } catch (e) {
      if (e is DioError) {
        if (e.response!.statusCode == 401) {
          throw UnAuthorizedException(
              exceptionMessage: e.response!.statusMessage!);
        }
        throw BadRequestException(message: e.message);
      }
      print(e.toString());
      throw e;
    }
  }

  @override
  Future<MemberResponseModel> searchMember(
      String token, SearchMemberRequestModel params) async {
    try {
      final response = await networkUtil.get(
          AppUrl.BASE_URL + AppUrl.MEMBER_SEARCH,
          token: token,
          query: {params.isSearch ? "search" : "order": params.search});
      // if(response.statusCode == 200) {
      Map<String, dynamic> res = response.data['data'] as Map<String, dynamic>;
      if (res.containsKey('members')) {
        print(response.realUri);
        return MemberResponseModel.fromJson(res);
      } else {
        throw SearchException(exceptionMessage: "No members found");
      }

      // }
      // MemberResponseModel memberResponseModel = MemberResponseModel.fromJson(
      //     networkUtil.parseNormalResponse(response));
      // // if(memberResponseModel.members.is)
      //     return memberResponseModel;
    } catch (e) {
      print(e.toString());
      throw throwException(e);
    }
  }
}
