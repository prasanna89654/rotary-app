import 'package:dio/dio.dart';
import 'package:rotary/core/error/exceptions.dart';
import 'package:rotary/core/network/network_utils.dart';
import 'package:rotary/core/resources/app_url.dart';
import 'package:rotary/data/models/news/news_details_model.dart';
import 'package:rotary/data/models/news/news_response_model.dart';

abstract class NewsRemoteDataSource {
  Future<NewsResponseModel> getNews();
  Future<NewsDetailsModel> getNewsDetails(String id);
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final NetworkUtil networkUtil;

  NewsRemoteDataSourceImpl(this.networkUtil);
  @override
  Future<NewsResponseModel> getNews() async {
    try {
      final response = await networkUtil.get(AppUrl.BASE_URL + AppUrl.NEWS);
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        print("Here is the response: ${response.data}");
        return NewsResponseModel.fromJson(response.data);
      } else {
        throw ServerException(exceptionMessage: response.statusMessage!);
      }
    } catch (e) {
      print(e.toString());

      throw throwException(e);
    }
  }

  @override
  Future<NewsDetailsModel> getNewsDetails(String id) async {
    try {
      print("News id" + id.toString());
      Response response = await networkUtil.get(
        AppUrl.BASE_URL + AppUrl.NEWS_DETAILS + id.toString(),
      );
      NewsDetailsModel newsDetailsModel =
          NewsDetailsModel.fromJson(networkUtil.parseNormalResponse(response));

      return newsDetailsModel;
    } catch (e) {
      print(e.toString());
      throw throwException(e);
    }
  }
}
