class Office {
  final String officeName;
  final String storeAddress;
  final String phoneNumber;
  final String mondayStoreHours;
  final String tuesdayStoreHours;
  final String wednesdayStoreHours;
  final String thursdayStoreHours;
  final String fridayStoreHours;
  final String saturdayStoreHours;
  final String sundayStoreHours;
  final String officeHours;
  final String officehoursCurrentStatus;
  final double latitude;
  final double longitude;
  final DistanceObj distanceObj;
  final String legalEntity;

  // Getters para mantener compatibilidad con el código existente
  String get name => officeName;
  String get streetAddress => storeAddress;
  String get phone => phoneNumber;
  int get locationId =>
      officeName.hashCode; // Usamos el hash del nombre como ID único

  Office({
    required this.officeName,
    required this.storeAddress,
    required this.phoneNumber,
    required this.mondayStoreHours,
    required this.tuesdayStoreHours,
    required this.wednesdayStoreHours,
    required this.thursdayStoreHours,
    required this.fridayStoreHours,
    required this.saturdayStoreHours,
    required this.sundayStoreHours,
    required this.officeHours,
    required this.officehoursCurrentStatus,
    required this.latitude,
    required this.longitude,
    required this.legalEntity,
    required this.distanceObj,
  });

  factory Office.fromJson(Map<String, dynamic> json) {
    return Office(
      officeName: json['officeName'] ?? '',
      storeAddress: json['storeAddress'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      mondayStoreHours: json['mondayStoreHours'] ?? '',
      tuesdayStoreHours: json['tuesdayStoreHours'] ?? '',
      wednesdayStoreHours: json['wednesdayStoreHours'] ?? '',
      thursdayStoreHours: json['thursdayStoreHours'] ?? '',
      fridayStoreHours: json['fridayStoreHours'] ?? '',
      saturdayStoreHours: json['saturdayStoreHours'] ?? '',
      sundayStoreHours: json['sundayStoreHours'] ?? '',
      officeHours: json['officeHours'] ?? '',
      officehoursCurrentStatus: json['officehoursCurrentStatus'] ?? '',
      latitude: double.tryParse(json['latitude'] ?? '0') ?? 0.0,
      longitude: double.tryParse(json['longitude'] ?? '0') ?? 0.0,
      distanceObj:
          DistanceObj.fromJson(json['distanceObj'] as Map<String, dynamic>),
      legalEntity: json['legalEntity'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'officeName': officeName,
      'storeAddress': storeAddress,
      'phoneNumber': phoneNumber,
      'mondayStoreHours': mondayStoreHours,
      'tuesdayStoreHours': tuesdayStoreHours,
      'wednesdayStoreHours': wednesdayStoreHours,
      'thursdayStoreHours': thursdayStoreHours,
      'fridayStoreHours': fridayStoreHours,
      'saturdayStoreHours': saturdayStoreHours,
      'sundayStoreHours': sundayStoreHours,
      'officeHours': officeHours,
      'officehoursCurrentStatus': officehoursCurrentStatus,
      'latitude': latitude.toString(),
      'longitude': longitude.toString(),
      'distanceObj': distanceObj.toJson(),
      'legalEntity': legalEntity,
    };
  }
}

class DistanceObj {
  final double value;
  final String unitType;

  DistanceObj({
    required this.value,
    required this.unitType,
  });

  factory DistanceObj.fromJson(Map<String, dynamic> json) {
    return DistanceObj(
      value: json['value'] as double? ?? 0.0,
      unitType: json['unitType'] as String? ?? 'miles',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'unitType': unitType,
    };
  }
}
