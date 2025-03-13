class PlaceModel {
  final String id;
  final String name;
  final double latitude;
  final double longitude;
  final String? address;
  final String? description;
  final List<String>? photos;

  PlaceModel({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    this.address,
    this.description,
    this.photos,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'description': description,
      'photos': photos,
    };
  }

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      id: json['id'] as String,
      name: json['name'] as String,
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
      address: json['address'] as String?,
      description: json['description'] as String?,
      photos: (json['photos'] as List?)?.map((e) => e as String).toList(),
    );
  }
}
