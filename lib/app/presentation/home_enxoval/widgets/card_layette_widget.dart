import 'package:design_system/design_system.dart';
import 'package:enxoval_baby/app/domain/entities/layette_entity.dart';
import 'package:flutter/material.dart';

class CardLayetteWidget extends StatelessWidget {
  final LayetteEntity layette;
  final VoidCallback onTap;

  const CardLayetteWidget({
    super.key,
    required this.layette,
    required this.onTap,
  });

  bool get _isActive {
    final now = DateTime.now();
    final createdAt = DateTime.fromMillisecondsSinceEpoch(layette.updatedAt);
    final dueDate = layette.layetteProfile.dueDate;

    if (dueDate != null) {
      // Se tem data prevista, considera 30 dias após o parto
      final gracePeriod = dueDate.add(const Duration(days: 30));
      return now.isBefore(gracePeriod);
    } else {
      // Se não tem data prevista, considera 1 ano da criação
      final oneYearAfterCreation = createdAt.add(const Duration(days: 365));
      return now.isBefore(oneYearAfterCreation);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: _isActive ? DSColors.alertSucess : DSColors.textGray,
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          layette.layetteProfile.nameBaby ?? 'Meu bebê',
                          style: DSTextStyle.subtitle2(context).strong,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _isActive ? 'Enxoval ativo' : 'Enxoval inativo',
                          style: DSTextStyle.caption1(
                            context,
                            cor: _isActive
                                ? DSColors.alertSucess
                                : DSColors.textGray,
                          ).defaults,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircularProgressIndicator(
                          value: layette.globalProgress / 100,
                          backgroundColor: DSColors.terciary,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            _getProgressColor(layette.globalProgress / 100),
                          ),
                          strokeWidth: 5,
                        ),
                        Text(
                          '${layette.globalProgress.toStringAsFixed(0)}%',
                          style: DSTextStyle.caption1(context).strong,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Duração',
                        style: DSTextStyle.caption1(
                          context,
                          cor: DSColors.textGray,
                        ).defaults,
                      ),
                      Text(
                        '${layette.layetteProfile.layetteDurationInMonths} meses',
                        style: DSTextStyle.body3(context).defaults,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Itens',
                        style: DSTextStyle.caption1(
                          context,
                          cor: DSColors.textGray,
                        ).defaults,
                      ),
                      Text(
                        '${layette.totalPurchasedAll}/${layette.totalNeededAll}',
                        style: DSTextStyle.body3(context).defaults,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total gasto',
                        style: DSTextStyle.caption1(
                          context,
                          cor: DSColors.textGray,
                        ).defaults,
                      ),
                      Text(
                        'R\$ ${layette.totalSpentAll.toStringAsFixed(2)}',
                        style: DSTextStyle.body3(context).defaults,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getProgressColor(double progress) {
    if (progress >= 0.8) return DSColors.alertSucess;
    if (progress >= 0.5) return DSColors.alertWarning;
    return DSColors.alertError;
  }
}
