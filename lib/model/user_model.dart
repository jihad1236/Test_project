class UserModel {
  String? id;
  String? name;
  String? email;
  List<Map<String, dynamic>>? posts;
  List<String>? comments;
  List<String>? likes;
  List<Map<String, dynamic>>? replays;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.posts,
    this.comments,
    this.likes,
    this.replays,
  });

  // 🔁 Convert Firestore data into UserModel
  factory UserModel.fromMap(Map<String, dynamic> data, String documentId) {
    return UserModel(
      id: documentId,
      name: data['name'],
      email: data['email'],
      posts:
          (data['posts'] as List<dynamic>?)
              ?.map((e) => Map<String, dynamic>.from(e))
              .toList(),
      comments: List<String>.from(data['comments'] ?? []),
      likes: List<String>.from(data['likes'] ?? []),
      replays:
          (data['replays'] as List<dynamic>?)
              ?.map((e) => Map<String, dynamic>.from(e))
              .toList(),
    );
  }

  // 🔁 Convert UserModel into Firestore-compatible Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'posts': posts ?? [],
      'comments': comments ?? [],
      'likes': likes ?? [],
      'replays': replays ?? [],
    };
  }
}
