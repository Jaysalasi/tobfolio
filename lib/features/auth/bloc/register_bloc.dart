import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/register_request.dart';
import '../models/auth_response.dart';
import '../repositories/auth_repository.dart';
import 'auth_bloc.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository _authRepository;
  final AuthBloc _authBloc;

  RegisterBloc({
    required AuthRepository authRepository,
    required AuthBloc authBloc,
  })  : _authRepository = authRepository,
        _authBloc = authBloc,
        super(const RegisterState()) {
    on<RegisterSubmitted>(_onRegisterSubmitted);
    on<GoogleSignInSubmitted>(_onGoogleSignInSubmitted);
  }

  Future<void> _onRegisterSubmitted(
    RegisterSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(status: RegisterStatus.loading));

    try {
      final registerRequest = RegisterRequest(
        name: event.name,
        email: event.email,
        password: event.password,
      );

      final authResponse = await _authRepository.register(registerRequest);

      emit(state.copyWith(
        status: RegisterStatus.success,
        authResponse: authResponse,
        isGoogleSignIn: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: RegisterStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onGoogleSignInSubmitted(
    GoogleSignInSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(status: RegisterStatus.loading));

    try {
      final loginResponse = await _authRepository.googleSignIn();

      _authBloc.add(AuthUserUpdated(loginResponse.user, isGoogleSignIn: true));

      emit(state.copyWith(
        status: RegisterStatus.success,
        isGoogleSignIn: true,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: RegisterStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}
