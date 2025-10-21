import 'package:enxoval_baby/app/core/failures/app_failure.dart';
import 'package:enxoval_baby/app/core/handler/exception_handler.dart';
import 'package:enxoval_baby/app/core/result/result.dart';
import 'package:enxoval_baby/app/core/result/result_extensions.dart';
import 'package:enxoval_baby/app/data/datasources/local/secure_user_storage.dart';
import 'package:enxoval_baby/app/data/datasources/remote/firebase_auth_datasource.dart';
import 'package:enxoval_baby/app/data/datasources/remote/firebase_user_datasource.dart';
import 'package:enxoval_baby/app/data/models/user_model.dart';
import 'package:enxoval_baby/app/data/models/user_settings_model.dart';
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
    // Fallbacks para tipos não-primários usados com any()
    registerFallbackValue(Exception());
    registerFallbackValue(StackTrace.empty);
    registerFallbackValue(
      UserModel(
        id: '123456',
        email: 'test@example.com',
        name: 'Test User',
        profilePhoto: 'https://photo.url/test.png',
        settings: const UserSettingsModel(
          notificationsEnabled: true,
          isPremium: false,
          theme: 'neutro',
        ),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );
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
      session: session,
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

        // O login NÃO passa isPremium/isNotificationsEnabled
        verifyNever(() => session.saveCurrentUser(
              id: any(named: 'id'),
              email: any(named: 'email'),
              name: any(named: 'name'),
              photoUrl: any(named: 'photoUrl'),
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
          ));
    });

    test('Deve retornar Success ao tentar fazer login', () async {
      // Arrange
      when(() => authDatasource.login(
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenAnswer((_) async => Result.ok(mockUser));

      // O repo salva a sessão local no sucesso do login (sem isPremium/notifications)
      when(() => session.saveCurrentUser(
            id: any(named: 'id'),
            email: any(named: 'email'),
            name: any(named: 'name'),
            photoUrl: any(named: 'photoUrl'),
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
          )).called(1);
    });
  });

  group('Testes de register', () {
    test(
        'Sucesso: deve criar usuário no Firebase Auth, no Firestore e salvar sessão local',
        () async {
      // Arrange
      when(() => authDatasource.register(
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenAnswer((_) async => Result.ok(mockUser));

      when(() => userDatasource.createUser(any()))
          .thenAnswer((_) async => Result.ok(null));

      when(() => session.saveCurrentUser(
            id: any(named: 'id'),
            email: any(named: 'email'),
            name: any(named: 'name'),
            photoUrl: any(named: 'photoUrl'),
            isPremium: any(named: 'isPremium'),
            isNotificationsEnabled: any(named: 'isNotificationsEnabled'),
          )).thenAnswer((_) async {});

      // Act
      final result = await authRepository.register(const UserCredentialDto(
        email: 'test@example.com',
        password: '123456',
      ));

      // Assert
      expect(result.isOk, isTrue);

      // Ordem: register -> createUser -> saveCurrentUser (com flags)
      verifyInOrder([
        () => authDatasource.register(
              email: any(named: 'email'),
              password: any(named: 'password'),
            ),
        () => userDatasource.createUser(any()),
        () => session.saveCurrentUser(
              id: '123456',
              email: 'test@example.com',
              name: 'Test User',
              photoUrl: 'https://photo.url/test.png',
              isPremium: false,
              isNotificationsEnabled: true,
            ),
      ]);
    });

    test('Falha: deve retornar erro se o registro no Firebase Auth falhar',
        () async {
      // Arrange — **lança** exceção (não Result.error)
      when(() => authDatasource.register(
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenThrow(Exception('Firebase Auth Error'));

      when(() => handler.handle(any(), any()))
          .thenReturn(Exception('Firebase Auth Error'));

      // Act
      final result = await authRepository.register(const UserCredentialDto(
        email: 'invalid@test.com',
        password: '123456',
      ));

      // Assert
      expect(result.isError, isTrue);
      verifyNever(() => userDatasource.createUser(any()));
      verifyNever(() => session.saveCurrentUser(
            id: any(named: 'id'),
            email: any(named: 'email'),
            name: any(named: 'name'),
            photoUrl: any(named: 'photoUrl'),
            isPremium: any(named: 'isPremium'),
            isNotificationsEnabled: any(named: 'isNotificationsEnabled'),
          ));
    });

    test(
        'Falha na criação do perfil no Firestore: registro segue como sucesso (comportamento atual)',
        () async {
      // Arrange
      when(() => authDatasource.register(
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenAnswer((_) async => Result.ok(mockUser));

      // createUser retorna erro, mas o repo não propaga nem verifica esse Result
      when(() => userDatasource.createUser(any()))
          .thenAnswer((_) async => Result.error(Exception('Firestore Error')));

      // (Não será usado, mas deixamos stubado)
      when(() => handler.handle(any(), any()))
          .thenReturn(Exception('Firestore Error'));

      when(() => session.saveCurrentUser(
            id: any(named: 'id'),
            email: any(named: 'email'),
            name: any(named: 'name'),
            photoUrl: any(named: 'photoUrl'),
            isPremium: any(named: 'isPremium'),
            isNotificationsEnabled: any(named: 'isNotificationsEnabled'),
          )).thenAnswer((_) async {});

      // Act
      final result = await authRepository.register(const UserCredentialDto(
        email: 'test@example.com',
        password: '123456',
      ));

      // Assert — sucesso, sessão salva
      expect(result.isOk, isTrue);
      verify(() => userDatasource.createUser(any())).called(1);
      verify(() => session.saveCurrentUser(
            id: '123456',
            email: 'test@example.com',
            name: 'Test User',
            photoUrl: 'https://photo.url/test.png',
            isPremium: false,
            isNotificationsEnabled: true,
          )).called(1);
    });
  });
}
