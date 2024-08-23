import 'dart:io';

import 'package:dio/dio.dart';

class ServerException implements Exception {
  final String exceptionMessage;

  ServerException({required this.exceptionMessage});
}

class SearchException implements Exception {
  final String exceptionMessage;

  SearchException({required this.exceptionMessage});
}

class NetworkException implements Exception {}

class CacheException implements Exception {}

class UnknownException implements Exception {}

class UnAuthorizedException implements Exception {
  final String exceptionMessage;

  UnAuthorizedException({required this.exceptionMessage});
}

class LocationException implements Exception {}

class DataTypeException implements Exception {
  final String exceptionMessage;

  DataTypeException({required this.exceptionMessage});
}

class BadRequestException implements Exception {
  final String message;

  BadRequestException({required this.message});
}

Exception throwException(Object e) {
  if (e is DioError) {
    if (e.error is SocketException) {
      throw NetworkException();
    }
    if (e.response!.statusCode == 401) {
      throw UnAuthorizedException(
          exceptionMessage: e.response!.data!['message']!);
    } else if (e.response!.statusCode! < 500) {
      throw BadRequestException(
          message: e.response!.data?['message'] ?? '${e.response!.statusCode}');
    } else if (e.response!.statusCode == 500) {
      throw ServerException(exceptionMessage: "Server Failure");
    } else {
      throw UnknownException();
    }
  } else if (e is TypeError) {
    throw DataTypeException(exceptionMessage: e.toString());
  } else if (e is SearchException) {
    throw SearchException(exceptionMessage: e.exceptionMessage);
  } else {
    throw UnknownException();
  }
}
