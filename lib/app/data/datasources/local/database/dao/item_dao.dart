import 'package:sqflite/sqflite.dart';
import 'package:enxoval_baby/app/data/models/item_model.dart';

class ItemDao {
  final Database _db;
  ItemDao({ required Database db}) : _db = db;

  Future<List<ItemModel>> getByCategory(String categoryId) async {
    final rows = await _db.query(
      'items',
      where: 'categoryId = ? AND (deletedAt IS NULL OR deletedAt = 0)',
      whereArgs: [categoryId],
      orderBy: 'updatedAt IS NULL, updatedAt DESC',
    );
    return rows.map(ItemModel.fromDbMap).toList();
  }

  Future<ItemModel?> getById(String id) async {
    final rows = await _db.query(
      'items',
      where: 'id = ? AND (deletedAt IS NULL OR deletedAt = 0)',
      whereArgs: [id],
      limit: 1,
    );
    if (rows.isEmpty) return null;
    return ItemModel.fromDbMap(rows.first);
  }

  Future<void> upsertOne(ItemModel it, {DatabaseExecutor? exec}) async {
    final e = exec ?? _db;
    await e.insert('items', it.toDbMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> upsertAll(List<ItemModel> items, {DatabaseExecutor? exec}) async {
    if (items.isEmpty) return;
    final e = exec ?? _db;
    final b = e.batch();
    for (final it in items) {
      b.insert('items', it.toDbMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await b.commit(noResult: true);
  }

  Future<int> deleteByCategory(String categoryId, {DatabaseExecutor? exec}) async {
    final e = exec ?? _db;
    return e.delete('items', where: 'categoryId = ?', whereArgs: [categoryId]);
  }

  Future<int> deleteById(String id, {DatabaseExecutor? exec}) async {
    final e = exec ?? _db;
    return e.delete('items', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<ItemModel>> getPendingItems() async {
    final rows = await _db.query('items', where: 'syncStatus != ?', whereArgs: [0]);
    return rows.map(ItemModel.fromDbMap).toList();
  }

  Future<void> markAsSynced(String id, int remoteUpdatedAt) async {
    await _db.update('items', {
      'syncStatus': 0,
      'remoteUpdatedAt': remoteUpdatedAt,
    }, where: 'id = ?', whereArgs: [id]);
  }
}
