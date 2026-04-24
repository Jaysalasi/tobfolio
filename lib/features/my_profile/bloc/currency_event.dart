part of 'currency_bloc.dart';

abstract class CurrencyEvent extends Equatable {
  const CurrencyEvent();

  @override
  List<Object?> get props => [];
}

class UpdateCurrency extends CurrencyEvent {
  final String currency;

  const UpdateCurrency(this.currency);

  @override
  List<Object?> get props => [currency];
}
