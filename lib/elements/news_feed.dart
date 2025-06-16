import 'package:flutter/material.dart';
import 'package:test_project/consts/app_colors.dart';
import 'package:test_project/model/post_model.dart';

class NewsFeedCard extends StatelessWidget {
  final PostModel post;
  NewsFeedCard({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              const Text('5.0', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _Badge(text: post.airline),
                  _Badge(text: 'Air India'),
                  _Badge(text: 'Business Class'),
                  _Badge(text: 'July 2023'),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Stay tuned for a smoother, more convenient experience right at your fingertips , a smoother, more convenient  a smoother, more convenient other, more convenient experience right at your',
            style: TextStyle(fontSize: 14, height: 1.4),
          ),
          const SizedBox(height: 4),
          const Text(
            'See More',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              'assets/images/demo_image.jpg',
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
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
          // COMMENT CARD
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 16,
                          backgroundImage: NetworkImage(
                            'https://cdn.builder.io/api/v1/image/assets/TEMP/99612dc755ce3c259d6298a7d9c92c03a824ce2e?apiKey=e4ec6974213f4eed99937f80a28e2030',
                          ),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Darron Levesque',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              '3 min ago',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Text(
                      '5 Upvotes',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis',
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 12),
                const Row(
                  children: [
                    Icon(Icons.arrow_upward, color: AppColors.primary),
                    SizedBox(width: 6),
                    Text('Upvote'),
                    SizedBox(width: 24),
                    Icon(
                      Icons.question_answer_outlined,
                      color: AppColors.primary,
                    ),
                    SizedBox(width: 6),
                    Text('Reply'),
                  ],
                ),
              ],
            ),
          ),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Write Your Comment',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      Icon(Icons.send_rounded, color: AppColors.primary),
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
