
import 'package:enxoval_baby/app/core/failures/app_failure.dart';

import 'result.dart';


extension ResultExtension on Object {
  Result ok() {
    return Result.ok(this);
  }
}

extension ResultException on Exception {
  Result error() {
    return Result.error(this);
  }
}

/// Extensão para expor isOk / isError e acesso seguro ao conteúdo
extension ResultStatusExtension<T> on Result<T> {
  /// `true` se for uma instância de `Ok<T>`
  bool get isOk => this is Ok<T>;

  /// `true` se for uma instância de `Error<T>`
  bool get isError => this is Error<T>;

  /// Retorna o valor em caso de `Ok`, ou `null` caso contrário
  T? get valueOrNull => this is Ok<T> ? (this as Ok<T>).value : null;

  /// Retorna a exceção em caso de `Error`, ou `null` caso contrário
  Exception? get errorOrNull =>
      this is Error<T> ? (this as Error<T>).error : null;

  /// Se for `Ok`, executa [onOk] passando o valor e retorna o próprio resultado.
  /// Se for `Error`, executa [onError] passando a exceção e retorna o próprio resultado.
  Result<T> when({
    void Function(T value)? onOk,
    void Function(Exception error)? onError,
  }) {
    if (isOk && onOk != null) {
      onOk((this as Ok<T>).value);
    } else if (isError && onError != null) {
      onError((this as Error<T>).error);
    }
    return this;
  }
}
extension ResultFold<T> on Result<T> {
  R fold<R>(R Function(T value) onOk, R Function(Exception error) onError) {
    if (this is Ok<T>) return onOk((this as Ok<T>).value);
    return onError((this as Error<T>).error);
  }
}

extension ResultMatch<T> on Result<T> {
  R match<R>({
    required R Function(T value) ok,
    required R Function(Exception error) error,
  }) {
    if (this is Ok<T>) return ok((this as Ok<T>).value);
    return error((this as Error<T>).error);
  }
}

extension ResultCasting<T> on Result<T> {
  Ok<T> get asOk => this as Ok<T>;
  Error<T> get asError => this as Error<T>;
}

// lib/src/core/result/result_extensions.dart

/// Extensão para padronizar todo Error<X> em Failure, extraindo a mensagem
/// e recriando um Result.error(Failure).
extension ResultErrorHandling<T> on Result<T> {
  /// Se este Result for um Error<T>, devolve um novo Error<T> cujo
  /// `Failure` foi normalizado, e chama [onMessage] passando a mensagem
  /// (ou toString) para que a ViewModel armazene em `erroMensagem`.
  ///
  /// Se for Ok<T>, devolve `this` sem alterações.
  Result<T> normalizeError(void Function(String message) onMessage) {
    // 1) Se não for Error<T>, retorna como está.
    if (this is! Error<T>) return this;

    // 2) É Error<T>, então extrai a Exception interna:
    final errorResult = this as Error<T>;
    final exception = errorResult.error;

    // 3) Se for um Failure, usa a própria mensagem. Senão, converte p/ string.
    late final AppFailure failureToReturn;
    if (exception is AppFailure) {
      failureToReturn = exception;
    } else {
      failureToReturn = AppException(
        errorMessage: exception.toString(),
        exception: exception,
      );
    }

    // 4) Chama onMessage para que a ViewModel atualize sua String de erro:
    onMessage(failureToReturn.errorMessage);

    // 5) Retorna um novo Error<T> contendo sempre um Failure:
    return Result.error(failureToReturn);
  }
}

/// Extensão para padronizar todo Error<X> em Failure, sem callbacks.
extension ResultToFailure<T> on Result<T> {
  /// Se este Result for Error<T>, extrai a exceção interna e:
  ///  - se já for Failure, mantém;
  ///  - senão, envolve em Failure(errorMessage: exception.toString()).
  /// Retorna um novo Error<T> com o Failure sempre presente.
  /// Se for Ok<T>, devolve `this` sem alterações.
  Result<T> toFailureResult() {
    if (this is! Error<T>) return this;

    final errorResult = this as Error<T>;
    final exception = errorResult.error;

    final failure =
        exception is AppFailure
            ? exception
            : AppException(errorMessage: exception.toString(), exception: exception);

    return Result.error(failure);
  }
}
