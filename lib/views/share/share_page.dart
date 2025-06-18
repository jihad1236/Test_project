import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';

void showSharePopup(
  BuildContext context, {
  required String shareUrl,
  String message = 'Check this out!',
}) {
  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Could not launch URL')));
    }
  }

  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder:
        (context) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Share Via',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _ShareIcon(
                    icon: Iconsax.watch_status,
                    color: Colors.green,
                    label: 'WhatsApp',
                    onTap: () {
                      final url =
                          'https://wa.me/?text=${Uri.encodeComponent('$message $shareUrl')}';
                      Navigator.pop(context);
                      _launchURL(url);
                    },
                  ),
                  _ShareIcon(
                    icon: Iconsax.sms,
                    color: Colors.redAccent,
                    label: 'Email',
                    onTap: () {
                      final subject = Uri.encodeComponent('Interesting Link');
                      final body = Uri.encodeComponent('$message\n\n$shareUrl');
                      final emailUrl = 'mailto:?subject=$subject&body=$body';
                      Navigator.pop(context);
                      _launchURL(emailUrl);
                    },
                  ),
                  _ShareIcon(
                    icon: Iconsax.link,
                    color: Colors.blue.shade800,
                    label: 'LinkedIn',
                    onTap: () {
                      final url =
                          'https://www.linkedin.com/sharing/share-offsite/?url=${Uri.encodeComponent(shareUrl)}';
                      Navigator.pop(context);
                      _launchURL(url);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
  );
}

class _ShareIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final VoidCallback onTap;

  const _ShareIcon({
    required this.icon,
    required this.color,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.1),
            child: Icon(icon, color: color),
          ),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
