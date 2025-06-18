import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_project/consts/app_colors.dart';
import 'package:test_project/views/comment_page/widgets/comment_card.dart';
import 'package:test_project/model/post_model.dart';
import 'package:test_project/views/news_feed/widgets/badge.dart';
import 'package:test_project/views/news_feed/widgets/image_layout.dart';
import 'package:test_project/views/news_feed/widgets/user_info.dart';
import 'package:test_project/views/share/share_page.dart';

class NewsFeedCard extends StatelessWidget {
  final PostModel post;
  const NewsFeedCard({Key? key, required this.post}) : super(key: key);

  //comment function
  void addComment(String text, String postId) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null || text.isEmpty) return;

    final ref = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('comments&replays')
        .doc(postId);

    final snap = await ref.get();
    if (snap.exists) {
      ref.update({
        'comments': FieldValue.arrayUnion([text]),
      });
    } else {
      ref.set({
        'comments': [text],
      }, SetOptions(merge: true));
    }
  }

  @override
  Widget build(BuildContext context) {
    final commentController = TextEditingController();
    final postId = post.id ?? '';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          User_icon(post: post),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Badge_text(text: post.airline),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Badge_text(text: post.departureAirport),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Badge_text(text: post.arrivalAirport),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Badge_text(
                  text: '${post.travelDate.month}/${post.travelDate.year}',
                ),
              ),
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
          if (post.imageUrl?.length == 3) ImageLayout(images: post.imageUrl!),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.thumb_up_alt_outlined, size: 20),
                  SizedBox(width: 5),
                  Text('Like'),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.share_outlined, size: 20),
                    onPressed: () {
                      showSharePopup(context, shareUrl: "https://example.com");
                    },
                    // Implement share functionality  },
                  ),
                  const SizedBox(width: 5),
                  const Text('Share'),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
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
                            addComment(text, postId);
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
