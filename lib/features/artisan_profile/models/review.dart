import 'package:equatable/equatable.dart';

class Review extends Equatable {
  final String id;
  final String handymanId;
  final User reviewer;
  final int rating;
  final String comment;
  final DateTime createdAt;

  const Review({
    required this.id,
    required this.handymanId,
    required this.reviewer,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['_id'] as String,
      handymanId: json['handymanId'] as String,
      reviewer: User.fromJson(json['userId'] as Map<String, dynamic>),
      rating: json['rating'] as int,
      comment: json['comment'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'handymanId': handymanId,
      'userId': reviewer.toJson(),
      'rating': rating,
      'comment': comment,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        handymanId,
        reviewer,
        rating,
        comment,
        createdAt,
      ];
}

class User extends Equatable {
  final String id;
  final String name;

  const User({
    required this.id,
    required this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] as String,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
    };
  }

  @override
  List<Object?> get props => [id, name];
}
