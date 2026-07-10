import 'dart:math';
import '../models/user.dart';

/// Genera una lista determinista de usuarios simulados.
///
/// Se combina una lista base de nombres con sufijos numéricos para
/// alcanzar la cantidad solicitada sin repetir literalmente el mismo
/// username, similar a los patrones reales de usuarios de Reddit.
List<AppUser> generateFakeUsers({int count = 40, int seed = 7}) {
  final random = Random(seed);
  const baseNames = [
    'shadow_walker',
    'pixel_queen',
    'nova_byte',
    'quiet_storm',
    'moss_hunter',
    'lunar_fox',
    'ctrl_alt_dev',
    'sunday_coder',
    'echo_wanderer',
    'blue_kestrel',
    'rusty_anchor',
    'velvet_thorn',
    'gravity_wave',
    'paper_lantern',
    'north_ridge',
    'copper_owl',
    'dusty_trail',
    'neon_marsh',
    'frost_bitten',
    'wild_maple',
    'iron_petal',
    'salty_biscuit',
    'drift_king',
    'amber_glass',
    'static_noise',
    'winter_ash',
    'cobalt_reef',
    'plain_toast',
    'silent_hail',
    'maple_syrup_fan',
  ];

  return List.generate(count, (index) {
    final base = baseNames[index % baseNames.length];
    final suffix = index >= baseNames.length ? (random.nextInt(999) + 1) : null;
    final username = suffix == null ? base : '${base}_$suffix';
    return AppUser(
      id: 'user_$index',
      username: username,
      avatarColorSeed: random.nextInt(12),
      karma: random.nextInt(150000) + 100,
      joinDate:
          DateTime.now().subtract(Duration(days: random.nextInt(2500) + 30)),
    );
  });
}
