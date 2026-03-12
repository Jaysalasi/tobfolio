import 'package:equatable/equatable.dart';

abstract class AllPropertyEvent extends Equatable {
  const AllPropertyEvent();

  @override
  List<Object?> get props => [];
}

class LoadProperties extends AllPropertyEvent {}