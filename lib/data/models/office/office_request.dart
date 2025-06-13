class OfficeRequest {
  final String? zipCode;
  final double? latitude;
  final double? longitude;
  final int radius;
  final String legalEntity;

  OfficeRequest({
    this.zipCode,
    this.latitude,
    this.longitude,
    this.radius = 100,
    this.legalEntity = 'Freeway Insurance Services America, LLC',
  }) : assert(
          (zipCode != null) || (latitude != null && longitude != null),
          'Debe proporcionar un código postal o coordenadas (latitud/longitud)',
        );

  Map<String, dynamic> toJson() {
    return {
      'Latitude': latitude != null ? latitude.toString() : '',
      'Longitude': longitude != null ? longitude.toString() : '',
      'Zipcode': zipCode ?? '',
      'legalEntity': legalEntity,
      'Radius': radius,
    };
  }
}
