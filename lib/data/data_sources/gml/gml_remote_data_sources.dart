import 'package:dio/dio.dart';
import 'package:rotary/core/error/exceptions.dart';
import 'package:rotary/core/network/network_utils.dart';
import 'package:rotary/core/resources/app_url.dart';
import 'package:rotary/data/models/gml/gml_model.dart';

abstract class GmlRemoteDataSource {
  Future<List<GmlModel>> getGml();
}

class GmlRemoteDataSourceImpl implements GmlRemoteDataSource {
  NetworkUtil networkUtil;
  GmlRemoteDataSourceImpl({required this.networkUtil});

  @override
  Future<List<GmlModel>> getGml() async {
    try {
      Response response = await networkUtil.get(AppUrl.BASE_URL + AppUrl.GML);
      List<GmlModel> gmls = List.from(networkUtil.parseNormalResponse(response))
          .map((e) => GmlModel.fromJson(e))
          .toList();
      return gmls;
    } catch (e) {
      throw throwException(e);
    }
  }
}
