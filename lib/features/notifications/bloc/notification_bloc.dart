import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tobfolio/features/notifications/model/notif_model.dart';
import 'notification_event.dart';
import 'notification_state.dart';

class NotificationBloc
    extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationInitial()) {
    on<LoadNotifications>(_load);
  }

  Future<void> _load(
    LoadNotifications event,
    Emitter<NotificationState> emit,
  ) async {
    emit(NotificationLoading());

    await Future.delayed(const Duration(milliseconds: 400));

    final now = DateTime.now();

    final notifications = List.generate(
      5,
      (i) => AppNotification(
        id: "$i",
        title: "Lorem ipsum....",
        message:
            "Lorem ipsum lorem ipsum Lorem ipsum lorem ipsum lorem ipsum",
        date: now,
        image: "assets/images/house.png",
        isRead: i % 2 == 0,
      ),
    );

    emit(
      NotificationLoaded(
        today: notifications.take(3).toList(),
        recent: notifications.skip(3).toList(),
      ),
    );
  }
}