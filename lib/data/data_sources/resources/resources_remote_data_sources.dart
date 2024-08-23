import 'dart:developer';

import 'package:rotary/core/error/exceptions.dart';
import 'package:rotary/core/network/network_utils.dart';
import 'package:rotary/core/resources/app_url.dart';
import 'package:rotary/data/models/resources/resource_description_model.dart';
import 'package:rotary/data/models/resources/resource_details/resources_detail_response_model.dart';
import 'package:rotary/data/models/resources/resources_model.dart';

abstract class ResourcesRemoteDataSource {
  Future<List<ResourcesModel>> getResources();
  Future<ResourcesDetailResponseModel> getResourceDetails(String id);
  Future<ResourceDescriptionModel> getResourceDescription(String id);
}

class ResourcesRemoteDataSourceImpl implements ResourcesRemoteDataSource {
  final NetworkUtil networkUtil;
  ResourcesRemoteDataSourceImpl({required this.networkUtil});
  @override
  Future<List<ResourcesModel>> getResources() async {
    try {
      final response =
          await networkUtil.get(AppUrl.BASE_URL + AppUrl.RESOURCES);
      List<ResourcesModel> resourcesList =
          List<dynamic>.from(networkUtil.parseNormalResponse(response))
              .map((e) => ResourcesModel.fromJson(e))
              .toList();

      return resourcesList;
    } catch (e) {
      print(e.toString());
      throw throwException(e);
    }
  }

  @override
  Future<ResourcesDetailResponseModel> getResourceDetails(String id) async {
    try {
      final response =
          await networkUtil.get(AppUrl.BASE_URL + AppUrl.RESOURCES + "/" + id);
      ResourcesDetailResponseModel resourcesDetailResponseModel =
          ResourcesDetailResponseModel.fromJson(
              networkUtil.parseNormalResponse(response));
      log(response.realUri.toString());
      return resourcesDetailResponseModel;
    } catch (e) {
      print(e.toString());
      throw throwException(e);
    }
  }

  @override
  Future<ResourceDescriptionModel> getResourceDescription(String id) async {
    try {
      final response = await networkUtil
          .get(AppUrl.BASE_URL + AppUrl.RESOURCES_DESCRIPTION + id);
      ResourceDescriptionModel resourceDescriptionModel =
          ResourceDescriptionModel.fromJson(
              networkUtil.parseNormalResponse(response)['info']);
      log(response.realUri.toString());
      return resourceDescriptionModel;
    } catch (e) {
      print(e.toString());
      throw throwException(e);
    }
  }
}
