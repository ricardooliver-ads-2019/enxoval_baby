import 'package:enxoval_baby/app/core/handler/exception_handler.dart';
import 'package:enxoval_baby/app/core/handler/exception_mapper/firebas_exception_handler.dart';
import 'package:enxoval_baby/app/core/handler/exception_mapper/firebase_auth_exception_handler.dart';
import 'package:enxoval_baby/app/core/log/log_app.dart';
import 'package:enxoval_baby/app/data/datasources/remote/firebase_auth_datasource.dart';
import 'package:enxoval_baby/app/data/repositories/auth_repository_impl.dart';
import 'package:enxoval_baby/app/domain/repositories/auth_repository.dart';
import 'package:enxoval_baby/app/presentation/auth/login/view_model/login_view_model.dart';
import 'package:enxoval_baby/app/presentation/auth/logout/view_model/logout_view_model.dart';
import 'package:get_it/get_it.dart';

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

  void _setupDatasources() {
    inject.registerSingleton<FirebaseAuthDatasource>(FirebaseAuthDatasource());
  }

  void _setupRepositories() {
    inject.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(auth: inject(), handler: inject()),
    );
  }

  void _setupViewModels() {
    inject.registerFactory(
      () => LoginViewModel(
        authRepository: inject(),
      ),
    );
    inject.registerFactory(
      () => LogoutViewModel(
        authRepository: inject(),
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
