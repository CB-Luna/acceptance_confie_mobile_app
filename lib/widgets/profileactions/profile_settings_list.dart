import 'package:flutter/material.dart';

import 'profile_divider.dart';
import 'profile_logout.dart';
import 'profile_settings_item.dart';
import 'profile_settings_switch.dart';

class ProfileSettingsList extends StatelessWidget {
  const ProfileSettingsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFF5FCFF),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 3),
            blurRadius: 8,
            spreadRadius: -1,
            color: Color(0x0D323247),
          ),
          BoxShadow(
            offset: Offset(0, 0),
            blurRadius: 1,
            spreadRadius: 0,
            color: Color(0x3D0C1A4B),
          ),
        ],
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height -
              150, // Altura fija considerando el header
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            ProfileSettingsItem(
              title: 'Password',
              icon: Icons.lock_outline,
              onTap: () {
                // TODO: Implementar navegación
              },
            ),
            const ProfileDivider(),
            ProfileSettingsItem(
              title: 'Touch ID',
              icon: Icons.fingerprint,
              onTap: () {
                // TODO: Implementar navegación
              },
            ),
            const ProfileDivider(),
            ProfileSettingsItem(
              title: 'Languages',
              icon: Icons.language,
              onTap: () {
                // TODO: Implementar navegación
              },
            ),
            const ProfileDivider(),
            ProfileSettingsItem(
              title: 'App information',
              icon: Icons.info_outline,
              onTap: () {
                // TODO: Implementar navegación
              },
            ),
            const ProfileDivider(),
            ProfileSettingsSwitch(
              title: 'Enable push notifications',
              icon: Icons.notifications_none,
              value: true,
              onChanged: (value) {
                // TODO: Implementar cambio de notificaciones
              },
            ),
            const ProfileDivider(),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: ProfileLogoutButton(),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
