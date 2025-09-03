import 'package:acceptance_app/pages/home_page.dart';
import 'package:acceptance_app/utils/app_localizations_extension.dart';
import 'package:acceptance_app/widgets/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: AppTheme.getBackgroundHeaderColor(context),
      title: Text(
        context.translate('profile.title'),
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: AppTheme.white,
        ),
      ),
      leadingWidth: 160,
      automaticallyImplyLeading: false,
      leading: InkWell(
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          );
        },
        child: Row(
          children: [
            const SizedBox(width: 8),
            const Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: AppTheme.white,
            ),
            Text(
              context.translate('profile.back'),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppTheme.white,
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
