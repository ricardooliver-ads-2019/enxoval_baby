import 'package:enxoval_baby/app/core/failures/app_failure.dart';
import 'package:enxoval_baby/app/core/handler/exception_handler.dart';
import 'package:enxoval_baby/app/data/datasources/remote/firebase_auth_datasource.dart';
import 'package:enxoval_baby/app/data/repositories/auth_repository_impl.dart';
import 'package:enxoval_baby/app/domain/dtos/user_credential_dto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';

class FireAuthMock extends Mock implements FirebaseAuthDatasource {}

class MockUser extends Mock implements User {
  @override
  String get uid => '123456';

  @override
  String? get email => 'test@example.com';

  @override
  String? get displayName => 'Test User';

  @override
  String? get photoURL => 'Test User';
}

class ExceptionHandlerMock extends Mock implements ExceptionHandler {}

void main() {
  late FirebaseAuthDatasource authDatasource;
  late ExceptionHandler handler;
  late AuthRepositoryImpl authRepository;
  late User mockUser;

  setUpAll(() {
    registerFallbackValue(
        Exception()); // 🔹 Registra um fallback para Exception
    registerFallbackValue(
        StackTrace.empty); // 🔹 Registra um fallback para StackTrace
  });

  setUp(() {
    authDatasource = FireAuthMock();
    mockUser = MockUser();
    handler = ExceptionHandlerMock();
    // 🔹 Mockando authStateChanges ANTES de instanciar AuthRepositoryImpl
    when(() => authDatasource.authStateChanges)
        .thenAnswer((_) => const Stream<User?>.empty());
    authRepository = AuthRepositoryImpl(
      auth: authDatasource,
      handler: handler,
    );
  });
  group('Testes de login', () {
    test(
        'Deve retornar Failure ao receber uma exception como resposta do authDatasource.login',
        () async {
      // Arrange
      final exception = Exception('Erro de login');

      when(() => authDatasource.login(
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenThrow(exception);

      when(() => handler.handle(any(), any()))
          .thenReturn(exception); // Simula tratamento de erro

      // Act
      final result = await authRepository.login(const UserCredentialDto(
        email: 'invalid@example.com',
        password: 'wrongpass',
      ));

      // Assert
      expect(result.isError(), isTrue);
    });

    test(
        'Deve retornar Failure ao tentar fazer login com credenciais inválidas',
        () async {
      //Act
      when(
        () => authDatasource.login(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenThrow(FirebaseAuthException(code: 'invalid-credential'));

      when(
        () => handler.handle(any(), any()),
      ).thenReturn(AuthException(
        exception: FirebaseAuthException,
        stackTrace: null,
        errorMessage: 'Email ou Senha incorretos!',
      ));

      final result = await authRepository
          .login(const UserCredentialDto(email: '', password: ''));
      //Assert

      expect(result.isError(), isTrue);
    });

    test('Deve retornar Success ao tentar fazer login', () async {
      //Act
      when(() => authDatasource.login(
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenAnswer((_) async => Success(mockUser));

      final result = await authRepository
          .login(const UserCredentialDto(email: 'email', password: 'password'));
      //Assert

      expect(result.isSuccess(), isTrue);
    });
  });
}
