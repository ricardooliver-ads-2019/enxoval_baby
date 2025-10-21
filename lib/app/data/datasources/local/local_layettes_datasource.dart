import 'package:enxoval_baby/app/data/datasources/local/database/dao/layette_dao.dart';
import 'package:enxoval_baby/app/data/datasources/local/database/dao/category_dao.dart';
import 'package:enxoval_baby/app/data/datasources/local/database/dao/item_dao.dart';
import 'package:enxoval_baby/app/data/models/layette_model.dart';
import 'package:enxoval_baby/app/data/models/category_model.dart';
import 'package:enxoval_baby/app/data/models/item_model.dart';
import 'package:enxoval_baby/app/domain/entities/layette_entity.dart';
import 'package:enxoval_baby/app/domain/entities/category_entity.dart';

class LocalLayettesDatasource {
  final LayetteDao _layetteDao;
  final CategoryDao _categoryDao;
  final ItemDao _itemDao;

  LocalLayettesDatasource({
    required LayetteDao layetteDao,
    required CategoryDao categoryDao,
    required ItemDao itemDao,
  })  : _layetteDao = layetteDao,
        _categoryDao = categoryDao,
        _itemDao = itemDao;

  /// Layettes agregadas (com categorias e itens)
  Future<List<LayetteEntity>> fetchUserLayettesWithChildren(String userId) async {
    final bases = await _layetteDao.getByUser(userId); // List<LayetteModel>
    final result = <LayetteEntity>[];
    for (final base in bases) {
      result.add(await fetchLayetteAggregate(base.id));
    }
    return result;
  }

  Future<LayetteEntity> fetchLayetteAggregate(String layetteId) async {
    final base = await _layetteDao.getById(layetteId);
    if (base == null) {
      throw Exception('Layette $layetteId não encontrado localmente');
    }

    final cats = await _categoryDao.getByLayette(layetteId);
    final List<CategoryEntity> catsWithItems = [];
    for (final c in cats) {
      final items = await _itemDao.getByCategory(c.id);
      catsWithItems.add(
        CategoryModel(
          id: c.id,
          layetteId: c.layetteId,
          name: c.name,
          icon: c.icon,
          isCustom: c.isCustom,
          updatedAt: c.updatedAt,
          syncStatus: c.syncStatus,
          items: items,
        ),
      );
    }

    return LayetteModel(
      id: base.id,
      userId: base.userId,
      layetteProfile: base.layetteProfile,
      updatedAt: base.updatedAt,
      syncStatus: base.syncStatus,
      categories: catsWithItems,
    );
  }

  /// Upsert transacional do agregado
  Future<void> upsertAggregate({
    required LayetteModel layette,
    required List<CategoryModel> categories,
    required List<ItemModel> items,
  }) async {
    await _layetteDao.runInTransaction((txn) async {
      await _layetteDao.upsertOne(layette, exec: txn);
      await _categoryDao.upsertAll(categories, exec: txn);
      await _itemDao.upsertAll(items, exec: txn);
    });
  }

  // Consultas pontuais
  Future<List<CategoryModel>> fetchCategoriesByLayette(String layetteId) =>
      _categoryDao.getByLayette(layetteId);

  Future<CategoryModel?> fetchCategoryById(String categoryId) =>
      _categoryDao.getById(categoryId);

  Future<List<ItemModel>> fetchItemsByCategory(String categoryId) =>
      _itemDao.getByCategory(categoryId);

  Future<ItemModel?> fetchItemById(String itemId) =>
      _itemDao.getById(itemId);

  // Base (sem filhos)
  Future<List<LayetteModel>> fetchUserLayettes(String userId) =>
      _layetteDao.getByUser(userId);

  Future<void> upsertLayettes(List<LayetteModel> layettes) =>
      _layetteDao.upsertAll(layettes);
}
