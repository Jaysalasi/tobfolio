import 'package:equatable/equatable.dart';

class Handyman extends Equatable {
  final String id;
  final String fullName;
  final String expertise;
  final String location;
  final double rating;
  final int reviewsCount;
  final String description;
  final String time;
  final String phoneNumber;
  final String whatsappNumber;
  final String email;
  final List<String> images;
  final DateTime createdAt;

  const Handyman({
    required this.id,
    required this.fullName,
    required this.expertise,
    required this.location,
    required this.rating,
    required this.reviewsCount,
    required this.description,
    required this.time,
    required this.phoneNumber,
    required this.whatsappNumber,
    required this.email,
    required this.images,
    required this.createdAt,
  });

  factory Handyman.fromJson(Map<String, dynamic> json) {
    return Handyman(
      id: json['_id'] as String,
      fullName: json['fullName'] as String,
      expertise: json['expertise'] as String,
      location: json['location'] as String,
      rating: (json['rating'] as num).toDouble(),
      reviewsCount: json['reviewsCount'] as int,
      description: json['description'] as String,
      time: json['time'] as String,
      phoneNumber: json['phoneNumber'] as String,
      whatsappNumber: json['whatsappNumber'] as String,
      email: json['email'] as String,
      images: (json['images'] as List<dynamic>).cast<String>(),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'fullName': fullName,
      'expertise': expertise,
      'location': location,
      'rating': rating,
      'reviewsCount': reviewsCount,
      'description': description,
      'time': time,
      'phoneNumber': phoneNumber,
      'whatsappNumber': whatsappNumber,
      'email': email,
      'images': images,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        fullName,
        expertise,
        location,
        rating,
        reviewsCount,
        description,
        time,
        phoneNumber,
        whatsappNumber,
        email,
        images,
        createdAt,
      ];
}
