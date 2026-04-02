part of 'artisan_profile_bloc.dart';

abstract class ArtisanProfileEvent extends Equatable {
  const ArtisanProfileEvent();

  @override
  List<Object?> get props => [];
}

class GetArtisanProfile extends ArtisanProfileEvent {
  final String id;

  const GetArtisanProfile(this.id);

  @override
  List<Object?> get props => [id];
}

class RefreshArtisanProfile extends ArtisanProfileEvent {}
