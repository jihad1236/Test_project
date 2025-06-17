import 'package:flutter/material.dart';
import 'package:test_project/consts/app_colors.dart';

class CommentDetails extends StatelessWidget {
  const CommentDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert, color: AppColors.textPrimary),
          ),
        ],
        title: Text("Comments", style: TextStyle(color: AppColors.textPrimary)),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _commentItem(
                avatarUrl:
                    'https://cdn-icons-png.flaticon.com/512/147/147144.png',
                name: 'JuNaid Khan ToMal',
                comment: 'course fee ta kindly bolban..?',
                time: 'on Fri',
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: _commentItem(
                  avatarUrl:
                      'https://cdn-icons-png.flaticon.com/512/236/236831.png',
                  name: 'Maruf Khan',
                  comment: 'JuNaid Khan ToMal5500',
                  time: 'on Sat',
                  mentionName: 'JuNaid Khan ToMal',
                ),
              ),
            ],
          ),
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
                          text: '$mentionName',
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
