import 'package:rotary/core/network/network_utils.dart';
import 'package:rotary/data/models/home/home_model.dart';

import '../../../core/resources/app_url.dart';

abstract class HomePageRemoteDataSource {
  Future<HomeModel> getHomePageData(String token);
}

class HomePageRemoteDataSourceImpl implements HomePageRemoteDataSource {
  final NetworkUtil networkUtil;

  HomePageRemoteDataSourceImpl({required this.networkUtil});
  @override
  Future<HomeModel> getHomePageData(String token) async {
    try {
      final response =
          await networkUtil.get(AppUrl.BASE_URL + AppUrl.HOME, token: token);
      final homeModel = HomeModel.fromJson(networkUtil.parseNormalResponse(response));
      return homeModel;
    } catch (e) {
      throw e;
    }
  }
}
