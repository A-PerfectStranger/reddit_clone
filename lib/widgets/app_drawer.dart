import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';

/// Drawer lateral de la aplicación con las secciones de perfil,
/// historial, guardados, configuración y cierre de sesión.
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _DrawerHeader(),
            const Divider(height: 1),
            _DrawerItem(icon: Icons.person_outline, label: 'Perfil', onTap: () => Navigator.pop(context)),
            _DrawerItem(icon: Icons.history, label: 'Historial', onTap: () => Navigator.pop(context)),
            _DrawerItem(icon: Icons.bookmark_border, label: 'Guardados', onTap: () => Navigator.pop(context)),
            _DrawerItem(icon: Icons.settings_outlined, label: 'Configuración', onTap: () => Navigator.pop(context)),
            _DrawerItem(icon: Icons.info_outline, label: 'Acerca de', onTap: () => Navigator.pop(context)),
            const Spacer(),
            const Divider(height: 1),
            _DrawerItem(
              icon: Icons.logout,
              label: 'Cerrar sesión',
              iconColor: Colors.redAccent,
              textColor: Colors.redAccent,
              onTap: () => Navigator.pop(context),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 26,
            backgroundColor: AppColors.redditOrange,
            child: Text(
              'U',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('u/estudiante_ui', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              SizedBox(height: 2),
              Text('1.2k karma', style: TextStyle(color: AppColors.textSecondaryLight, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color? textColor;

  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.iconColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: iconColor ?? AppColors.textPrimaryLight),
      title: Text(label, style: TextStyle(color: textColor ?? AppColors.textPrimaryLight)),
      onTap: onTap,
    );
  }
}
