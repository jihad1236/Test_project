class PostModel {
  final String departureAirport;
  final String arrivalAirport;
  final String airline;
  final String travelClass;
  final String message;
  final DateTime travelDate;
  final double rating;
  final String imageUrl;

  PostModel({
    required this.departureAirport,
    required this.arrivalAirport,
    required this.airline,
    required this.travelClass,
    required this.message,
    required this.travelDate,
    required this.rating,
    required this.imageUrl,
  });
}

// ✅ Dummy list outside the class
