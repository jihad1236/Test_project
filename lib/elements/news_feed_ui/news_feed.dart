import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_project/consts/app_colors.dart';
import 'package:test_project/elements/news_feed_ui/comment_card.dart';
import 'package:test_project/model/post_model.dart';

class NewsFeedCard extends StatelessWidget {
  final PostModel post;

  const NewsFeedCard({Key? key, required this.post}) : super(key: key);

  void addCommentToPost(String commentText, String postId) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null || postId.isEmpty) return;

    final postDocRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('comments&replays')
        .doc(postId);

    try {
      // Ensure the post exists, or create if needed
      final postSnapshot = await postDocRef.get();
      if (!postSnapshot.exists) {
        await postDocRef.set({
          'comments': [commentText],
        }, SetOptions(merge: true));
      } else {
        await postDocRef.update({
          'comments': FieldValue.arrayUnion([commentText]),
        });
      }

      Get.snackbar('Success', 'Comment added to this post');
    } catch (e) {
      Get.snackbar('Error', 'Failed to add comment: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController commentController = TextEditingController();
    final postId = post.id ?? ''; // Ensure `post.id` is not null

    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                  'https://cdn.builder.io/api/v1/image/assets/TEMP/04db04b61b979a0b730747291978b6fed38d21ca?apiKey=e4ec6974213f4eed99937f80a28e2030',
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Dianne Russell',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                  ),
                  Text(
                    '1 day ago',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Icon(Icons.star, color: AppColors.star, size: 18),
              const SizedBox(width: 4),
              Text(
                '${post.rating.toStringAsFixed(1)}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _Badge(text: post.airline),
              _Badge(text: post.departureAirport),
              _Badge(text: post.arrivalAirport),
              _Badge(text: '${post.travelDate.month}/${post.travelDate.year}'),
            ],
          ),

          const SizedBox(height: 12),
          Text(post.message, style: const TextStyle(fontSize: 14, height: 1.4)),
          const SizedBox(height: 4),
          const Text(
            'See More',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 14),
          if (post.imageUrl != null && post.imageUrl!.length >= 3)
            LayoutBuilder(
              builder: (context, constraints) {
                final screenWidth = constraints.maxWidth;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Image 1: Full Width
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        post.imageUrl![0],
                        height: screenWidth * 0.55, // ~55% of screen width
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Image 2 and 3: Side by side
                    Row(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              post.imageUrl![1],
                              height: screenWidth * 0.3, // ~30% of screen width
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              post.imageUrl![2],
                              height: screenWidth * 0.3,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),

          const SizedBox(height: 10),
          const Row(
            children: [
              Text(
                '30 Like',
                style: TextStyle(color: AppColors.textPrimary, fontSize: 13),
              ),
              SizedBox(width: 16),
              Text(
                '20 Comment',
                style: TextStyle(color: AppColors.textPrimary, fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.thumb_up_alt_outlined, size: 20),
                  SizedBox(width: 5),
                  Text('Like'),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.share_outlined, size: 20),
                  SizedBox(width: 5),
                  Text('Share'),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),

          // 🔽 Pass postId to CommentCard
          CommentCard(postId: postId),

          const SizedBox(height: 16),
          const Text(
            'See More Comments',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16),

          Row(
            children: [
              const CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage(
                  'https://cdn.builder.io/api/v1/image/assets/TEMP/01ed3dea7a6fc1e0a507d8c2c1bbfe1ce0e584e0?apiKey=e4ec6974213f4eed99937f80a28e2030',
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: commentController,
                          style: const TextStyle(fontSize: 13),
                          decoration: const InputDecoration(
                            hintText: 'Write your comment',
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.send_rounded,
                          color: AppColors.primary,
                        ),
                        onPressed: () {
                          final text = commentController.text.trim();
                          if (text.isNotEmpty) {
                            addCommentToPost(text, postId);
                            commentController.clear();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final String text;
  const _Badge({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 213, 213, 213),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      ),
    );
  }
}
