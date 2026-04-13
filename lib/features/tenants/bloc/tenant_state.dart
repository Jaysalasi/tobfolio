class TenantState {
  final String rentFrequency;
  final String rentRenewalDate;
  final String rentExpiryDate;
  final String rentFee;
  final bool isLoading;
  final String? error;
  final List<Map<String, dynamic>>? tenants;
  
  TenantState({
    this.rentFrequency = '',
    this.rentRenewalDate = '',
    this.rentExpiryDate = '',
    this.rentFee = '',
    this.isLoading = false,
    this.error,
    this.tenants,
  });
  
  TenantState copyWith({
    String? rentFrequency,
    String? rentRenewalDate,
    String? rentExpiryDate,
    String? rentFee,
    bool? isLoading,
    String? error,
    List<Map<String, dynamic>>? tenants,
  }) {
    return TenantState(
      rentFrequency: rentFrequency ?? this.rentFrequency,
      rentRenewalDate: rentRenewalDate ?? this.rentRenewalDate,
      rentExpiryDate: rentExpiryDate ?? this.rentExpiryDate,
      rentFee: rentFee ?? this.rentFee,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      tenants: tenants ?? this.tenants,
    );
  }
}