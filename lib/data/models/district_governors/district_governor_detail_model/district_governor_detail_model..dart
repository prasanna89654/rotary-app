import 'package:equatable/equatable.dart';
import 'package:rotary/data/models/district_governors/district_governor_detail_model/dg_message.dart';

import 'history..dart';
import 'info..dart';

class DistrictGovernorDetailModel extends Equatable {
  final DistrictGovernorDetailInfo? info;
  final DgMessage? dgMessage;
  final List<DistrictGovernorDetailHistory>? history;

  const DistrictGovernorDetailModel({
    this.info,
    this.dgMessage,
    this.history,
  });

  factory DistrictGovernorDetailModel.fromJson(Map<String, dynamic> json) {
    return DistrictGovernorDetailModel(
      info: json['info'] == null
          ? null
          : DistrictGovernorDetailInfo.fromJson(
              json['info'] as Map<String, dynamic>),
      dgMessage: json['dg_message'] == null
          ? null
          : DgMessage.fromJson(json['dg_message'] as Map<String, dynamic>),
      history: (json['history'] as List<dynamic>?)
          ?.map((e) =>
              DistrictGovernorDetailHistory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'info': info?.toJson(),
        'dg_message': dgMessage,
        'history': history?.map((e) => e.toJson()).toList(),
      };

  @override
  List<Object?> get props => [info, dgMessage, history];
}
