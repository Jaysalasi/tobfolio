import 'package:equatable/equatable.dart';
import 'package:tob/features/notifications/model/notif_model.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object?> get props => [];
}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationLoaded extends NotificationState {
  final List<AppNotification> today;
  final List<AppNotification> recent;

  const NotificationLoaded({
    required this.today,
    required this.recent,
  });

  @override
  List<Object?> get props => [today, recent];
}

class NotificationError extends NotificationState {
  final String message;

  const NotificationError(this.message);

  @override
  List<Object?> get props => [message];
}