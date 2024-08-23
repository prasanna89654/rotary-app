import 'package:rotary/core/error/exceptions.dart';
import 'package:rotary/core/network/network_utils.dart';
import 'package:rotary/core/resources/app_url.dart';
import 'package:rotary/data/models/club/club_details_model/club_details_response_model.dart';
import 'package:rotary/data/models/club/club_details_model/club_details_request_model.dart';
import 'package:rotary/data/models/club/club_model.dart';

abstract class ClubRemoteDataSource {
  Future<ClubsModel> getClubs();
  Future<ClubDetailsResponseModel> getClubDetails(
      String token, ClubDetailsRequestModel clubDetailsRequestModel);
}

class ClubRemoteDataSourceImpl implements ClubRemoteDataSource {
  final NetworkUtil networkUtil;

  ClubRemoteDataSourceImpl({required this.networkUtil});
  @override
  Future<ClubsModel> getClubs() async {
    try {
      final response = await networkUtil.get(AppUrl.BASE_URL + AppUrl.CLUBS);

      return ClubsModel.fromJson(networkUtil.parseNormalResponse(response));
    } catch (e) {
      print(e.toString());

      throw throwException(e);
    }
  }

  @override
  Future<ClubDetailsResponseModel> getClubDetails(
      String token, ClubDetailsRequestModel clubDetailsRequestModel) async {
    try {
      final response = await networkUtil.get(
          AppUrl.BASE_URL + AppUrl.CLUB_DETAILS + clubDetailsRequestModel.id,
          token: token);
      print(response.realUri.toString());
      print(response.data);
      ClubDetailsResponseModel clubDetailsResponse =
          ClubDetailsResponseModel.fromJson(
              networkUtil.parseNormalResponse(response));

      return clubDetailsResponse;
    } catch (e) {
      print(e.toString());
      throw throwException(e);
    }
  }
}
