import 'package:flutter/material.dart';
import 'package:freeway_app/widgets/theme/app_theme.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

class SubmitClaimHeader extends StatelessWidget {
  const SubmitClaimHeader({super.key});
  
  // Método para construir un avatar con las iniciales del usuario
  Widget _buildInitialsAvatar(String fullName, {required double size}) {
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
            color: Colors.white,
            fontSize: size * 0.4, // Tamaño proporcional al contenedor
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
  
  // Método para obtener las iniciales del nombre
  String _getInitials(String fullName) {
    if (fullName.isEmpty) return '';
    
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
    final int hashCode = fullName.codeUnits.fold(0, (prev, element) => prev + element);
    
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
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x0A111111),
            offset: Offset(0, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Row(
              children: [
                Icon(
                  Icons.arrow_back_ios,
                  color: Color(0xFF0047BB),
                  size: 20,
                ),
                SizedBox(width: 4),
                Text(
                  'Back',
                  style: TextStyle(
                    color: Color(0xFF0047BB),
                    fontSize: 16,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Image.asset(
            AppTheme.getFreewayLogoType(context),
            height: 40,
          ),
          Row(
            children: [
              const Icon(
                Icons.notifications_none,
                color: Color(0xFF0047BB),
                size: 24,
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/profile');
                },
                child: Consumer<AuthProvider>(
                  builder: (context, authProvider, child) {
                    final avatar = authProvider.currentUser?.avatar;
                    final fullName = authProvider.currentUser?.fullName ?? 'Freeway User';
                    
                    if (avatar != null && avatar.isNotEmpty) {
                      return CircleAvatar(
                        radius: 16,
                        backgroundImage: NetworkImage(avatar),
                        onBackgroundImageError: (exception, stackTrace) {
                          // Si hay un error al cargar la imagen, se usará el widget de iniciales
                          // pero no podemos retornarlo directamente desde aquí
                        },
                        child: Container(
                          // Este contenedor solo se mostrará si hay un error en la imagen
                          color: Colors.transparent,
                        ),
                      );
                    } else {
                      // Si no hay avatar, mostrar las iniciales
                      return _buildInitialsAvatar(fullName, size: 32);
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
