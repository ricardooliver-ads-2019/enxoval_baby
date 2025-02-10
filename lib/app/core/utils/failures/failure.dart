abstract interface class Failure implements Exception {
  final String errorMessage;

  Failure({required this.errorMessage});
}

class ClientException extends Failure {
  ClientException({required super.errorMessage});
}

class AuthException extends Failure {
  AuthException({required super.errorMessage});
}

class FirestoreException extends Failure {
  FirestoreException({required super.errorMessage});
}

class FirebaseStorageException extends Failure {
  FirebaseStorageException({required super.errorMessage});
}
