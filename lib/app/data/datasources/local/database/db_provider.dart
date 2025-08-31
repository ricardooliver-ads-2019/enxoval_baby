
import "package:path/path.dart";
import 'package:sqflite/sqflite.dart';
import 'db_schema.dart';

class DBProvider {
  static const _dbName = 'enxoval_baby.db';
  static const _dbVersion = 1;

  /// Inicializa e retorna a instância do Database
  static Future<Database> init() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);

    return openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
      onOpen: (db) async {
        // Garante suporte a chaves estrangeiras
        await db.execute('PRAGMA foreign_keys = ON;');
      },
    );
  }

  /// Executado apenas na criação inicial do banco
  static Future<void> _onCreate(Database db, int version) async {
    await db.execute(createTableLayette);
    await db.execute(createTableCategory);
    await db.execute(createTableItem);

    // Cria índices para performance
    for (final indexSql in createIndexes) {
      await db.execute(indexSql);
    }
  }
}
