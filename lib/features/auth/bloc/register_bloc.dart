import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/register_request.dart';
import '../models/auth_response.dart';
import '../repositories/auth_repository.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository _authRepository;

  RegisterBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const RegisterState()) {
    on<RegisterSubmitted>(_onRegisterSubmitted);
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
      ));
    } catch (e) {
      emit(state.copyWith(
        status: RegisterStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}
