import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:test_project/auth/auth_controller.dart';
import 'package:test_project/consts/app_colors.dart';
import 'package:test_project/views/authentication/register.dart';
import 'package:test_project/views/notification/notification_page.dart';
import 'package:test_project/views/profile/profile_page.dart';

class header extends StatelessWidget {
  const header({super.key, required this.controller});

  final AuthController controller;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const Text(
        'Airline Review',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      Row(
        children: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Iconsax.notification),
                iconSize: 24,
                onPressed: () {
                  Get.to(() => NotificationPage());
                },
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Text(
                    '2',
                    style: TextStyle(
                      color: AppColors.background,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          const CircleAvatar(
            radius: 18,
            backgroundImage: NetworkImage(
              'https://cdn.builder.io/api/v1/image/assets/TEMP/04db04b61b979a0b730747291978b6fed38d21ca?apiKey=e4ec6974213f4eed99937f80a28e2030',
            ),
          ),
          const SizedBox(width: 16),
          IconButton(
            onPressed: () {
              Get.to(() => ProfilePage(controller: controller));
            },
            icon: const Icon(Iconsax.menu_1, size: 24),
          ),
        ],
      ),
    ],
  );
}
