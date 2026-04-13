abstract class TenantEvent {}

class AddTenant extends TenantEvent {}

class CreateTenant extends TenantEvent {
  final String name;
  final String email;
  final String phone;
  final String propertyId;
  final String unitNumber;
  final double rentAmount;
  final String rentStart;
  final String rentEnd;
  final String rentDuration;
  final String paymentFrequency;
  final String? imagePath;
  final String? notes;

  CreateTenant({
    required this.name,
    required this.email,
    required this.phone,
    required this.propertyId,
    required this.unitNumber,
    required this.rentAmount,
    required this.rentStart,
    required this.rentEnd,
    required this.rentDuration,
    required this.paymentFrequency,
    this.imagePath,
    this.notes,
  });
}

class FetchTenants extends TenantEvent {}

class UpdateRentFrequency extends TenantEvent {
  final String type;
  UpdateRentFrequency(this.type);
}


class UpdateRentRenewalDate extends TenantEvent {}

class UpdateRentFee extends TenantEvent {
  final String rentFee;
  UpdateRentFee(this.rentFee);
}
