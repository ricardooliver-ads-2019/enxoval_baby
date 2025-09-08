import 'package:sqflite/sqflite.dart';
import 'package:enxoval_baby/app/data/models/layette_model.dart';

class LayetteDao {
  final Database _db;
  LayetteDao({required Database db}) : _db = db;

  Future<bool> existsForUser(String userId) async {
    final res = await _db.rawQuery(
      'SELECT 1 FROM layettes WHERE userId = ? AND (deletedAt IS NULL OR deletedAt = 0) LIMIT 1',
      [userId],
    );
    return res.isNotEmpty;
  }

  Future<List<LayetteModel>> getByUser(String userId) async {
    final maps = await _db.query(
      'layettes',
      where: 'userId = ? AND (deletedAt IS NULL OR deletedAt = 0)',
      whereArgs: [userId],
      orderBy: 'updatedAt IS NULL, updatedAt DESC', // compatível com SQLite
    );
    return maps.map(LayetteModel.fromDbMap).toList();
  }

  Future<LayetteModel?> getById(String id) async {
    final maps = await _db.query(
      'layettes',
      where: 'id = ? AND (deletedAt IS NULL OR deletedAt = 0)',
      whereArgs: [id],
      limit: 1,
    );
    if (maps.isEmpty) return null;
    return LayetteModel.fromDbMap(maps.first);
  }

  Future<void> upsertOne(LayetteModel l, {DatabaseExecutor? exec}) async {
    final e = exec ?? _db;
    await e.insert(
      'layettes',
      l.toDbMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> upsertAll(List<LayetteModel> layettes, {DatabaseExecutor? exec}) async {
    if (layettes.isEmpty) return;
    final e = exec ?? _db;
    final b = e.batch();
    for (final l in layettes) {
      b.insert('layettes', l.toDbMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await b.commit(noResult: true);
  }

  /// Executa uma transação sem expor o Database.
  Future<T> runInTransaction<T>(Future<T> Function(Transaction txn) action) {
    return _db.transaction(action);
  }

  Future<int> hardDeleteByUser(String userId) {
    return _db.delete('layettes', where: 'userId = ?', whereArgs: [userId]);
  }
}
