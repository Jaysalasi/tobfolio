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
      
      // Update AuthBloc to maintain logged-in state
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
}
