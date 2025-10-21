import 'package:enxoval_baby/app/domain/entities/item_entity.dart';
import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final String id;
  final String layetteId;
  final String name;
  final String? icon;
  final bool isCustom;
  final int updatedAt;
  final int syncStatus;
  final List<ItemEntity> items;

  const CategoryEntity({
    required this.id,
    required this.layetteId,
    required this.name,
    this.icon,
    this.isCustom = false,
    required this.updatedAt,
    this.syncStatus = 1,
    required this.items,
  });

    /// Total de itens necessários
  int get totalNeeded =>
      items.fold(0, (sum, item) => sum + item.quantityNeeded);

  /// Total de itens comprados
  int get totalPurchased =>
      items.fold(0, (sum, item) => sum + item.quantityPurchased);

  /// Categoria está completa?
  bool get isCompleted => totalPurchased >= totalNeeded;

  /// Total gasto nessa categoria
  double get totalSpent =>
      items.fold(0.0, (sum, item) => sum + item.totalSpent);

  /// Progresso em %
  double get progress {
    if (isCompleted) return 100.0;
    if (totalNeeded == 0) return 0.0;
    return (totalPurchased / totalNeeded) * 100;
  }
  
  @override
  List<Object?> get props => [
        id,
        layetteId,
        name,
        icon,
        isCustom,
        updatedAt,
        syncStatus,
        items,
        totalNeeded,
        totalPurchased,
        totalSpent,
        progress,
        isCompleted,
      ];
}
