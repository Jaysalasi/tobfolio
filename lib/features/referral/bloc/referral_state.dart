import 'package:equatable/equatable.dart';
import 'package:tobfolio/features/referral/model/rewards_model.dart';

class ReferralState extends Equatable {
  final bool isLoading;
  final String? errorMessage;
  final RewardsModel? rewardsModel;

  const ReferralState({
    this.isLoading = false,
    this.errorMessage,
    this.rewardsModel,
  });

  ReferralState copyWith({
    bool? isLoading,
    String? errorMessage,
    RewardsModel? rewardsModel,

  }) {
    return ReferralState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      rewardsModel: rewardsModel ?? this.rewardsModel,
    );
  }

  @override
  List<Object?> get props => [isLoading, errorMessage, rewardsModel];

  @override
  String toString() =>
      'ReferralState(isLoading: $isLoading, errorMessage: $errorMessage, rewardsModel: $rewardsModel)';
}
