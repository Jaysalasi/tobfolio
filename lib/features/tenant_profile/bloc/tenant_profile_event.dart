import 'package:equatable/equatable.dart';

abstract class TenantProfileEvent extends Equatable {
  const TenantProfileEvent();

  @override
  List<Object?> get props => [];
}

class LoadTenantProfile extends TenantProfileEvent {}