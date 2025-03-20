import 'package:flutter/material.dart';

class ProfileAvatarName extends StatelessWidget {
  final String userName;
  final bool showName;
  final String? userAvatar; // URL del avatar del usuario

  const ProfileAvatarName({
    required this.userName, 
    super.key,
    this.showName = true,
    this.userAvatar,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Avatar
        Container(
          width: 100,
          height: 100,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color(0x14000000), // 0.08 opacity en hexadecimal
                spreadRadius: 1,
                blurRadius: 10,
                offset: Offset(0, 3),
              ),
              BoxShadow(
                color: Color(0x0D000000), // 0.05 opacity en hexadecimal
                spreadRadius: 2,
                blurRadius: 15,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: ClipOval(
            child: userAvatar != null
                ? Image.network(
                    userAvatar!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      // Si hay un error al cargar la imagen, mostrar la imagen por defecto
                      return Image.asset(
                        'assets/home/icons/human_avatar.png',
                        fit: BoxFit.cover,
                      );
                    },
                  )
                : Image.asset(
                    'assets/home/icons/human_avatar.png',
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        // Nombre (opcional)
        if (showName) ...[
          const SizedBox(height: 16),
          Text(
            userName,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0046B9),
            ),
          ),
        ],
      ],
    );
  }
}
