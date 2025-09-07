import 'package:enxoval_baby/app/core/failures/app_failure.dart';
import 'package:enxoval_baby/app/core/handler/exception_handler.dart';
import 'package:enxoval_baby/app/core/result/result.dart';
import 'package:enxoval_baby/app/core/result/result_extensions.dart';
import 'package:enxoval_baby/app/data/datasources/local/secure_user_storage.dart';
import 'package:enxoval_baby/app/data/datasources/remote/firebase_auth_datasource.dart';
import 'package:enxoval_baby/app/data/datasources/remote/firebase_user_datasource.dart';
import 'package:enxoval_baby/app/data/repositories/auth_repository_impl.dart';
import 'package:enxoval_baby/app/domain/dtos/user_credential_dto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class FireAuthMock extends Mock implements FirebaseAuthDatasource {}
class FireUserMock extends Mock implements FirebaseUserDatasource {}
class ExceptionHandlerMock extends Mock implements ExceptionHandler {}
class SessionMock extends Mock implements SecureUserStorage {}

class MockUser extends Mock implements User {
  @override
  String get uid => '123456';

  @override
  String? get email => 'test@example.com';

  @override
  String? get displayName => 'Test User';

  @override
  String? get photoURL => 'https://photo.url/test.png';
}

void main() {
  late FirebaseAuthDatasource authDatasource;
  late FirebaseUserDatasource userDatasource;
  late ExceptionHandler handler;
  late SecureUserStorage session;
  late AuthRepositoryImpl authRepository;
  late User mockUser;

  setUpAll(() {
    // Fallbacks usados pelo mocktail quando usamos any() em tipos não-primários
    registerFallbackValue(Exception());
    registerFallbackValue(StackTrace.empty);
  });

  setUp(() {
    authDatasource = FireAuthMock();
    userDatasource = FireUserMock();
    handler = ExceptionHandlerMock();
    session = SessionMock();
    mockUser = MockUser();

    // O repositório escuta authStateChanges no construtor — stubbe antes
    when(() => authDatasource.authStateChanges)
        .thenAnswer((_) => const Stream<User?>.empty());

    authRepository = AuthRepositoryImpl(
      auth: authDatasource,
      userDataSource: userDatasource,
      handler: handler,
      session: session, // << OBRIGATÓRIO AGORA
    );
  });

  group('Testes de login', () {
    test(
      'Deve retornar Failure ao receber uma exception do authDatasource.login',
      () async {
        // Arrange
        final exception = Exception('Erro de login');
        when(() => authDatasource.login(
              email: any(named: 'email'),
              password: any(named: 'password'),
            )).thenThrow(exception);

        when(() => handler.handle(any(), any())).thenReturn(exception);

        // Act
        final result = await authRepository.login(const UserCredentialDto(
          email: 'invalid@example.com',
          password: 'wrongpass',
        ));

        // Assert
        expect(result.isError, isTrue);
        // Não deve chamar saveCurrentUser, mas se quiser garantir:
        verifyNever(() => session.saveCurrentUser(
              id: any(named: 'id'),
              email: any(named: 'email'),
              name: any(named: 'name'),
              photoUrl: any(named: 'photoUrl'),
              isPremium: any(named: 'isPremium'),
            ));
      },
    );

    test('Deve retornar Failure ao tentar login com credenciais inválidas',
        () async {
      // Arrange
      when(() => authDatasource.login(
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenThrow(FirebaseAuthException(code: 'invalid-credential'));

      when(() => handler.handle(any(), any())).thenReturn(AuthException(
        exception: FirebaseAuthException,
        stackTrace: null,
        errorMessage: 'Email ou Senha incorretos!',
      ));

      // Act
      final result = await authRepository
          .login(const UserCredentialDto(email: '', password: ''));

      // Assert
      expect(result.isError, isTrue);
      verifyNever(() => session.saveCurrentUser(
            id: any(named: 'id'),
            email: any(named: 'email'),
            name: any(named: 'name'),
            photoUrl: any(named: 'photoUrl'),
            isPremium: any(named: 'isPremium'),
          ));
    });

    test('Deve retornar Success ao tentar fazer login', () async {
      // Arrange
      when(() => authDatasource.login(
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenAnswer((_) async => Result.ok(mockUser));

      // O repo salva a sessão local no sucesso do login
      when(() => session.saveCurrentUser(
            id: any(named: 'id'),
            email: any(named: 'email'),
            name: any(named: 'name'),
            photoUrl: any(named: 'photoUrl'),
            isPremium: any(named: 'isPremium'),
          )).thenAnswer((_) async {});

      // Act
      final result = await authRepository
          .login(const UserCredentialDto(email: 'email', password: 'password'));

      // Assert
      expect(result.isOk, isTrue);

      // Verifica se salvou a sessão com o UID retornado
      verify(() => session.saveCurrentUser(
            id: '123456',
            email: 'test@example.com',
            name: 'Test User',
            photoUrl: 'https://photo.url/test.png',
            isPremium: any(named: 'isPremium'),
          )).called(1);
    });
  });

  group('Testes de register (exemplo)', () {
    test('Register: cria user no Firestore e salva sessão local', () async {
      // Arrange
      when(() => authDatasource.register(
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenAnswer((_) async => Result.ok(mockUser));

      // userDatasource.createUser retorna unit
      when(() => userDatasource.createUser(any()))
          .thenAnswer((_) async =>  Result.ok(null));

      // Salva sessão local
      when(() => session.saveCurrentUser(
            id: any(named: 'id'),
            email: any(named: 'email'),
            name: any(named: 'name'),
            photoUrl: any(named: 'photoUrl'),
            isPremium: any(named: 'isPremium'),
          )).thenAnswer((_) async {});

      // Act
      final result = await authRepository.register(const UserCredentialDto(
        email: 'e@e.com',
        password: '123456',
      ));

      // Assert
      expect(result.isOk, isTrue);
      verify(() => userDatasource.createUser(any())).called(1);
      verify(() => session.saveCurrentUser(
            id: '123456',
            email: 'test@example.com',
            name: 'Test User',
            photoUrl: 'https://photo.url/test.png',
            isPremium: any(named: 'isPremium'),
          )).called(1);
    });
  });
}
