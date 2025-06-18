import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class BannerCarousel extends StatelessWidget {
  const BannerCarousel({super.key});

  final List<String> imageUrls = const [
    "assets/images/image1.webp",
    "assets/images/image2.jpg",
    "assets/images/image3.webp",
  ];

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: CarouselSlider(
        options: CarouselOptions(
          height: 120,
          viewportFraction: 1.0,
          autoPlay: true,
        ),
        items:
            imageUrls.map((url) {
              return Image.asset(
                url,
                fit: BoxFit.cover,
                width: double.infinity,
              );
            }).toList(),
      ),
    );
  }
}
