abstract class TenantEvent {}

class AddTenant extends TenantEvent {}

class UpdateRentFrequency extends TenantEvent {
  final String type;
  UpdateRentFrequency(this.type);
}

class UpdateRentRenewalDate extends TenantEvent {}
