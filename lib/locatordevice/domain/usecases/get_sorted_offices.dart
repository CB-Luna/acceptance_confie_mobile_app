import 'package:flutter/foundation.dart';

import '../repositories/location_repository.dart';

class GetSortedOffices {
  final LocationRepository repository;

  GetSortedOffices(this.repository);

  Future<List<Map<String, dynamic>>> execute() async {
    try {
      debugPrint('GetSortedOffices: Executing use case');
      return await repository.getSortedOffices();
    } catch (e) {
      debugPrint('GetSortedOffices: Error executing use case: $e');
      rethrow;
    }
  }
}
