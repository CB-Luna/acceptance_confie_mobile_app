import 'package:flutter/material.dart';

import '../../domain/entities/office.dart';

class OfficeListItem extends StatelessWidget {
  final Office office;
  final VoidCallback? onTap;

  const OfficeListItem({
    required this.office,
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    office.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(office.address),
                  const SizedBox(height: 4),
                  Text(office.phone),
                ],
              ),
            ),
            if (office.distance != null) ...[
              Text(
                '${(office.distance! / 1000).toStringAsFixed(1)} km',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
