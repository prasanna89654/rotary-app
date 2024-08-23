import 'package:rotary/data/models/district_governors/district_governor_model.dart';

class DistrictGovernorResponseModel {
  final DistrictGovernorModel active;
  final List<DistrictGovernorModel> other;
  DistrictGovernorResponseModel({required this.active, required this.other});

  factory DistrictGovernorResponseModel.fromJson(Map<String, dynamic> json) {
    return DistrictGovernorResponseModel(
      active: DistrictGovernorModel.fromJson(json['active']),
      other: List<DistrictGovernorModel>.from(
          json['other'].map((x) => DistrictGovernorModel.fromJson(x))),
    );
  }
}
