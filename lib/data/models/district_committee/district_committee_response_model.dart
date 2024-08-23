import 'package:rotary/data/models/district_committee/district_committee_model.dart';

class DistrictComitteeResponseModel {
  DistrictCommitteeModel? main;
  List<DistrictCommitteeModel>? councils;
  DistrictComitteeResponseModel({this.main, this.councils});

  factory DistrictComitteeResponseModel.fromJson(Map<String, dynamic> json) {
    return DistrictComitteeResponseModel(
      main: json['main'] == null
          ? null
          : DistrictCommitteeModel.fromJson(
              json['main'] as Map<String, dynamic>),
      councils: json['councils'] == null
          ? null
          : (json['councils'] as List<dynamic>)
              .map((e) =>
                  DistrictCommitteeModel.fromJson(e as Map<String, dynamic>))
              .toList(),
    );
  }
}
