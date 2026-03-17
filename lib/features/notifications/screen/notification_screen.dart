import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tob/features/notifications/bloc/notification_bloc.dart';
import 'package:tob/features/notifications/bloc/notification_event.dart';
import 'package:tob/features/notifications/bloc/notification_state.dart';
import 'package:tob/features/notifications/screen/widgets/notif_card.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NotificationBloc()..add(LoadNotifications()),
      child: const _NotificationView(),
    );
  }
}

class _NotificationView extends StatelessWidget {
  const _NotificationView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        centerTitle: true,
        title: const Text("Notifications"),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.settings_outlined),
          )
        ],
      ),
      body: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          if (state is NotificationLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is NotificationLoaded) {
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [

                /// TODAY
                if (state.today.isNotEmpty) ...[
                  const Text(
                    "Today",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),

                  ...state.today.map(
                    (n) => NotificationCard(notification: n),
                  ),
                ],

                const SizedBox(height: 20),

                /// MOST RECENT
                if (state.recent.isNotEmpty) ...[
                  const Text(
                    "Most recent",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),

                  ...state.recent.map(
                    (n) => NotificationCard(notification: n),
                  ),
                ],
              ],
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}