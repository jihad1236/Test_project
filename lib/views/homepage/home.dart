import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:test_project/auth/auth_controller.dart';
import 'package:test_project/consts/app_colors.dart';
import 'package:test_project/views/news_feed/news_feed.dart';
import 'package:test_project/model/post_model.dart';
import 'package:test_project/views/authentication/register.dart';
import 'package:test_project/views/postpage.dart/post.dart';
import 'package:test_project/views/homepage/widgets/banner.dart';
import 'package:test_project/views/homepage/widgets/button.dart';
import 'package:test_project/views/homepage/widgets/header.dart';

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
                header(controller: controller),
                const SizedBox(height: 30),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isSmall = constraints.maxWidth < 400;
                    final width =
                        isSmall
                            ? constraints.maxWidth
                            : (constraints.maxWidth - 12) / 2;
                    return Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      alignment: WrapAlignment.center,
                      children: [
                        Button(
                          onTapped: () {
                            Get.to(ShareWidget());
                          },
                          text: 'Share Your Experience',
                          icon: Iconsax.profile_2user,
                          fullWidth: isSmall,
                        ),

                        Button(
                          onTapped: () {},
                          text: 'Ask A Question',
                          icon: Iconsax.message_question5,
                          fullWidth: isSmall,
                        ),

                        Button(
                          onTapped: () {},
                          text: 'Search',
                          icon: Iconsax.search_normal,
                          fullWidth: true,
                        ),
                        const SizedBox(height: 10),
                        BannerCarousel(),
                        const SizedBox(height: 10),
                        _buildPostStream(),
                        const SizedBox(height: 10),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

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
