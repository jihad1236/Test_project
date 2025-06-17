import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_project/consts/app_colors.dart';

class CommentDetails extends StatelessWidget {
  final String postId;

  const CommentDetails({super.key, required this.postId});

  Stream<DocumentSnapshot<Map<String, dynamic>>> postStream() {
    final user = FirebaseAuth.instance.currentUser;
    return FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('comments&replays')
        .doc(postId)
        .snapshots();
  }

  Future<void> addReply(String comment, String replyText) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null || comment.isEmpty || replyText.isEmpty) return;

    final postRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('comments&replays')
        .doc(postId);

    await postRef.update({
      'replays.$comment': FieldValue.arrayUnion([replyText]),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Comments",
          style: TextStyle(color: AppColors.textPrimary),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        actions: const [Icon(Icons.more_vert, color: AppColors.textPrimary)],
      ),
      body: SafeArea(
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: postStream(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final data = snapshot.data!.data();
            if (data == null) return const Center(child: Text("No data found"));

            final comments =
                (data['comments'] as List<dynamic>? ?? []).cast<String>();
            final replays = (data['replays'] as Map<String, dynamic>? ?? {});

            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: comments.length,
              itemBuilder: (context, index) {
                final comment = comments[index];
                final replies =
                    (replays[comment] as List<dynamic>? ?? []).cast<String>();
                final replyController = TextEditingController();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _commentItem(
                      avatarUrl:
                          'https://cdn-icons-png.flaticon.com/512/147/147144.png',
                      name: 'User',
                      comment: comment,
                      time: 'on Fri',
                    ),
                    ...replies.map(
                      (reply) => Padding(
                        padding: const EdgeInsets.only(left: 40),
                        child: _commentItem(
                          avatarUrl:
                              'https://cdn-icons-png.flaticon.com/512/236/236831.png',
                          name: 'ReplyUser',
                          comment: reply,
                          time: 'on Sat',
                          mentionName: 'User',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 40,
                        top: 6,
                        bottom: 12,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: replyController,
                              decoration: const InputDecoration(
                                hintText: 'Write a reply...',
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.send,
                              color: AppColors.primary,
                            ),
                            onPressed: () {
                              final replyText = replyController.text.trim();
                              if (replyText.isNotEmpty) {
                                addReply(comment, replyText);
                                replyController.clear();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _commentItem({
    required String avatarUrl,
    required String name,
    required String comment,
    required String time,
    String? mentionName,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(radius: 18, backgroundImage: NetworkImage(avatarUrl)),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 14,
                    ),
                    children: [
                      TextSpan(
                        text: '$name\n',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      if (mentionName != null)
                        TextSpan(
                          text: '$mentionName ',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      TextSpan(
                        text: comment.replaceFirst(mentionName ?? '', ''),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Text(
                    time,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Like',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Reply',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
