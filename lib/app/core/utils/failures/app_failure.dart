abstract interface class AppFailure implements Exception {
  final String errorMessage;

  AppFailure({required this.errorMessage});
}

class ClientException extends AppFailure {
  ClientException({required super.errorMessage});
}

class FromMapException extends AppFailure {
  FromMapException({required super.errorMessage});
}

class AuthException extends AppFailure {
  AuthException({required super.errorMessage});
}

class FirestoreException extends AppFailure {
  FirestoreException({required super.errorMessage});
}

class FirebaseStorageException extends AppFailure {
  FirebaseStorageException({required super.errorMessage});
}
