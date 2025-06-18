import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:test_project/consts/app_colors.dart';
import 'package:test_project/controller/post_controller.dart';
import 'package:test_project/model/post_model.dart';

class User_icon extends StatelessWidget {
  final PostModel post;
  const User_icon({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ShareController());
    return Row(
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
              style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
            ),
          ],
        ),
        const Spacer(),

        // const Icon(Icons.star, color: AppColors.star, size: 18),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 4,
                children: List.generate(
                  5,
                  (index) => GestureDetector(
                    onTap: () => controller.updateRating(index + 1),
                    child: Icon(
                      Icons.star,
                      size: 15,
                      color:
                          index < controller.rating.value
                              ? Colors.amber
                              : Colors.grey[300],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(width: 4),
        Text(
          '${post.rating.toStringAsFixed(1)}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
