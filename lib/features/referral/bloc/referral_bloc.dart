import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tobfolio/features/referral/bloc/referral_event.dart';
import 'package:tobfolio/features/referral/bloc/referral_state.dart';
import 'package:tobfolio/features/referral/model/rewards_model.dart';
import 'package:tobfolio/features/referral/repository/referral_repository.dart';

class ReferralBloc extends Bloc<ReferralEvent, ReferralState> {
  final ReferralRepository _referralRepository;

  ReferralBloc({required ReferralRepository referralRepository}) : _referralRepository = referralRepository, super(const ReferralState()) {
    on<LoadReferralData>(onLoadReferralData);

  }

  Future<void> onLoadReferralData(LoadReferralData event, Emitter<ReferralState> emit) async {
    emit(state.copyWith(isLoading: true));

    try {
      final res = await _referralRepository.getReferralData();
      final referralData = RewardsModel.fromJson(res);
      emit(state.copyWith(isLoading: false, rewardsModel: referralData));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }
}