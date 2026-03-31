import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tob/core/storage/secure_storage_service.dart';
import 'package:tob/core/utils/logger.dart';
import 'package:tob/features/auth/models/user.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<LoadHomeData>(_onLoadHomeData);
  }
  final SecureStorageService _storageService = SecureStorageService();
  Future<void> _onLoadHomeData(
    LoadHomeData event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // Get stored user data
      final user = await getStoredUser();
      print("got user ${user?.name}");
      // Emit state with user data
      emit(state.copyWith(isLoading: false, user: user));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<User?> getStoredUser() async {
    try {
      final userData = await _storageService.getUser();
      print('Retrieved user data from storage bloc home : $userData');
      if (userData == null) {
        print('User data is null');
        return null;
      }
      final user = User.fromJson(userData);
      print('Parsed user: ${user.name}');
      return user;
    } catch (e) {
      authLogger.e('Error getting stored user: $e');
      print('Error getting stored user: $e');
      return null;
    }
  }
}
