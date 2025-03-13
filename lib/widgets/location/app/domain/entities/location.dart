class Location {
  final double latitude;
  final double longitude;
  final String? name;
  final String? address;

  const Location({
    required this.latitude,
    required this.longitude,
    this.name,
    this.address,
  });
}
