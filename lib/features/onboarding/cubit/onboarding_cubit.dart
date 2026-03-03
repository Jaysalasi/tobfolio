import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingState extends Equatable {
  final bool isFirstTime;
  final int currentPage;

  const OnboardingState({
    this.isFirstTime = true,
    this.currentPage = 0,
  });

  OnboardingState copyWith({
    bool? isFirstTime,
    int? currentPage,
  }) {
    return OnboardingState(
      isFirstTime: isFirstTime ?? this.isFirstTime,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  List<Object> get props => [isFirstTime, currentPage];
}

class OnboardingCubit extends Cubit<OnboardingState> {
  static const String _firstTimeKey = 'is_first_time';
  
  OnboardingCubit() : super(const OnboardingState()) {
    _checkFirstTime();
  }

  Future<void> _checkFirstTime() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isFirstTime = prefs.getBool(_firstTimeKey) ?? true;
      emit(state.copyWith(isFirstTime: isFirstTime));
    } catch (e) {
      emit(state.copyWith(isFirstTime: true));
    }
  }

  Future<bool> checkFirstTime() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isFirstTime = prefs.getBool(_firstTimeKey) ?? true;
      emit(state.copyWith(isFirstTime: isFirstTime));
      return isFirstTime;
    } catch (e) {
      return true;
    }
  }

  Future<void> completeOnboarding() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_firstTimeKey, false);
      emit(state.copyWith(isFirstTime: false));
    } catch (e) {
      // Handle error if needed
    }
  }

  void nextPage(int totalPages) {
    if (state.currentPage < totalPages - 1) {
      emit(state.copyWith(currentPage: state.currentPage + 1));
    }
  }

  void previousPage() {
    if (state.currentPage > 0) {
      emit(state.copyWith(currentPage: state.currentPage - 1));
    }
  }

  void goToPage(int page) {
    emit(state.copyWith(currentPage: page));
  }

  Future<void> resetOnboarding() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_firstTimeKey, true);
      emit(state.copyWith(isFirstTime: true, currentPage: 0));
    } catch (e) {
      // Handle error if needed
    }
  }
}
