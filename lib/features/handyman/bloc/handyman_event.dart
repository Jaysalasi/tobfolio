part of 'handyman_bloc.dart';

abstract class HandymanEvent extends Equatable {
  const HandymanEvent();

  @override
  List<Object?> get props => [];
}

class GetHandymen extends HandymanEvent {
  final String? expertise;
  final String? location;
  final String? search;

  const GetHandymen({
    this.expertise,
    this.location,
    this.search,
  });

  @override
  List<Object?> get props => [expertise, location, search];
}

class SearchHandymen extends HandymanEvent {
  final String query;

  const SearchHandymen(this.query);

  @override
  List<Object?> get props => [query];
}

class FilterHandymen extends HandymanEvent {
  final String? expertise;
  final String? location;

  const FilterHandymen({
    this.expertise,
    this.location,
  });

  @override
  List<Object?> get props => [expertise, location];
}

class RefreshHandymen extends HandymanEvent {}
