import 'package:flutter_bloc/flutter_bloc.dart'; 
import 'package:tob/features/auth/models/login_request.dart';
import 'package:tob/features/auth/repositories/auth_repository.dart';

import 'forgot_password_event.dart';
import 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final AuthRepository _authRepository; 

  ForgotPasswordBloc({
    required AuthRepository authRepository, 
  }) : _authRepository = authRepository,
      
       super(const ForgotPasswordState()) {
    on<ForgotPasswordSubmitted>(_onForgotPasswordSubmitted);
  }

  Future<void> _onForgotPasswordSubmitted(
    ForgotPasswordSubmitted event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    emit(state.copyWith(status: ForgotPasswordStatus.loading));

    try {
      // emit(state.copyWith(status: ForgotPasswordStatus.success));
      final forgotPasswordRequest = ForgotPasswordRequest(email: event.email);
      final forgotPasswordResponse = await _authRepository.forgotPassword(
        forgotPasswordRequest,
      );
      emit(state.copyWith(
        status: ForgotPasswordStatus.success,
        forgotPasswordResponse: forgotPasswordResponse,
      ));
    } catch (e) {
      emit(
        state.copyWith(
          status: ForgotPasswordStatus.failure,
          errorMsg: e.toString(),
        ),
      );
    }
  }
}
