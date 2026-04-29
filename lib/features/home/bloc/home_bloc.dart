import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tob/core/storage/secure_storage_service.dart';
import 'package:tob/core/utils/logger.dart';
import 'package:tob/features/auth/models/user.dart';
import 'package:tob/features/home/model/dashboard_model.dart';
import 'package:tob/features/home/repository/home_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository _homeRepository;
  HomeBloc({required HomeRepository homeRepository}) : _homeRepository = homeRepository, super(const HomeState()) {
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
      // await Future.delayed(const Duration(seconds: 2));
      final res = await _homeRepository.getDashboardData();

      final dashboardData = DashboardModel.fromJson(res);

      // print('Dashboard data: $dashboardData');
      
      // Get stored user data
      // final user = await getStoredUser();
      final userProfile = await getUserProfile();
      // Emit state with user data
      emit(state.copyWith(isLoading: false, user: userProfile, dashboard: dashboardData));
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
      if (userData == null) {
        return null;
      }
      final user = User.fromJson(userData);
      return user;
    } catch (e) {
      authLogger.e('Error getting stored user: $e');
      return null;
    }
  }

  Future<User?> getUserProfile() async {
    try {
      final userData = await _homeRepository.getUserData();
      if (userData == null) {
        return null;
      }
      final user = User.fromJson(userData);
      return user;
    } catch (e) {
      authLogger.e('Error getting stored user: $e');
      return null;
    }
  }
}
