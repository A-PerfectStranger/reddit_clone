import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../services/fake_data_service.dart';

/// Pantalla de Perfil: resumen del usuario actual (simulado) con
/// estadísticas básicas de karma y actividad.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final service = FakeDataService.instance;
    final postCount = service.posts.length;
    final joinedCommunities = service.subreddits.where((s) => s.isJoined).length;

    return Scaffold(
      appBar: AppBar(title: const Text('Perfil')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const CircleAvatar(
            radius: 42,
            backgroundColor: AppColors.redditOrange,
            child: Text('U', style: TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 12),
          const Center(
            child: Text('u/estudiante_ui', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 4),
          const Center(
            child: Text('Cuenta creada para el taller de Ingeniería de UI Móvil', style: TextStyle(color: AppColors.textSecondaryLight)),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _StatItem(label: 'Karma', value: '12.4k'),
              _StatItem(label: 'Posts vistos', value: '$postCount'),
              _StatItem(label: 'Comunidades', value: '$joinedCommunities'),
            ],
          ),
          const SizedBox(height: 24),
          const Divider(),
          ListTile(leading: const Icon(Icons.bookmark_border), title: const Text('Guardados'), onTap: () {}),
          ListTile(leading: const Icon(Icons.history), title: const Text('Historial'), onTap: () {}),
          ListTile(leading: const Icon(Icons.settings_outlined), title: const Text('Configuración'), onTap: () {}),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;

  const _StatItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: AppColors.textSecondaryLight, fontSize: 12)),
      ],
    );
  }
}
