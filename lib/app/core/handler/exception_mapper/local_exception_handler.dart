import 'dart:io';

import 'package:enxoval_baby/app/core/failures/app_failure.dart';
import 'package:enxoval_baby/app/core/handler/exception_mapper.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart' show DatabaseException;

class LocalDBExceptionHandler implements ExceptionMapper {
  @override
  Exception? mapException(Exception e, StackTrace stackTrace) {
    // 1) SQLite (sqflite)
    if (e is DatabaseException) {
      final msg = e.toString().toLowerCase();

      if (_contains(msg, ['no such table', 'does not exist'])) {
        return LocalStorageException(
          exception: e,
          stackTrace: stackTrace,
          errorMessage:
              'Tabela local não encontrada. Execute a migração ou reinstale o app.',
        );
      }

      if (_contains(msg, ['database is locked', 'busy'])) {
        return LocalStorageException(
          exception: e,
          stackTrace: stackTrace,
          errorMessage:
              'Banco de dados local ocupado/bloqueado. Tente novamente em instantes.',
        );
      }

      if (_contains(msg, ['database closed'])) {
        return LocalStorageException(
          exception: e,
          stackTrace: stackTrace,
          errorMessage:
              'Conexão com o banco local foi encerrada. Reabra a sessão e tente novamente.',
        );
      }

      if (_contains(msg, ['syntax error'])) {
        return LocalStorageException(
          exception: e,
          stackTrace: stackTrace,
          errorMessage:
              'Erro de sintaxe em consulta local. Verifique a query/DAO.',
        );
      }

      if (_contains(msg, ['unique constraint failed', 'constraint failed'])) {
        return LocalStorageException(
          exception: e,
          stackTrace: stackTrace,
          errorMessage:
              'Violação de restrição no banco local (chave duplicada/integridade).',
        );
      }

      // Padrão para outros erros de SQLite
      return LocalStorageException(
        exception: e,
        stackTrace: stackTrace,
        errorMessage:
            'Falha ao acessar o banco local. Tente novamente ou limpe os dados do app.',
      );
    }

    // 2) FlutterSecureStorage (PlatformException)
    if (e is PlatformException) {
      switch (e.code) {
        case 'NotAvailable':
        case 'Unavailable':
        case 'PasscodeNotSet':
        case 'NotSupported':
          return LocalStorageException(
            exception: e,
            stackTrace: stackTrace,
            errorMessage:
                'Armazenamento seguro indisponível neste dispositivo. Verifique as configurações de segurança.',
          );

        case 'UserCanceled':
        case 'Canceled':
          return LocalStorageException(
            exception: e,
            stackTrace: stackTrace,
            errorMessage: 'Operação cancelada pelo usuário.',
          );

        case 'AuthFailure':
        case 'AuthenticationFailed':
          return LocalStorageException(
            exception: e,
            stackTrace: stackTrace,
            errorMessage:
                'Falha na autenticação para acessar o armazenamento seguro.',
          );

        default:
          return LocalStorageException(
            exception: e,
            stackTrace: stackTrace,
            errorMessage:
                'Falha ao acessar o armazenamento seguro do dispositivo.',
          );
      }
    }

    // 3) Conversões/serialização de JSON / mapeamento
    if (e is FormatException) {
      return FromMapException(
        exception: e,
        stackTrace: stackTrace,
        errorMessage:
            'Formato inválido ao ler dados locais. Os dados podem estar corrompidos.',
      );
    }

    if (e is TypeError || _isCastError(e)) {
      return FromMapException(
        exception: e,
        stackTrace: stackTrace,
        errorMessage:
            'Tipo inválido ao converter dados locais. Verifique DTO/Model/fromMap.',
      );
    }

    // 4) FileSystem (permissões, caminho inexistente, arquivo corrompido)
    if (e is FileSystemException) {
      return LocalStorageException(
        exception: e,
        stackTrace: stackTrace,
        errorMessage:
            'Falha de sistema de arquivos ao acessar o cache local. Verifique permissões e espaço livre.',
      );
    }

    // Não reconhecido por este handler → deixa o próximo mapper decidir.
    return null;
  }

  bool _contains(String haystack, List<String> needles) {
    for (final n in needles) {
      if (haystack.contains(n)) return true;
    }
    return false;
  }

  bool _isCastError(Object e) {
    final s = e.toString().toLowerCase();
    return s.contains('is not a subtype of');
  }
}
