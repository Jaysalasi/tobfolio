part of 'currency_bloc.dart';

enum CurrencyStatus { initial, loading, success, error }

class CurrencyState extends Equatable {
  final CurrencyStatus status;
  final String? selectedCurrency;
  final String? errorMessage;

  const CurrencyState({
    this.status = CurrencyStatus.initial,
    this.selectedCurrency,
    this.errorMessage,
  });

  CurrencyState copyWith({
    CurrencyStatus? status,
    String? selectedCurrency,
    String? errorMessage,
    bool clearError = false,
  }) {
    return CurrencyState(
      status: status ?? this.status,
      selectedCurrency: selectedCurrency ?? this.selectedCurrency,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [status, selectedCurrency, errorMessage];
}
