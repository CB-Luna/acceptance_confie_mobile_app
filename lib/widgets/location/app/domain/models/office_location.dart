class OfficeLocation {
  final String id;
  final double latitude;
  final double longitude;
  final String address;
  final String secondaryAddress;
  final bool isOpen;
  final String closeHours;
  final double distanceInMiles;
  final String reference;
  final double rating;

  OfficeLocation({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.secondaryAddress,
    required this.isOpen,
    required this.closeHours,
    required this.distanceInMiles,
    this.reference = '',
    this.rating = 0.0,
  });

  // Factory method to create an OfficeLocation from a map marker's position
  factory OfficeLocation.fromLatLng(
    String id,
    double latitude,
    double longitude,
    String address,
    double distanceInMiles,
  ) {
    return OfficeLocation(
      id: id,
      latitude: latitude,
      longitude: longitude,
      address: address,
      secondaryAddress: 'Office Location',
      isOpen: true, // Default values
      closeHours: '5:00 PM', // Default values
      distanceInMiles: distanceInMiles,
    );
  }
}
