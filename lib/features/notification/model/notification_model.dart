class AppNotification {
  final String id;
  final String title;
  final String message;
  final DateTime date;
  final String image;
  final bool isRead;

  AppNotification({
    required this.id,
    required this.title,
    required this.message,
    required this.date,
    required this.image,
    required this.isRead,
  });
}