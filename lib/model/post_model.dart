class PostModel {
  final String id;
  final String departureAirport;
  final String arrivalAirport;
  final String airline;
  final String travelClass;
  final String message;
  final DateTime travelDate;
  final double rating;
  final String imageUrl;

  PostModel({
    required this.id,
    required this.departureAirport,
    required this.arrivalAirport,
    required this.airline,
    required this.travelClass,
    required this.message,
    required this.travelDate,
    required this.rating,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'departureAirport': departureAirport,
      'arrivalAirport': arrivalAirport,
      'airline': airline,
      'travelClass': travelClass,
      'message': message,
      'travelDate': travelDate.toIso8601String(), // Store as ISO string
      'rating': rating,
      'imageUrl': imageUrl,
    };
  }

  // Optional: fromMap constructor for fetching back from Firebase
  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      id: map['id'],
      departureAirport: map['departureAirport'],
      arrivalAirport: map['arrivalAirport'],
      airline: map['airline'],
      travelClass: map['travelClass'],
      message: map['message'],
      travelDate: DateTime.parse(map['travelDate']),
      rating: map['rating'].toDouble(),
      imageUrl: map['imageUrl'],
    );
  }
}
