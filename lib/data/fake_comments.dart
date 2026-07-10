import 'dart:math';
import '../models/comment.dart';
import '../models/post.dart';
import '../models/user.dart';

/// Genera comentarios simulados para un post específico.
List<Comment> generateFakeCommentsForPost({
  required Post post,
  required List<AppUser> users,
  int? count,
  int seed = 5,
}) {
  final random = Random(seed + post.id.hashCode);
  final total = count ?? random.nextInt(8) + 1;

  const commentTemplates = [
    'Totalmente de acuerdo, yo pasé por algo similar.',
    'No estoy tan seguro de esto, ¿tienes alguna fuente?',
    'Jajaja esto me pasó exactamente igual la semana pasada.',
    'Gracias por compartir, me sirvió muchísimo.',
    '¿Podrías dar más detalles sobre el segundo punto?',
    'Interesante perspectiva, no lo había pensado así.',
    'Esto debería estar fijado en la comunidad.',
    'Yo lo intenté y no me funcionó igual, raro.',
    'Buen post, directo al grano.',
    'Comentario controversial pero tienes razón.',
  ];

  return List.generate(total, (index) {
    final user = users[random.nextInt(users.length)];
    return Comment(
      id: '${post.id}_comment_$index',
      postId: post.id,
      authorUsername: user.username,
      authorAvatarColorSeed: user.avatarColorSeed,
      text: commentTemplates[random.nextInt(commentTemplates.length)],
      createdAt: post.createdAt.add(Duration(minutes: random.nextInt(6000))),
      upvotes: random.nextInt(500),
    );
  });
}
