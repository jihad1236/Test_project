import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:test_project/auth/auth_controller.dart';
import 'package:test_project/consts/app_colors.dart';
import 'package:test_project/elements/news_feed_ui/news_feed.dart';
import 'package:test_project/model/post_model.dart';
import 'package:test_project/views/authentication/register.dart';
import 'package:test_project/views/presentations/post.dart';

class Home extends StatelessWidget {
  Home({super.key});
  final controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildHeader(),
                const SizedBox(height: 30),
                _buildActionButtons(context),
                const SizedBox(height: 30),
                _buildBanner(),
                const SizedBox(height: 30),
                _buildPostStream(),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() => Row(
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
              const Icon(Iconsax.notification, size: 24),
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
            onPressed: () => Get.to(RegisterPage()),
            icon: const Icon(Iconsax.menu_1, size: 24),
          ),
          if (FirebaseAuth.instance.currentUser != null)
            IconButton(
              onPressed: () async => await controller.logoutUser(),
              icon: const Icon(Iconsax.logout, size: 24),
            ),
        ],
      ),
    ],
  );

  Widget _buildActionButtons(BuildContext context) => Column(
    children: [
      LayoutBuilder(
        builder: (context, constraints) {
          final isSmall = constraints.maxWidth < 400;
          final width =
              isSmall ? constraints.maxWidth : (constraints.maxWidth - 12) / 2;
          return Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: [
              SizedBox(
                width: width,
                child: _button(
                  () => Get.to(() => ShareWidget()),
                  'Share Your Experience',
                  Iconsax.people,
                ),
              ),
              SizedBox(
                width: width,
                child: _button(() {}, 'Ask A Question', Iconsax.profile_2user),
              ),
            ],
          );
        },
      ),
      const SizedBox(height: 16),
      _button(() {}, 'Search', Iconsax.search_normal, fullWidth: true),
    ],
  );

  Widget _button(
    VoidCallback onTapped,
    String text,
    IconData icon, {
    bool fullWidth = false,
  }) => GestureDetector(
    onTap: onTapped,
    child: Container(
      height: 55,
      width: fullWidth ? double.infinity : null,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(18),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: const TextStyle(
              color: AppColors.background,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 10),
          Icon(icon, color: AppColors.background, size: 20),
        ],
      ),
    ),
  );

  Widget _buildBanner() => ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: Image.network(
      'https://cdn.builder.io/api/v1/image/assets/TEMP/ff067bcb39fee40b73b34de6bb576e78066e75a2?apiKey=e4ec6974213f4eed99937f80a28e2030',
      height: 120,
      fit: BoxFit.cover,
    ),
  );

  Widget _buildPostStream() => StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance.collection('users').snapshots(),
    builder: (context, userSnapshot) {
      if (userSnapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (userSnapshot.hasError) {
        return const Center(child: Text('Error loading posts'));
      } else if (!userSnapshot.hasData || userSnapshot.data!.docs.isEmpty) {
        return const Center(child: Text('No posts available'));
      }

      List<PostModel> allPosts = [];
      for (var userDoc in userSnapshot.data!.docs) {
        final data = userDoc.data() as Map<String, dynamic>;
        if (data.containsKey('posts')) {
          final List posts = data['posts'];
          allPosts.addAll(
            posts.map<PostModel>(
              (postData) =>
                  PostModel.fromMap(Map<String, dynamic>.from(postData)),
            ),
          );
        }
      }
      allPosts.sort((a, b) => b.travelDate.compareTo(a.travelDate));

      return Column(
        children:
            allPosts
                .map(
                  (post) => Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: NewsFeedCard(post: post),
                  ),
                )
                .toList(),
      );
    },
  );
}
