import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/user.dart';
import '../repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const AuthState()) {
    on<AuthStarted>(_onAuthStarted);
    on<AuthUserUpdated>(_onAuthUserUpdated);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onAuthStarted(
    AuthStarted event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));
    
    try {
      final isAuthenticated = await _authRepository.isAuthenticated();
      print('Is authenticated: $isAuthenticated');
      if (isAuthenticated) {
        // Get stored user data if available
        final userData = await _authRepository.getStoredUser();
        print('User data from AuthBloc: $userData');
        if (userData != null) {
          // Restore token to API service
          // await _authRepository.restoreToken();
          
          print('Emitting authenticated state with user: ${userData.name}');
          emit(state.copyWith(
            status: AuthStatus.authenticated,
            user: userData,
          ));
        } else {
          print('User data is null, emitting unauthenticated');
          emit(state.copyWith(status: AuthStatus.unauthenticated));
        }
      } else {
        print('Not authenticated, emitting unauthenticated');
        emit(state.copyWith(status: AuthStatus.unauthenticated));
      }
    } catch (e) {
      print('Error in AuthStarted: $e');
      emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await _authRepository.logout();
      emit(state.copyWith(
        status: AuthStatus.unauthenticated,
        user: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onAuthUserUpdated(
    AuthUserUpdated event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(user: event.user));
  }
}
