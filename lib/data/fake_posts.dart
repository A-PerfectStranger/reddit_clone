import 'dart:math';
import '../models/post.dart';
import '../models/subreddit.dart';
import '../models/user.dart';

/// Genera 120 posts simulados distribuidos entre las comunidades y
/// usuarios generados previamente, con títulos y cuerpos variados para
/// que el feed se sienta heterogéneo (texto, con imagen, preguntas, etc.)
List<Post> generateFakePosts({
  required List<Subreddit> subreddits,
  required List<AppUser> users,
  int count = 120,
  int seed = 23,
}) {
  final random = Random(seed);

  const titleTemplates = [
    '¿Cuál es su opinión sobre las últimas novedades del sector?',
    'Después de 3 años, por fin terminé mi proyecto personal',
    'Guía completa para principiantes: todo lo que necesitas saber',
    'Encontré este pequeño truco y me cambió la vida',
    'Debate: ¿realmente vale la pena en 2026?',
    'Comparto mi experiencia después de un año usando esto',
    'Pregunta seria, no me juzguen por favor',
    '¿Alguien más ha notado este comportamiento extraño?',
    'Mis resultados después de aplicar estos consejos',
    'Lista de recursos gratuitos que todos deberían conocer',
    'Hoy aprendí algo que quiero compartir con ustedes',
    'Análisis detallado: pros y contras de esta alternativa',
    'Necesito consejos de la comunidad, estoy atascado',
    'Este es el mejor descubrimiento que he hecho este mes',
    'Comparación honesta después de probar ambas opciones',
    'Reflexión: ¿hacia dónde va esto en los próximos años?',
    'Compartiendo mi configuración/setup por si le sirve a alguien',
    'Actualización sobre el tema que discutimos la semana pasada',
    'Pequeña victoria que quería compartir con la comunidad',
    'Errores comunes que cometí y cómo los solucioné',
  ];

  const bodyTemplates = [
    'Llevo un tiempo trabajando en esto y quería compartir mis conclusiones con la comunidad. Cualquier feedback es bienvenido.',
    'No tengo mucho contexto adicional, pero me pareció interesante para debatir entre todos.',
    'Después de investigar bastante, esto es lo que encontré. Espero que le sirva a alguien más.',
    'Sé que es un tema recurrente, pero quería aportar mi granito de arena con esta experiencia.',
    'Intenté varias alternativas antes de llegar a esta conclusión, así que la comparto por si ayuda.',
    null,
    null,
  ];

  return List.generate(count, (index) {
    final subreddit = subreddits[random.nextInt(subreddits.length)];
    final user = users[random.nextInt(users.length)];
    final hasImage = random.nextDouble() < 0.4;
    final upvotes = random.nextInt(45000) + 1;
    final downvotes = (upvotes * random.nextDouble() * 0.15).round();
    final body = bodyTemplates[random.nextInt(bodyTemplates.length)];

    return Post(
      id: 'post_$index',
      subredditId: subreddit.id,
      subredditName: subreddit.name,
      authorUsername: user.username,
      authorAvatarColorSeed: user.avatarColorSeed,
      createdAt: DateTime.now().subtract(
        Duration(
          minutes: random.nextInt(60 * 24 * 10),
        ),
      ),
      title: titleTemplates[random.nextInt(titleTemplates.length)],
      body: body,
      hasImage: hasImage,
      imageColorSeed: random.nextInt(12),
      upvotes: upvotes,
      downvotes: downvotes,
      commentCount: random.nextInt(3000),
      shareCount: random.nextInt(500),
    );
  });
}
