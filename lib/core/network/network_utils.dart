import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rotary/core/error/exceptions.dart';
import 'package:rotary/core/network/baseModel/rest_response.dart';
import 'package:rotary/core/resources/app_url.dart';

class NetworkUtil {
  late Dio _dio;

  NetworkUtil({required Dio dio}) {
    _dio = dio;

    ///Create Dio Object using baseOptions set receiveTimeout, connectTimeout,
    BaseOptions options =
        BaseOptions(receiveTimeout: 20000, connectTimeout: 20000);
    options.baseUrl = AppUrl.BASE_URL;
    _dio.options = options;
    DioCacheManager _dioCacheManager =
        DioCacheManager(CacheConfig(baseUrl: AppUrl.BASE_URL));
    dio.interceptors.add(_dioCacheManager.interceptor);
  }

  ///used to get the response from the server
  Future<Response> get(String url,
      {Map<String, String>? query, String? token}) async {
    Response response = await _dio.get(
      url,
      queryParameters: query,
      options: buildCacheOptions(
        Duration(days: 7),
        // maxStale: Duration(days: 7),
        forceRefresh: true,
        options: Options(
          headers: {
            'authorization': 'Bearer $token',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          responseType: ResponseType.json,
        ),
      ),
    );
    if (null != response.headers.value(DIO_CACHE_HEADER_KEY_DATA_SOURCE)) {
      Fluttertoast.showToast(msg: "No internet Connection");
      print("from cache");
      // data come from cache
    } else {
      print("from net");
      // data come from net
    }
    return response;
  }

  ///used for calling [POST] request
  Future<Response> postQueryParams(
    String url, {
    Map<String, dynamic>? params,
    dynamic data,
    FormData? formData,
    String? token,
  }) async {
    print("______________________PPRE RESPONSE_______________________\n");
    print("______________________PPRE RESPONSE_______________________\n");
    Response response = await _dio.post(
      url,
      queryParameters: params,
      data: data != null ? data : formData,
      options: Options(headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'authorization': 'Bearer $token'
      }, responseType: ResponseType.json),
    );

    print(
        "_____________________________POST RESPONSE_____________________________\n");

    return response;
  }

  dynamic parseNormalResponse(Response response) {
    if (response.statusCode! >= 200 && response.statusCode! <= 299) {
      // if (RestResponse.fromJson(response.data).status! >= 200 &&
      //     RestResponse.fromJson(response.data).status! <= 299) {
      //   return RestResponse.fromJson(response.data).responseData;
      // } else {
      //   throw ServerException(
      //       exceptionMessage: RestResponse.fromJson(response.data).message!);
      // }
      print("Real Uri" + response.realUri.toString());
      return RestResponse.fromJson(response.data).responseData;
    } else {
      throw ServerException(exceptionMessage: response.statusMessage!);
    }
  }

  dynamic parseNormalResponse2(Response response) {
    if (response.statusCode! >= 200 && response.statusCode! <= 299) {
      return response.data;
    } else {
      throw ServerException(exceptionMessage: response.statusMessage!);
    }
  }

  Future<Response> put(
    String url, {
    Map<String, String>? params,
    Map<String, String>? data,
    dynamic jsonEncodeBody,
  }) async {
    return await _dio.put(url,
        queryParameters: params,
        data: data != null ? data : jsonEncodeBody,
        options: Options(responseType: ResponseType.json));
  }

  Future<Response> patch(String url,
      {Map<String, String>? params, dynamic data, FormData? formData}) async {
    print(
        "_____________________________ Ppatch RESPONSE_____________________________\n");

    Response response = await _dio.patch(url,
        queryParameters: params,
        data: data != null ? data : formData,
        options: Options(responseType: ResponseType.json));
    print(
        "_____________________________Ppatch RESPONSE_____________________________\n");
    return response;
  }

  Future<Response> delete(String url, {Map<String, String>? params}) async {
    Response response = await _dio.delete(url,
        queryParameters: params,
        options: Options(responseType: ResponseType.json));

    return response;
  }
}
