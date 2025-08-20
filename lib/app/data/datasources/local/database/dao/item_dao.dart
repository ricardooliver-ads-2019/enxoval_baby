// item_dao.dart
import 'package:enxoval_baby/app/data/models/item_model.dart';
import 'package:sqflite/sqflite.dart';



class ItemDao {
  final Database _db;
  ItemDao({ required Database db}) : _db = db;

  Future<List<ItemModel>> getPendingItems() async {
    final rows = await _db.query('items', where: 'syncStatus != ?', whereArgs: [0]);
    return rows.map((r) => ItemModel.fromDbMap(r)).toList();
  }

  Future<void> insertItem(ItemModel model) async {
    await _db.insert('items', model.toDbMap(), conflictAlgorithm: ConflictAlgorithm.replace);

  }

  Future<void> updateItem(ItemModel model) async {
    await _db.update('items', model.toDbMap(), where: 'id = ?', whereArgs: [model.id]);
  }

  Future<void> markAsSynced(String id, int remoteUpdatedAt) async {
    await _db.update('items', {'syncStatus': 0, 'remoteUpdatedAt': remoteUpdatedAt}, where: 'id = ?', whereArgs: [id]);
  }
}
