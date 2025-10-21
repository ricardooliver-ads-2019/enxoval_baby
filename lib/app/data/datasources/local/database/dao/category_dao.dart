import 'package:sqflite/sqflite.dart';
import 'package:enxoval_baby/app/data/models/category_model.dart';

class CategoryDao {
  final Database _db;
  CategoryDao({required Database db}) : _db = db;

  Future<List<CategoryModel>> getByLayette(String layetteId) async {
    final rows = await _db.query(
      'categories',
      where: 'layetteId = ? AND (deletedAt IS NULL OR deletedAt = 0)',
      whereArgs: [layetteId],
      orderBy: 'updatedAt IS NULL, updatedAt DESC',
    );
    return rows.map(CategoryModel.fromDbMap).toList();
  }

  Future<CategoryModel?> getById(String id) async {
    final rows = await _db.query(
      'categories',
      where: 'id = ? AND (deletedAt IS NULL OR deletedAt = 0)',
      whereArgs: [id],
      limit: 1,
    );
    if (rows.isEmpty) return null;
    return CategoryModel.fromDbMap(rows.first);
  }

  Future<void> upsertOne(CategoryModel c, {DatabaseExecutor? exec}) async {
    final e = exec ?? _db;
    await e.insert('categories', c.toDbMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> upsertAll(List<CategoryModel> categories, {DatabaseExecutor? exec}) async {
    if (categories.isEmpty) return;
    final e = exec ?? _db;
    final b = e.batch();
    for (final c in categories) {
      b.insert('categories', c.toDbMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await b.commit(noResult: true);
  }

  Future<int> deleteByLayette(String layetteId, {DatabaseExecutor? exec}) async {
    final e = exec ?? _db;
    return e.delete('categories', where: 'layetteId = ?', whereArgs: [layetteId]);
  }

  Future<int> deleteById(String id, {DatabaseExecutor? exec}) async {
    final e = exec ?? _db;
    return e.delete('categories', where: 'id = ?', whereArgs: [id]);
  }
}
