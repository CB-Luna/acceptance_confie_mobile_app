import 'package:flutter/material.dart';
import 'package:freeway_app/widgets/theme/app_theme.dart';

class ProfileDivider extends StatelessWidget {
  const ProfileDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(
        AppTheme.getDetailsGreyColor(context),
        BlendMode.modulate,
      ),
      child: Divider(
        color: AppTheme.getDetailsGreyColor(context),
        thickness: 0.5,
      ),
    );
  }
}
