import 'package:flutter/material.dart';

abstract interface class AppFailure implements Exception {
  final String errorMessage;
  final dynamic exception;
  final StackTrace? stackTrace;

  AppFailure({this.exception, this.stackTrace, required this.errorMessage});

  @override
  String toString() => 'Failure: $errorMessage\n$exception\n$stackTrace';
}

class ClientException extends AppFailure {
  final int statusCode; // Example status code, can be customized
  ClientException({
    required this.statusCode,
    required super.errorMessage,
    super.exception,
    super.stackTrace,
  });
}

class AppException extends AppFailure {
  AppException(
      {super.exception, super.stackTrace, required super.errorMessage}){
    if (stackTrace != null) {
      debugPrintStack(label: errorMessage, stackTrace: stackTrace);
    }
  }
}


class FromMapException extends AppFailure {
  FromMapException(
      {super.exception, super.stackTrace, required super.errorMessage});
}

class AuthException extends AppFailure {
  AuthException(
      {super.exception, super.stackTrace, required super.errorMessage});
}

class FireStorageException extends AppFailure {
  FireStorageException(
      {super.exception, super.stackTrace, required super.errorMessage});
}

class LocalStorageException extends AppFailure {
  LocalStorageException(
      {super.exception, super.stackTrace, required super.errorMessage});
}
