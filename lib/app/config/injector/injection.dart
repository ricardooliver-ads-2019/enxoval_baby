import 'package:enxoval_baby/app/config/navigation/auth_gate_state.dart';
import 'package:enxoval_baby/app/core/handler/exception_handler.dart';
import 'package:enxoval_baby/app/core/handler/exception_mapper/firebase_auth_exception_handler.dart';
import 'package:enxoval_baby/app/core/handler/exception_mapper/firebase_exception_handler.dart';
import 'package:enxoval_baby/app/core/handler/exception_mapper/local_exception_handler.dart';
import 'package:enxoval_baby/app/core/log/log_app.dart';
import 'package:enxoval_baby/app/data/datasources/local/database/dao/category_dao.dart';
import 'package:enxoval_baby/app/data/datasources/local/database/dao/item_dao.dart';
import 'package:enxoval_baby/app/data/datasources/local/database/dao/layette_dao.dart';
import 'package:enxoval_baby/app/data/datasources/local/database/db_provider.dart';
import 'package:enxoval_baby/app/data/datasources/local/secure_user_storage.dart';
import 'package:enxoval_baby/app/data/datasources/local/local_layettes_datasource.dart';
import 'package:enxoval_baby/app/data/datasources/remote/firebase_auth_datasource.dart';
import 'package:enxoval_baby/app/data/datasources/remote/firebase_layettes_datasource.dart';
import 'package:enxoval_baby/app/data/datasources/remote/firebase_user_datasource.dart';
import 'package:enxoval_baby/app/data/datasources/remote/generic_layettes_datasource.dart';
import 'package:enxoval_baby/app/data/repositories/auth_repository_impl.dart';
import 'package:enxoval_baby/app/data/repositories/layettes_repository_impl.dart';
import 'package:enxoval_baby/app/domain/repositories/auth_repository.dart';
import 'package:enxoval_baby/app/domain/repositories/layttes_repository.dart';
import 'package:enxoval_baby/app/domain/usecases/has_completed_onboarding_layette_customization_usecase.dart';
import 'package:enxoval_baby/app/presentation/auth/forgot_password/view_model/forgot_password_view_model.dart';
import 'package:enxoval_baby/app/presentation/auth/login/view_model/login_view_model.dart';
import 'package:enxoval_baby/app/presentation/auth/logout/view_model/logout_view_model.dart';
import 'package:enxoval_baby/app/presentation/auth/register/view_model/register_view_model.dart';
import 'package:enxoval_baby/app/presentation/home_enxoval/view_model/home_enxoval_view_model.dart';
import 'package:enxoval_baby/app/presentation/onboarding_layette_customization/view_model/onboarding_layette_customization_page_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';

class Injection {
  static GetIt get inject => GetIt.instance;

  Future<void> setup() async {
    _setupHandles();
    _setupDatasources();
    _setupRepositories();
    _setupUsecases();
    _setupViewModels();
    _setupUtils();
    await inject.allReady();
  }

  void _setupDatasources() {// Banco SQLite como singleton assíncrono
    // 1) DB async
    inject.registerSingletonAsync<Database>(() async {
      return await DBProvider.init();
    });

    // 2) DAO depende do DB (também async)
    inject.registerSingletonAsync<LayetteDao>(() async {
      final db = await inject.getAsync<Database>();
      return LayetteDao(db: db);
    }, dependsOn: [Database]);
    inject.registerSingletonAsync<CategoryDao>(() async {
      final db = await inject.getAsync<Database>();
      return CategoryDao(db: db);
    }, dependsOn: [Database]);
    inject.registerSingletonAsync<ItemDao>(() async {
      final db = await inject.getAsync<Database>();
      return ItemDao(db: db);
    }, dependsOn: [Database]);

    // 3) Local DS depende do DAO
    inject.registerSingletonAsync<LocalLayettesDatasource>(() async {
      final layetteDao = await inject.getAsync<LayetteDao>();
      final categoryDao = await inject.getAsync<CategoryDao>();
      final itemDao = await inject.getAsync<ItemDao>();
      return LocalLayettesDatasource(
        layetteDao: layetteDao,
        categoryDao: categoryDao,
        itemDao: itemDao,
      );
    }, dependsOn: [LayetteDao, CategoryDao, ItemDao]);

    inject.registerSingleton(SecureUserStorage());
    inject.registerSingleton(FirebaseAuthDatasource());
    inject.registerSingleton(FirebaseUserDatasource());
    inject.registerSingleton(FirebaseLayettesDatasource());
    inject.registerSingleton(GenericLayettesDatasource());
  }

  void _setupRepositories() {
    inject.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(auth: inject(), userDataSource: inject(), session: inject(), handler: inject()),
    );
    inject.registerLazySingleton<LayettesRepository>(
      () => LayettesRepositoryImpl(genericLayettesdataSource: inject(),localLayettesDatasource:  inject(), firebaseLayettesDatasource: inject(), session: inject(), handler: inject()),
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

    inject.registerFactory(
      () => HomeEnxovalViewModel(
        layettesRepository: inject(),
      ),
    );
  }

  void _setupUsecases() {
    inject.registerFactory(
      () => HasCompletedOnboardingLayetteCustomizationUsecase(
        layettesRepository: inject(),
      ),
    );
  }

  void _setupUtils() {
    inject.registerFactory(() => LogApp());
    if (!inject.isRegistered<AuthGateState>()) {
      inject.registerLazySingleton<AuthGateState>(
        () => AuthGateState(
          authRepo: inject<AuthRepository>(),
          hasCompletedOnboarding: inject<HasCompletedOnboardingLayetteCustomizationUsecase>(),
        )..start(),
      );
    }
  }

  void _setupHandles() {
    inject.registerLazySingleton(
      () => ExceptionHandler(
        handlers: [
          LocalDBExceptionHandler(), 
          FirebaseAuthExceptionHandler(),
          FirebaseExceptionHandler(),
        ],
      ),
    );
  }
}
