import 'package:rotary/core/error/exceptions.dart';
import 'package:rotary/core/network/network_utils.dart';
import 'package:rotary/core/resources/app_url.dart';
import 'package:rotary/data/models/district_committee/district_committee_model.dart';

import '../../models/district_committee/district_committee_response_model.dart';

abstract class DistrictCommitteeRemoteDataSource {
  Future<DistrictComitteeResponseModel> getDistrictCommittee();
}

class DistrictCommitteeRemoteDataSourceImpl
    implements DistrictCommitteeRemoteDataSource {
  final NetworkUtil networkUtil;

  DistrictCommitteeRemoteDataSourceImpl({required this.networkUtil});

  @override
  Future<DistrictComitteeResponseModel> getDistrictCommittee() async {
    try {
      final response =
          await networkUtil.get(AppUrl.BASE_URL + AppUrl.DISTRICT_COMMITTEE);
      print(response.data);

      DistrictComitteeResponseModel districtComitteeResponseModel =
          DistrictComitteeResponseModel.fromJson(
              networkUtil.parseNormalResponse(response));
      DistrictCommitteeModel disctrictComitteModel = DistrictCommitteeModel(
          councilName: districtComitteeResponseModel.main!.councilName,
          name: districtComitteeResponseModel.main!.name,
          image: districtComitteeResponseModel.main!.image,
          position: districtComitteeResponseModel.main!.position,
          members: districtComitteeResponseModel.main!.members,
          isMain: true);
      districtComitteeResponseModel.main = disctrictComitteModel;
      return districtComitteeResponseModel;
    } catch (e) {
      print(e.toString());
      throw throwException(e);
    }
  }
}
