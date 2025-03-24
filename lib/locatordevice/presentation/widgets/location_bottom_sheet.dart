import 'package:flutter/material.dart';
import 'package:freeway_app/locatordevice/presentation/widgets/loading_view.dart';

import '../../domain/entities/office.dart';
import '../bloc/location_state.dart';
import 'office_list_item.dart' as list_item;

class LocationBottomSheet extends StatelessWidget {
  final LocationState state;

  const LocationBottomSheet({
    required this.state,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (state is LocationAndOfficesLoading) {
      return _buildLoading();
    } else if (state is LocationAndOfficesLoaded) {
      return _buildOfficesList((state as LocationAndOfficesLoaded).offices);
    } else if (state is LocationError) {
      return _buildError((state as LocationError).message);
    } else {
      return _buildDefault();
    }
  }

  Widget _buildLoading() {
    return const SizedBox(
      height: 200,
      child: Center(child: LoadingView(message: 'Loading...')),
    );
  }

  Widget _buildOfficesList(List<Office> offices) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Oficinas cercanas',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          offices.isEmpty
              ? const Center(child: Text('No hay oficinas disponibles'))
              : ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: offices.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, index) =>
                      list_item.OfficeListItem(office: offices[index]),
                ),
        ],
      ),
    );
  }

  Widget _buildError(String message) {
    return SizedBox(
      height: 200,
      child: Center(
        child:
            Text('Error: $message', style: const TextStyle(color: Colors.red)),
      ),
    );
  }

  Widget _buildDefault() {
    return const SizedBox(
      height: 200,
      child: Center(child: Text('No hay información disponible')),
    );
  }
}
