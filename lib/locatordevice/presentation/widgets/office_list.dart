import 'package:flutter/material.dart';
import '../../domain/entities/office.dart';

class OfficeList extends StatelessWidget {
  final List<Office> offices;
  final ScrollController scrollController;
  final Function(Office) onOfficeTap;

  const OfficeList({
    required this.offices,
    required this.scrollController,
    required this.onOfficeTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(51),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Indicador de arrastre
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 8, bottom: 12),
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),

          // Título
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Oficinas cercanas',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Lista de oficinas
          Expanded(
            child: offices.isEmpty
                ? const Center(child: Text('No hay oficinas disponibles'))
                : ListView.separated(
                    controller: scrollController,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    itemCount: offices.length,
                    separatorBuilder: (_, __) => const Divider(),
                    itemBuilder: (context, index) {
                      final office = offices[index];
                      return OfficeListItem(
                        office: office,
                        index: index,
                        onTap: () => onOfficeTap(office),
                        onDirectionsTap: () => onOfficeTap(office),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class OfficeListItem extends StatelessWidget {
  final Office office;
  final int index;
  final VoidCallback onTap;
  final VoidCallback onDirectionsTap;

  const OfficeListItem({
    required this.office,
    required this.index,
    required this.onTap,
    required this.onDirectionsTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).primaryColor,
        child: Text('${index + 1}'),
      ),
      title: Text(office.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(office.address),
          if (office.phone != null)
            Text(
              'Tel: ${office.phone}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          Text('${office.distanceInMiles.toStringAsFixed(2)} miles'),
        ],
      ),
      isThreeLine: true,
      trailing: IconButton(
        icon: const Icon(Icons.directions),
        onPressed: onDirectionsTap,
      ),
      onTap: onTap,
    );
  }
}
