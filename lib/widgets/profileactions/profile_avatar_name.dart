import 'package:acceptance_app/utils/responsive_font_sizes.dart';
import 'package:acceptance_app/widgets/theme/app_theme.dart';
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

  // Método para construir un avatar con las iniciales del usuario
  Widget _buildInitialsAvatar(
    String fullName, {
    required double size,
    required BuildContext context,
  }) {
    // Obtener las iniciales del nombre completo
    final initials = _getInitials(fullName);

    // Generar un color basado en el nombre (para que sea consistente para el mismo usuario)
    final color = _getAvatarColor(fullName);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          initials,
          style: TextStyle(
            color: AppTheme.white,
            fontSize: responsiveFontSizes
                .avatarName(context), // Tamaño proporcional al contenedor
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // Método para obtener las iniciales del nombre
  String _getInitials(String fullName) {
    if (fullName.isEmpty) return 'FW';

    final nameParts = fullName.trim().split(' ');
    if (nameParts.length >= 2) {
      // Si hay al menos dos partes en el nombre, tomar la primera letra de cada una
      return '${nameParts[0][0]}${nameParts[1][0]}'.toUpperCase();
    } else if (nameParts.length == 1 && nameParts[0].isNotEmpty) {
      // Si solo hay una parte, tomar la primera letra
      return nameParts[0][0].toUpperCase();
    }

    return 'FW';
  }

  // Método para generar un color basado en el nombre
  Color _getAvatarColor(String fullName) {
    if (fullName.isEmpty) return Colors.blue;

    // Usar la suma de los códigos ASCII de los caracteres para generar un número
    final int hashCode =
        fullName.codeUnits.fold(0, (prev, element) => prev + element);

    // Lista de colores para los avatares
    final colors = [
      Colors.blue[700]!,
      Colors.red[700]!,
      Colors.green[700]!,
      Colors.orange[700]!,
      Colors.purple[700]!,
      Colors.teal[700]!,
      Colors.pink[700]!,
      Colors.indigo[700]!,
    ];

    // Seleccionar un color basado en el hash del nombre
    return colors[hashCode % colors.length];
  }

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
            color: AppTheme.white,
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
            child: userAvatar != null && userAvatar!.isNotEmpty
                ? Image.network(
                    userAvatar!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      // Si hay un error al cargar la imagen, mostrar las iniciales
                      return _buildInitialsAvatar(
                        userName,
                        size: 100,
                        context: context,
                      );
                    },
                  )
                : _buildInitialsAvatar(userName, size: 100, context: context),
          ),
        ),
        // Nombre (opcional)
        if (showName) ...[
          const SizedBox(height: 16),
          Text(
            userName,
            style: TextStyle(
              fontSize: responsiveFontSizes.titleLarge(context),
              fontWeight: FontWeight.bold,
              color: AppTheme.getPrimaryColor(context),
            ),
          ),
        ],
      ],
    );
  }
}
