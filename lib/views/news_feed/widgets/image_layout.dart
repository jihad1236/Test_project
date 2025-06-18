import 'package:flutter/material.dart';

class ImageLayout extends StatelessWidget {
  final List<String> images;
  const ImageLayout({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        // Ensure there's at least one image
        if (images.isEmpty) {
          return const SizedBox(); // or show a placeholder
        }

        final firstImage = images.first;
        final remainingImages = images.length > 1 ? images.sublist(1) : [];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 🔹 Large top image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                firstImage,
                height: width * 0.55,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),

            // 🔹 Grid of remaining images
            if (remainingImages.isNotEmpty)
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: remainingImages.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 1.2,
                ),
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      remainingImages[index],
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
          ],
        );
      },
    );
  }
}
