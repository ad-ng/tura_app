import 'package:flutter/material.dart';
import 'package:tura_app/features/notification/presentation/bloc/eachNotificationCard.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (BuildContext context, int index) {
        return Eachnotificationcard();
      },
    );
  }
}
