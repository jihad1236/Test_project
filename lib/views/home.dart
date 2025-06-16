import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:test_project/consts/app_colors.dart';
import 'package:test_project/elements/news_feed.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildHeader(),
                const SizedBox(height: 30),
                _buildActionButtons(),
                const SizedBox(height: 30),
                _buildBanner(),
                const SizedBox(height: 30),
                NewsFeedCard(),
                const SizedBox(height: 30),
                NewsFeedCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const Text(
        'Airline Review',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      Row(
        children: [
          Stack(
            children: [
              const Icon(Iconsax.notification, size: 24),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Text(
                    '2',
                    style: TextStyle(
                      color: AppColors.background,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          const CircleAvatar(
            radius: 18,
            backgroundImage: NetworkImage(
              'https://cdn.builder.io/api/v1/image/assets/TEMP/04db04b61b979a0b730747291978b6fed38d21ca?apiKey=e4ec6974213f4eed99937f80a28e2030',
            ),
          ),
          const SizedBox(width: 16),
          const Icon(Iconsax.menu_1, size: 24),
        ],
      ),
    ],
  );

  Widget _buildActionButtons() => Column(
    children: [
      LayoutBuilder(
        builder: (context, constraints) {
          final isSmall = constraints.maxWidth < 400;
          return Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: [
              SizedBox(
                width:
                    isSmall
                        ? constraints.maxWidth
                        : (constraints.maxWidth - 12) / 2,
                child: _button(
                  text: 'Share Your Experience',
                  icon: Iconsax.people,
                  fullWidth: true,
                ),
              ),
              SizedBox(
                width:
                    isSmall
                        ? constraints.maxWidth
                        : (constraints.maxWidth - 12) / 2,
                child: _button(
                  text: 'Ask A Question',
                  icon: Iconsax.profile_2user,
                  fullWidth: true,
                ),
              ),
            ],
          );
        },
      ),
      const SizedBox(height: 16),
      _button(text: 'Search', icon: Iconsax.search_normal, fullWidth: true),
    ],
  );

  Widget _button({
    required String text,
    required IconData icon,
    bool fullWidth = false,
  }) => Container(
    height: 55,
    width: fullWidth ? double.infinity : null,
    decoration: BoxDecoration(
      color: AppColors.primary,
      borderRadius: BorderRadius.circular(18),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: const TextStyle(
            color: AppColors.background,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        const SizedBox(width: 10),
        Icon(icon, color: AppColors.background, size: 20),
      ],
    ),
  );

  Widget _buildBanner() => ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: Image.network(
      'https://cdn.builder.io/api/v1/image/assets/TEMP/ff067bcb39fee40b73b34de6bb576e78066e75a2?apiKey=e4ec6974213f4eed99937f80a28e2030',
      height: 120,
      fit: BoxFit.cover,
    ),
  );
}
