# Reddit Clone — Proyecto Académico (Ingeniería de UI Móvil)

Clon de la interfaz de Reddit construido 100% con widgets nativos de Flutter
(Material 3), sin usar la API real de Reddit ni WebViews. Todos los datos
(posts, comunidades, notificaciones, comentarios, usuarios) son simulados
localmente mediante generadores deterministas en `lib/data/`.

## Cómo ejecutar

```bash
flutter pub get
flutter run
```

Requiere Flutter 3.19+ (Dart >= 3.0), Material 3 habilitado por defecto.

## Estructura

```
lib/
  core/theme/     -> AppColors y ThemeData (Material 3)
  core/utils/     -> Helpers (timeAgo, formatCompactNumber)
  models/         -> Post, Subreddit, NotificationModel, User, Comment
  data/           -> Generadores de datos fake (120 posts, 60 subreddits, 80 notifs)
  services/       -> FakeDataService (capa de datos en memoria, simula backend)
  screens/        -> Home, Communities, Notifications, Profile, PostDetail
  widgets/        -> PostCard, CommunityCard, NotificationTile, AppDrawer, etc.
  main.dart
```

## Mejora de UX implementada

Barra de búsqueda persistente (`SliverPersistentHeader` pinned) en la parte
superior del Feed, que filtra publicaciones en tiempo real por título,
comunidad o autor sin salir de la pantalla ni perder el scroll.
