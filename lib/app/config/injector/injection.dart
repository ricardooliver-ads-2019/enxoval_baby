import 'package:enxoval_baby/app/core/handler/exception_handler.dart';
import 'package:enxoval_baby/app/core/handler/exception_mapper/firebase_auth_exception_handler.dart';
import 'package:enxoval_baby/app/core/handler/exception_mapper/firebase_exception_handler.dart';
import 'package:enxoval_baby/app/core/log/log_app.dart';
import 'package:enxoval_baby/app/data/datasources/local/database/db_provider.dart';
import 'package:enxoval_baby/app/data/datasources/remote/firebase_auth_datasource.dart';
import 'package:enxoval_baby/app/data/datasources/remote/firebase_user_datasource.dart';
import 'package:enxoval_baby/app/data/datasources/remote/generic_layettes_datasource.dart';
import 'package:enxoval_baby/app/data/repositories/auth_repository_impl.dart';
import 'package:enxoval_baby/app/data/repositories/layettes_repository_impl.dart';
import 'package:enxoval_baby/app/domain/repositories/auth_repository.dart';
import 'package:enxoval_baby/app/domain/repositories/layttes_repository.dart';
import 'package:enxoval_baby/app/presentation/auth/forgot_password/view_model/forgot_password_view_model.dart';
import 'package:enxoval_baby/app/presentation/auth/login/view_model/login_view_model.dart';
import 'package:enxoval_baby/app/presentation/auth/logout/view_model/logout_view_model.dart';
import 'package:enxoval_baby/app/presentation/auth/register/view_model/register_view_model.dart';
import 'package:enxoval_baby/app/presentation/onboarding_layette_customization/view_model/onboarding_layette_customization_page_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';

class Injection {
  static GetIt get inject => GetIt.instance;

  void setup() {
    _setupHandles();
    _setupDatasources();
    _setupRepositories();
    _setupUsecases();
    _setupViewModels();
    _setupUtils();
  }

  void _setupDatasources() {// Banco SQLite como singleton assíncrono
  inject.registerSingletonAsync<Database>(() async {
    return await DBProvider.init();
  });
    inject.registerSingleton(FirebaseAuthDatasource());
    inject.registerSingleton(FirebaseUserDatasource());
    inject.registerSingleton(GenericLayettesDatasource());
  }

  void _setupRepositories() {
    inject.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(auth: inject(), userDataSource: inject(), handler: inject()),
    );
    inject.registerLazySingleton<LayettesRepository>(
      () => LayettesRepositoryImpl(dataSource: inject(), handler: inject()),
    );
  }

  void _setupViewModels() {
    inject.registerFactory(
      () => LoginViewModel(
        authRepository: inject(),
      ),
    );

    inject.registerFactory(
      () => RegisterViewModel(
        authRepository: inject(),
      ),
    );

    inject.registerFactory(
      () => ForgotPasswordViewModel(
        authRepository: inject(),
      ),
    );

    inject.registerFactory(
      () => LogoutViewModel(
        authRepository: inject(),
      ),
    );
    inject.registerFactory(
      () => OnboardingLayetteCustomizationPageViewModel(
        layettesRepository: inject(),
      ),
    );
  }

  void _setupUsecases() {}

  void _setupUtils() {
    inject.registerFactory(() => LogApp());
  }

  void _setupHandles() {
    inject.registerLazySingleton(
      () => ExceptionHandler(
        handlers: [
          FirebaseAuthExceptionHandler(),
          FirebaseExceptionHandler(),
        ],
      ),
    );
  }
}
