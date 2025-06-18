import 'package:flutter/material.dart';
import 'package:test_project/consts/app_colors.dart';

class CommentItem extends StatelessWidget {
  final String avatarUrl;
  final String name;
  final String comment;
  final String time;
  final String? mentionName;
  const CommentItem({
    super.key,
    required this.avatarUrl,
    required this.name,
    required this.comment,
    required this.time,
    this.mentionName,
  });

  @override
  Widget build(BuildContext context) {
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
