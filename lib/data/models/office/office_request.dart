class OfficeRequest {
  final String? zipCode;
  final double? latitude;
  final double? longitude;
  final int count;

  OfficeRequest({
    this.zipCode,
    this.latitude,
    this.longitude,
    this.count = 5,
  }) : assert(
          (zipCode != null) || (latitude != null && longitude != null),
          'Debe proporcionar un código postal o coordenadas (latitud/longitud)',
        );

  Map<String, dynamic> toJson() {
    if (zipCode != null) {
      return {
        'zc': zipCode,
        'count': count,
      };
    } else {
      return {
        'lat': latitude,
        'lon': longitude,
        'count': count,
      };
    }
  }
}
