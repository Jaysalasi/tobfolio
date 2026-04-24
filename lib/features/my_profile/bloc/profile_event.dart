part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class UpdateProfile extends ProfileEvent {
  final String name;
  final String email;
  final String phone;
  final String about;
  final String currency;

  const UpdateProfile({
    required this.name,
    required this.email,
    required this.phone,
    required this.about,
    required this.currency,
  });

  @override
  List<Object?> get props => [name, email, phone, about, currency];
}
