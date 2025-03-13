import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../widgets/profileactions/profile_avatar_name.dart';
import '../widgets/profileactions/profile_header.dart';
import '../widgets/profileactions/profile_settings_list.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).currentUser;

    return Scaffold(
      backgroundColor: const Color(0xFF0047BB),
      body: CustomScrollView(
        physics: const NeverScrollableScrollPhysics(),
        slivers: [
          const ProfileHeader(),
          SliverToBoxAdapter(
            child: Stack(
              children: [
                Column(
                  children: [
                    const SizedBox(height: 40),
                    Container(
                      height: MediaQuery.of(context).size.height -
                          100, // Altura fija considerando el header y margen superior
                      decoration: const BoxDecoration(
                        color: Color(0xFFF5FCFF),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 80),
                          Text(
                            user != null ? user.fullName : 'User',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0046B9),
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Expanded(
                            child: ProfileSettingsList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: ProfileAvatarName(
                    userName: user != null ? user.fullName : 'User',
                    showName: false,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
