import 'package:flutter/material.dart';
import 'package:flutter_application_3/services/notification_service.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          // Placeholder for the notification buttons with id notification_service

          ElevatedButton(
            onPressed: () {
              AwesomeNotifications().createNotification(
                content: NotificationContent(
                  id: 10,
                  channelKey: 'basic_channel',
                  title: 'Local Notification',
                  body: 'This is a test notification',
                ),
              );
            },
            child: Text('Show Notification'),
          ),

        ],
      ),
    );
  }
}
