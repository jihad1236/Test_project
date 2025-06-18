import 'package:flutter/material.dart';

class upload_box extends StatelessWidget {
  const upload_box({super.key, required this.isSmall});

  final bool isSmall;

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.symmetric(horizontal: isSmall ? 20 : 80, vertical: 49),
    decoration: BoxDecoration(
      color: const Color(0xFFF8F8FF),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: const Color.fromRGBO(56, 78, 183, 0.3)),
    ),
    child: Column(
      children: const [
        Icon(Icons.cloud_upload_outlined, size: 48, color: Colors.grey),
        SizedBox(height: 9),
        Text.rich(
          TextSpan(
            text: 'Drop your image here or ',
            style: TextStyle(fontWeight: FontWeight.w700),
            children: [
              TextSpan(
                text: 'Browse',
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
