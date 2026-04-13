import 'package:equatable/equatable.dart';
import '../model/tenant_profile_model.dart';

abstract class TenantProfileState extends Equatable {
  const TenantProfileState();

  @override
  List<Object?> get props => [];
}

class TenantProfileInitial extends TenantProfileState {}

class TenantProfileLoading extends TenantProfileState {}

class TenantProfileLoaded extends TenantProfileState {
  final Tenant tenant;

  const TenantProfileLoaded(this.tenant);

  @override
  List<Object?> get props => [tenant];
}

class TenantProfileError extends TenantProfileState {
  final String message;

  const TenantProfileError(this.message);

  @override
  List<Object?> get props => [message];
}

class TenantProfileSuccess extends TenantProfileState {
  final String message;

  const TenantProfileSuccess(this.message);

  @override
  List<Object?> get props => [message];
}