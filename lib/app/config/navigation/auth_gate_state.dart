import 'package:enxoval_baby/app/core/result/result_extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:enxoval_baby/app/domain/repositories/auth_repository.dart';
import 'package:enxoval_baby/app/domain/usecases/has_completed_onboarding_layette_customization_usecase.dart';

class AuthGateState extends ChangeNotifier {
  final AuthRepository _authRepo;
  final HasCompletedOnboardingLayetteCustomizationUsecase _hasCompletedOnboarding;

  AuthGateState({
    required AuthRepository authRepo,
    required HasCompletedOnboardingLayetteCustomizationUsecase hasCompletedOnboarding,
  })  : _authRepo = authRepo,
        _hasCompletedOnboarding = hasCompletedOnboarding;

  bool isAuth = false;
  bool? onboardingDone; // null => carregando/indefinido

  bool _started = false;
  VoidCallback? _authListener;
  int _requestId = 0; // evita condições de corrida

  void start() {
    if (_started) return;
    _started = true;

    isAuth = _authRepo.isAuth.value;

    // Listener com referência salva para remoção posterior
    _authListener = () async {
      final newAuth = _authRepo.isAuth.value;
      if (newAuth == isAuth) return;
      isAuth = newAuth;

      if (isAuth) {
        onboardingDone = null;
        notifyListeners();

        final localReq = ++_requestId;
        final res = await _hasCompletedOnboarding();
        if (localReq != _requestId) return; // resultado obsoleto, ignore

        onboardingDone = res.fold((ok) => ok, (err) => false);
      } else {
        onboardingDone = null;
      }
      notifyListeners();
    };

    _authRepo.isAuth.addListener(_authListener!);

    // bootstrap inicial
    if (isAuth) {
      _recomputeOnboarding();
    } else {
      onboardingDone = null;
      notifyListeners();
    }
  }

  /// Permite forçar o recálculo (ex.: após concluir onboarding).
  Future<void> refreshOnboarding() async => _recomputeOnboarding();

  Future<void> _recomputeOnboarding() async {
    onboardingDone = null;
    notifyListeners();

    final localReq = ++_requestId;
    final res = await _hasCompletedOnboarding();
    if (localReq != _requestId) return;

    onboardingDone = res.fold((ok) => ok, (err) => false);
    notifyListeners();
  }

  @override
  void dispose() {
    if (_authListener != null) {
      _authRepo.isAuth.removeListener(_authListener!);
      _authListener = null;
    }
    super.dispose();
  }
}
