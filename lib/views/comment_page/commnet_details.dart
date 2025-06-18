import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_project/consts/app_colors.dart';
import 'package:test_project/views/comment_page/widgets/comment_item.dart';

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
                    CommentItem(
                      avatarUrl:
                          'https://cdn-icons-png.flaticon.com/512/147/147144.png',
                      name: 'User',
                      comment: comment,
                      time: 'on Fri',
                    ),
                    ...replies.map(
                      (reply) => Padding(
                        padding: const EdgeInsets.only(left: 40),
                        child: CommentItem(
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
}
