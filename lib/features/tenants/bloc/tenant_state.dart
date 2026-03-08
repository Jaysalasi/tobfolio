class TenantState {
  final String rentFrequency;
  final String rentRenewalDate;
  final String rentExpiryDate;
  final String rentFee;
  
  TenantState({
    this.rentFrequency = '',
    this.rentRenewalDate = '',
    this.rentExpiryDate = '',
    this.rentFee = '',
  });
  
  TenantState copyWith({
    String? rentFrequency,
    String? rentRenewalDate,
    String? rentExpiryDate,
    String? rentFee,
  }) {
    return TenantState(
      rentFrequency: rentFrequency ?? this.rentFrequency,
      rentRenewalDate: rentRenewalDate ?? this.rentRenewalDate,
      rentExpiryDate: rentExpiryDate ?? this.rentExpiryDate,
      rentFee: rentFee ?? this.rentFee,
    );
  }
}