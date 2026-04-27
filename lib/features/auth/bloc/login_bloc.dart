import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/login_request.dart';
import '../models/login_response.dart';
import '../repositories/auth_repository.dart';
import 'auth_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository _authRepository;
  final AuthBloc _authBloc;

  LoginBloc({
    required AuthRepository authRepository,
    required AuthBloc authBloc,
  })  : _authRepository = authRepository,
        _authBloc = authBloc,
        super(const LoginState()) {
    on<LoginSubmitted>(_onLoginSubmitted);
    on<GoogleSignInSubmitted>(_onGoogleSignInSubmitted);
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: LoginStatus.loading));

    try {
      final loginRequest = LoginRequest(
        email: event.email,
        password: event.password,
      );

      final loginResponse = await _authRepository.login(loginRequest);

      _authBloc.add(AuthUserUpdated(loginResponse.user));

      emit(state.copyWith(
        status: LoginStatus.success,
        loginResponse: loginResponse,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: LoginStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onGoogleSignInSubmitted(
    GoogleSignInSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: LoginStatus.loading));

    try {
      final loginResponse = await _authRepository.googleSignIn();

      _authBloc.add(AuthUserUpdated(loginResponse.user, isGoogleSignIn: true));

      emit(state.copyWith(
        status: LoginStatus.success,
        loginResponse: loginResponse,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: LoginStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}
