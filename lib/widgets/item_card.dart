import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final String itemName;
  final int bought;
  final int total;
  final String priority;
  final double progress;
  final double amountSpent;
  final IconData itemIcon;
  final VoidCallback onDetails;

  const ItemCard({
    super.key,
    required this.itemName,
    required this.bought,
    required this.total,
    required this.priority,
    required this.progress,
    required this.amountSpent,
    required this.itemIcon,
    required this.onDetails,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onDetails,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageIconWidget(
              imageIcon: Icon(
                itemIcon,
                size: 50,
                color: Colors.blueAccent,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    itemName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  SizedBox(
                    height: 55,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                          width: 72,
                          child: LinearProgressItensWidget(
                            bought: bought,
                            total: total,
                            progress: progress,
                          ),
                        ),
                        const VerticalDivider(
                          width: 20,
                          thickness: 1,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: _getPriorityColor(priority),
                              ),
                              child: Text(
                                priority,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  'Gasto: R\$ ${amountSpent.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'essential':
        return Colors.red.shade200;
      case 'recommended':
        return Colors.orange.shade200;
      case 'optional':
        return Colors.green.shade200;
      default:
        return Colors.grey.shade300;
    }
  }
}

class CircularProgressItensWidget extends StatelessWidget {
  final int bought;
  final int total;
  final double progress;
  const CircularProgressItensWidget({
    super.key,
    required this.bought,
    required this.total,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 50,
          height: 50,
          child: CircularProgressIndicator(
            value: progress,
            color: Colors.green,
            backgroundColor: Colors.grey[200],
            strokeWidth: 5,
          ),
        ),
        Column(
          children: [
            Text(
              '$bought',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                height: 0.2,
                fontStyle: FontStyle.normal,
              ),
            ),
            const SizedBox(
              width: 25,
              child: Divider(),
            ),
            Text(
              '$total',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                height: 0.2,
                fontStyle: FontStyle.normal,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class CircularProgressTestWidget extends StatelessWidget {
  final int bought;
  final int total;
  final double progress;
  const CircularProgressTestWidget({
    super.key,
    required this.bought,
    required this.total,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 50,
          height: 50,
          child: CircularProgressIndicator(
            value: progress,
            color: Colors.green,
            backgroundColor: Colors.grey[200],
            strokeWidth: 5,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$bought',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                height: 0.2,
              ),
            ),
            const Text(
              '/',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                height: 0.2,
              ),
            ),
            Text(
              '$total',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                height: 0.2,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class LinearProgressItensWidget extends StatelessWidget {
  final int bought;
  final int total;
  final double progress;
  const LinearProgressItensWidget({
    super.key,
    required this.bought,
    required this.total,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '$bought/$total',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: progress,
          color: Colors.green,
          backgroundColor: Colors.grey[200],
        ),
        const SizedBox(height: 4),
        if (total - bought > 0)
          Row(
            children: [
              Text.rich(
                TextSpan(
                  text: 'Falta: ',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                  children: [
                    TextSpan(
                      text: '${total - bought}',
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
      ],
    );
  }
}

class ImageIconWidget extends StatelessWidget {
  final Widget imageIcon;
  const ImageIconWidget({super.key, required this.imageIcon});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.cyan.shade100,
      ),
      child: SizedBox(
        width: 80,
        height: 90,
        child: imageIcon,
      ),
    );
  }
}
