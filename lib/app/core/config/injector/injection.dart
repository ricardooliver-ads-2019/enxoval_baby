import 'package:enxoval_baby/app/data/datasources/remote/firebase_auth_datasource.dart';
import 'package:enxoval_baby/app/data/repositories/auth_repository_impl.dart';
import 'package:enxoval_baby/app/domain/repositories/auth_repository.dart';
import 'package:enxoval_baby/app/presentation/login/view_model/login_view_model.dart';
import 'package:enxoval_baby/app/presentation/logout/viem_model/logout_view_model.dart';
import 'package:get_it/get_it.dart';

class Injection {
  static GetIt get inject => GetIt.instance;

  void setup() {
    _setupDatasources();
    _setupRepositories();
    _setupUsecases();
    _setupViewModels();
  }

  void _setupDatasources() {
    inject.registerSingleton<FirebaseAuthDatasource>(FirebaseAuthDatasource());
  }

  void _setupRepositories() {
    inject.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(auth: inject()),
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
}
