class TenantState {
  final String rentFrequency;
  final String rentRenewalDate;
  final String rentExpiryDate;
  final String rentFee;
  final bool isLoading;
  final bool isActionLoading;
  final bool isActionSuccess;
  final String? actionError;
  final String? error;
  final List<Map<String, dynamic>>? tenants;

  TenantState({
    this.rentFrequency = '',
    this.rentRenewalDate = '',
    this.rentExpiryDate = '',
    this.rentFee = '',
    this.isLoading = false,
    this.isActionLoading = false,
    this.isActionSuccess = false,
    this.actionError,
    this.error,
    this.tenants,
  });

  TenantState copyWith({
    String? rentFrequency,
    String? rentRenewalDate,
    String? rentExpiryDate,
    String? rentFee,
    bool? isLoading,
    bool? isActionLoading,
    bool? isActionSuccess,
    String? actionError,
    String? error,
    List<Map<String, dynamic>>? tenants,
  }) {
    return TenantState(
      rentFrequency: rentFrequency ?? this.rentFrequency,
      rentRenewalDate: rentRenewalDate ?? this.rentRenewalDate,
      rentExpiryDate: rentExpiryDate ?? this.rentExpiryDate,
      rentFee: rentFee ?? this.rentFee,
      isLoading: isLoading ?? this.isLoading,
      isActionLoading: isActionLoading ?? this.isActionLoading,
      isActionSuccess: isActionSuccess ?? this.isActionSuccess,
      actionError: actionError,
      error: error,
      tenants: tenants ?? this.tenants,
    );
  }
}