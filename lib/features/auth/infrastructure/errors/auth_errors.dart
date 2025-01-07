import 'package:dio/dio.dart';

abstract class AppException implements Exception {
  final String message;
  final String code;
  final bool needsLogging;

  AppException(this.message, this.code, {this.needsLogging = false});
}

class AuthException extends AppException {
  AuthException(String message, {String code = 'AUTH_ERROR'})
      : super(message, code);
}

class WrongCredentials implements Exception {}

class InvalidToken implements Exception {}

class ConnectionTimeout implements Exception {}

class CustomError implements Exception {
  final String errorMessage;

  final bool loggedRequired; // es una idea ésta variable
  // al chequear el error, uno vé si está en true y se puede
  // guaradr el log del error en algún lugar persistente

  CustomError(this.errorMessage, [this.loggedRequired = false]);
}

class NetworkException implements Exception {
  NetworkException.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        message = "Request to API server was cancelled";
        break;
      case DioExceptionType.connectionTimeout:
        message = "Connection timeout with API server";
        break;
      case DioExceptionType.unknown:
        message = "Connection to API server failed due to internet connection";
        break;
      case DioExceptionType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      case DioExceptionType.badResponse:
        message = _handleError(dioError.response!.statusCode);
        break;
      case DioExceptionType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      case DioExceptionType.connectionError:
        message = "Revise su conexión a internet";
        break;
      default:
        message = "${dioError.message}";
        break;
    }
  }

  String? message;

  String _handleError(statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 401:
        return 'Sesión expirada. Por favor, inicie sesión nuevamente.';
      case 403:
        return 'Créditos insuficientes!';
      case 404:
        return 'Template not found';
      case 500:
        return 'Transaction failed';
      default:
        return 'Oops something went wrong';
    }
  }

  @override
  String toString() => message.toString();
}
