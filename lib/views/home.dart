import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:test_project/consts/app_colors.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
              _buildReviewCard(),
              const SizedBox(height: 30),
              _buildReviewCard(),
            ],
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

  Widget _buildReviewCard() => Container(
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
          children: const [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _Badge(text: 'LHR - DEL'),
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
      ],
    ),
  );
}

class _Badge extends StatelessWidget {
  final String text;
  const _Badge({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      ),
    );
  }
}
