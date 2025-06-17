class PostModel {
  final String id;
  final String departureAirport;
  final String arrivalAirport;
  final String airline;
  final String travelClass;
  final String message;
  final DateTime travelDate;
  final double rating;
  final List<String>? imageUrl;
  List<String>? comments;
  List<String>? likes;
  List<Map<String, dynamic>>? replays;

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
    this.comments,
    this.likes,
    this.replays,
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
      'comments': comments,
      'likes': likes,
      'replays': replays,
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
      imageUrl: map['imageUrl']?.cast<String>(),
      comments: map['comments']?.cast<String>(),
      likes: map['likes']?.cast<String>(),
      replays: map['replays']?.cast<Map<String, dynamic>>(),
    );
  }
}
