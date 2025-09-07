import 'package:enxoval_baby/app/domain/entities/category_entity.dart';
import 'package:enxoval_baby/app/domain/entities/layette_profile_entity.dart';
import 'package:equatable/equatable.dart';

class LayetteEntity extends Equatable {
  final String id;
  final String userId;
  final LayetteProfileEntity layetteProfile;
  final int updatedAt;
  final int syncStatus;
  final List<CategoryEntity> categories;

  const LayetteEntity({
    required this.id,
    required this.userId,
    required this.layetteProfile,
    required this.updatedAt,
    this.syncStatus = 1,
    required this.categories,
  });

  /// Total de itens necessários no enxoval
  int get totalNeededAll =>
      categories.fold(0, (sum, cat) => sum + cat.totalNeeded);

  /// Total de itens comprados no enxoval
  int get totalPurchasedAll =>
      categories.fold(0, (sum, cat) => sum + cat.totalPurchased);

  /// Enxoval está completo?
  bool get isCompleted => totalPurchasedAll >= totalNeededAll;

  /// Total gasto no enxoval
  double get totalSpentAll =>
      categories.fold(0.0, (sum, cat) => sum + cat.totalSpent);

  /// Progresso global %
  double get globalProgress {
    if (totalNeededAll == 0) return 0.0;
    if (isCompleted) return 100.0;
    return (totalPurchasedAll / totalNeededAll) * 100;
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        layetteProfile,
        totalNeededAll,
        totalPurchasedAll,
        totalSpentAll,
        globalProgress,
        updatedAt,
        syncStatus,
        categories,
        isCompleted,
      ];
}
