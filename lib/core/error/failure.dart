import 'package:rotary/core/error/exceptions.dart';

abstract class Failure {
  String failureMessage;
  Failure(this.failureMessage);
}

class ServerFailure extends Failure {
  ServerFailure({String failureMessage = "Server Failure"})
      : super(failureMessage);
}

class UnAuthorizedFailure extends Failure {
  UnAuthorizedFailure({String failureMessage = "UnAuthorized Failure"})
      : super(failureMessage);
}

class NetworkFailure extends Failure {
  NetworkFailure(
      {String failureMessage =
          "Network Failure. Please check your internet connection."})
      : super(failureMessage);
}

class DataTypeFailure extends Failure {
  DataTypeFailure({String failureMessage = "Data Type Failure."})
      : super(failureMessage);
}

class BadRequestFailure extends Failure {
  String failureMessage;
  BadRequestFailure({this.failureMessage = "Bad Request. Server Failure!!"})
      : super(failureMessage);
}

class UnknownFailure extends Failure {
  UnknownFailure({String failureMessage = "Unknown Failure"})
      : super(failureMessage);
}

class SearchFailure extends Failure {
  String failureMessage;
  SearchFailure({required this.failureMessage}) : super(failureMessage);
}

Failure parseFailure(Object e) {
  if (e is bool) {
    return UnknownFailure();
  }
  if (e is NetworkException) {
    return NetworkFailure();
  }
  if (e is ServerException) {
    return ServerFailure();
  } else if (e is DataTypeException) {
    return DataTypeFailure();
  } else if (e is BadRequestException) {
    return BadRequestFailure();
  } else if (e is UnAuthorizedException) {
    return UnAuthorizedFailure(failureMessage: e.exceptionMessage);
  } else if (e is SearchException) {
    return SearchFailure(failureMessage: e.exceptionMessage);
  } else {
    return UnknownFailure();
  }
}
