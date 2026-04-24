import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../repositories/profile_repositories.dart';

part 'currency_event.dart';
part 'currency_state.dart';

class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {
  final ProfileRepository _profileRepository;

  CurrencyBloc({required ProfileRepository profileRepository})
      : _profileRepository = profileRepository,
        super(const CurrencyState()) {
    on<UpdateCurrency>(_onUpdateCurrency);
  }

  Future<void> _onUpdateCurrency(
    UpdateCurrency event,
    Emitter<CurrencyState> emit,
  ) async {
    emit(state.copyWith(status: CurrencyStatus.loading, clearError: true));

    try {
      await _profileRepository.updateCurrency(event.currency);
      emit(state.copyWith(
        status: CurrencyStatus.success,
        selectedCurrency: event.currency,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: CurrencyStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
}
