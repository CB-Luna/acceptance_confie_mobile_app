import 'package:flutter/material.dart';

class ProfileDivider extends StatelessWidget {
  const ProfileDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const ColorFiltered(
      colorFilter: ColorFilter.mode(
        Colors.grey,
        BlendMode.modulate,
      ),
      child: Divider(
        color: Colors.grey,
        thickness: 0.5,
      ),
    );
  }
}
