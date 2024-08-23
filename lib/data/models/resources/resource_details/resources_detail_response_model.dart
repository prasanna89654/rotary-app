import 'package:rotary/data/models/resources/resource_details/resource_info_model.dart';
import 'package:rotary/data/models/resources/resource_details/resources_details_model.dart';

class ResourcesDetailResponseModel {
  final ResourcesInfoModel? info;
  final List<ResourcesDetailModel>? resources;
  const ResourcesDetailResponseModel({this.info, this.resources});

  factory ResourcesDetailResponseModel.fromJson(Map<String, dynamic> json) =>
      ResourcesDetailResponseModel(
        info: json['info'] == null
            ? null
            : ResourcesInfoModel.fromJson(json['info'] as Map<String, dynamic>),
        resources: json['resource'] == null
            ? null
            : List<ResourcesDetailModel>.from(json['resource']
                .map((x) => ResourcesDetailModel.fromJson(x))).toList(),
      );
}
