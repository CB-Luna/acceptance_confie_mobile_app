import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: const Color(0xFF0047BB),
      foregroundColor: Colors.white,
      title: const Text(
        'Profile',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      leadingWidth: 100,
      automaticallyImplyLeading: false,
      leading: InkWell(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: const Row(
          children: [
            SizedBox(width: 8),
            Icon(Icons.arrow_back_ios, size: 20),
            Text(
              'Back',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      expandedHeight: 100,
      pinned: true,
      floating: false,
    );
  }
}
