import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax/iconsax.dart';
import 'package:test_project/views/notification/widgets/notification_card.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  final List<Map<String, dynamic>> dummyNotifications = const [
    {
      'title': 'Booking Confirmed',
      'subtitle': 'Your car rental from Berlin to Munich is confirmed.',
      'icon': Iconsax.calendar_1,
      'time': '2 min ago',
      'isNew': true,
    },
    {
      'title': 'Payment Successful',
      'subtitle': 'Your payment of €120 was successful.',
      'icon': Iconsax.card_tick,
      'time': '1 hr ago',
      'isNew': true,
    },
    {
      'title': 'Ride Reminder',
      'subtitle': 'Your ride starts tomorrow at 9:00 AM.',
      'icon': Iconsax.timer,
      'time': '1 day ago',
      'isNew': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: dummyNotifications.length,
          itemBuilder: (context, index) {
            final notif = dummyNotifications[index];
            return NotificationCard(
              icon: notif['icon'],
              title: notif['title'],
              subtitle: notif['subtitle'],
              time: notif['time'],
              isNew: notif['isNew'],
              delayMs: index * 150,
            );
          },
        ),
      ),
    );
  }
}
