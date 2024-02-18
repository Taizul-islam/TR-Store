import 'dart:io';

import 'package:dio/dio.dart';

import '../constants/api_const.dart';

class ErrorHandler implements Exception {
  late String errorCodeKey;

  ErrorHandler.handle(dynamic error) {
    switch (error) {
      case Exception:
        try {
          if (error is DioException) {
            errorCodeKey = _handleError(error);
          } else {
            errorCodeKey = unexpectedError;
          }
        } on FormatException catch (_) {
          errorCodeKey = formatException;
        } catch (_) {
          errorCodeKey = unexpectedError;
        }

        break;

      case SocketException:
        errorCodeKey = noInternetConnection;
        break;
      case FormatException:
        errorCodeKey = formatException;
        break;
      default:
        if (error.toString() == "noInternetConnection") {
          errorCodeKey = noInternetConnection;
        } else if (error.toString().contains("is not a subtype of")) {
          errorCodeKey = unableToProcess;
        } else {
          errorCodeKey = unexpectedError;
        }
    }
  }
}

String _handleError(DioException error) {
  switch (error.type) {
    case DioExceptionType.cancel:
      return requestCancelled;

    case DioExceptionType.connectionTimeout:
      return requestTimeout;

    case DioExceptionType.badCertificate:
      return unableToProcess;

    case DioExceptionType.unknown:
      return noInternetConnection;

    case DioExceptionType.receiveTimeout:
      return sendTimeout;

    case DioExceptionType.sendTimeout:
      return sendTimeout;

    case DioExceptionType.connectionError:
      return noInternetConnection;

    case DioExceptionType.badResponse:
      switch (error.response?.statusCode) {
        case 400:
          return unauthorisedRequest;
        case 401:
          return unauthorisedRequest;
        case 403:
          return unauthorisedRequest;
        case 404:
          return notFound;
        case 409:
          return conflict;
        case 408:
          return requestTimeout;
        case 500:
          return internalServerError;
        case 503:
          return serviceUnavailable;
        default:
          return defaultError;
      }
    default:
      return defaultError;
  }
}

getErrorMessageFromCode(String error) {
  switch (error) {
    case noInternetConnection:
      return "You are offline now. Please connect your phone with WiFi or Mobile data";

    case unauthorisedRequest:
      return "You are unauthorized user. We can not give access of the app. Please contact with support team";

    case notFound:
      return "Sorry we have not found any resource";

    default:
      return "Something went wrong. Please try again later";
  }
}
