import 'package:equatable/equatable.dart';

abstract class TenantProfileEvent extends Equatable {
  const TenantProfileEvent();

  @override
  List<Object?> get props => [];
}

class LoadTenantProfile extends TenantProfileEvent {
  final String tenantId;
  
  const LoadTenantProfile({required this.tenantId});

  @override
  List<Object?> get props => [tenantId];
}

class UpdateTenant extends TenantProfileEvent {
  final String tenantId;
  final Map<String, dynamic> updatedData;
  
  const UpdateTenant({required this.tenantId, required this.updatedData});

  @override
  List<Object?> get props => [tenantId, updatedData];
}