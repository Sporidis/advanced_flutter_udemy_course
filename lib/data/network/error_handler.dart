import 'package:advanced_course_udemy/data/network/failure.dart';
import 'package:dio/dio.dart';

enum DataSource {
  success,
  noContent,
  badRequest,
  forbidden,
  unauthorized,
  notFound,
  internalServerError,
  connectTimeout,
  cancel,
  receiveTimeout,
  sendTimeout,
  cacheError,
  noInternetConnection,
  defaultError,
}

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      failure = _handleError(error);
    } else {
      failure = DataSource.defaultError.getFailure();
    }
  }
  Failure _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return DataSource.connectTimeout.getFailure();
      case DioExceptionType.sendTimeout:
        return DataSource.sendTimeout.getFailure();
      case DioExceptionType.receiveTimeout:
        return DataSource.receiveTimeout.getFailure();
      case DioExceptionType.badCertificate:
        return DataSource.badRequest.getFailure();
      case DioExceptionType.badResponse:
        switch (error.response?.statusCode) {
          case 400:
            return DataSource.badRequest.getFailure();
          case 401:
            return DataSource.unauthorized.getFailure();
          case 403:
            return DataSource.forbidden.getFailure();
          case 404:
            return DataSource.notFound.getFailure();
          case 500:
            return DataSource.internalServerError.getFailure();
          default:
            return DataSource.defaultError.getFailure();
        }
      case DioExceptionType.cancel:
        return DataSource.cancel.getFailure();
      case DioExceptionType.connectionError:
        return DataSource.noInternetConnection.getFailure();
      case DioExceptionType.unknown:
        return DataSource.defaultError.getFailure();
    }
  }
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.success:
        return Failure(ResponseCode.success, ResponseMessage.success);
      case DataSource.noContent:
        return Failure(ResponseCode.noContent, ResponseMessage.noContent);
      case DataSource.badRequest:
        return Failure(ResponseCode.badRequest, ResponseMessage.badRequest);
      case DataSource.forbidden:
        return Failure(ResponseCode.forbidden, ResponseMessage.forbidden);
      case DataSource.unauthorized:
        return Failure(ResponseCode.unauthorized, ResponseMessage.unauthorized);
      case DataSource.notFound:
        return Failure(ResponseCode.notFound, ResponseMessage.notFound);
      case DataSource.internalServerError:
        return Failure(ResponseCode.internalServerError,
            ResponseMessage.internalServerError);
      case DataSource.connectTimeout:
        return Failure(
            ResponseCode.connectTimeout, ResponseMessage.connectTimeout);
      case DataSource.cancel:
        return Failure(ResponseCode.cancel, ResponseMessage.cancel);
      case DataSource.receiveTimeout:
        return Failure(
            ResponseCode.receiveTimeout, ResponseMessage.receiveTimeout);
      case DataSource.sendTimeout:
        return Failure(ResponseCode.sendTimeout, ResponseMessage.sendTimeout);
      case DataSource.cacheError:
        return Failure(ResponseCode.cacheError, ResponseMessage.cacheError);
      case DataSource.noInternetConnection:
        return Failure(ResponseCode.noInternetConnection,
            ResponseMessage.noInternetConnection);
      case DataSource.defaultError:
        return Failure(ResponseCode.defaultError, ResponseMessage.defaultError);
    }
  }
}

class ResponseCode {
  // API status codes
  static const int success = 200; // success with data
  static const int noContent = 201; // success without data
  static const int badRequest = 400; // failure, api rejected the request
  static const int forbidden = 403; // failure, api rejected the request
  static const int unauthorized = 401; // failure, user is not authorized
  static const int notFound = 404; // failure, api url not found
  static const int internalServerError = 500; // failure, server error

  // Local status code
  static const int defaultError = -1;
  static const int connectTimeout = -2;
  static const int cancel = -3;
  static const int receiveTimeout = -4;
  static const int sendTimeout = -5;
  static const int cacheError = -6;
  static const int noInternetConnection = -7;
}

class ResponseMessage {
  // API status codes
  static const String success = "success"; // success with data
  static const String noContent =
      "success without data"; // success without data
  static const String badRequest =
      "Bad request, try again later"; // failure, api rejected the request
  static const String forbidden =
      "forbidden, try again later"; // failure, api rejected the request
  static const String unauthorized =
      "user is not authorized, try again later"; // failure, user is not authorized
  static const String notFound =
      "Url not found, try again later"; // failure, api url not found
  static const String internalServerError =
      "something went wrong, try again later"; // failure, server error

  // Local status code
  static const String defaultError = "some thing went wrong, try again later";
  static const String connectTimeout = "connect timeout, try again later";
  static const String cancel = "request has been canceled";
  static const String receiveTimeout = "receive timeout, try again later";
  static const String sendTimeout = "send timeout, try again later";
  static const String cacheError = "cache error, try again later";
  static const String noInternetConnection = "no internet connection";
}
