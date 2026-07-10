import 'dart:math';
import '../models/subreddit.dart';

/// Genera 60 comunidades simuladas cubriendo temáticas variadas
/// (tecnología, gaming, ciencia, hobbies, etc.) para que el listado de
/// comunidades se sienta realista y diverso.
List<Subreddit> generateFakeSubreddits({int count = 60, int seed = 11}) {
  final random = Random(seed);

  const topics = [
    'flutterdev',
    'programming',
    'webdev',
    'MachineLearning',
    'gamedev',
    'linux',
    'androiddev',
    'iOSProgramming',
    'reactjs',
    'python',
    'technology',
    'gadgets',
    'DataIsBeautiful',
    'artificial',
    'cybersecurity',
    'opensource',
    'rust',
    'golang',
    'javascript',
    'compsci',
    'gaming',
    'pcgaming',
    'NintendoSwitch',
    'PS5',
    'xbox',
    'boardgames',
    'chess',
    'leagueoflegends',
    'valorant',
    'Minecraft',
    'science',
    'space',
    'askscience',
    'Physics',
    'biology',
    'astrophysics',
    'chemistry',
    'geology',
    'Astronomy',
    'math',
    'movies',
    'television',
    'music',
    'books',
    'anime',
    'photography',
    'art',
    'writing',
    'filmmakers',
    'podcasts',
    'food',
    'cooking',
    'coffee',
    'baking',
    'veganrecipes',
    'travel',
    'fitness',
    'running',
    'hiking',
    'personalfinance',
  ];

  const descriptions = [
    'Discusiones, noticias y recursos de la comunidad.',
    'Comparte tus proyectos y recibe retroalimentación honesta.',
    'El lugar para preguntas de principiantes y expertos por igual.',
    'Noticias diarias curadas por la comunidad.',
    'Tutoriales, memes y debates sobre el tema.',
    'Un espacio abierto para mostrar tu trabajo.',
    'Preguntas frecuentes, guías y mucho más.',
    'Todo lo relacionado con el tema, sin spam.',
    'Comunidad activa con moderación estricta y contenido de calidad.',
    'Recursos, noticias y charlas informales sobre el tema.',
  ];

  return List.generate(count, (index) {
    final topic = topics[index % topics.length];
    final suffix = index >= topics.length ? (index ~/ topics.length) : null;
    final name = suffix == null ? 'r/$topic' : 'r/$topic$suffix';
    return Subreddit(
      id: 'sub_$index',
      name: name,
      description: descriptions[random.nextInt(descriptions.length)],
      memberCount: random.nextInt(2500000) + 500,
      iconColorSeed: random.nextInt(12),
      isJoined: random.nextBool() && random.nextBool(),
    );
  });
}
