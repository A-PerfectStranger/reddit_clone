# reddit_clone

Clon visual de **Reddit** desarrollado en **Flutter**, construido como proyecto para la materia de Desarrollo de Aplicaciones Móviles. Replica la interfaz y navegación de la app oficial usando **datos 100% simulados (mock data)** — no hay backend real ni llamadas de red.

## Descripción

La app incluye feed principal con scroll infinito, comunidades, chats, notificaciones, perfil de usuario, pantalla de detalle de publicación con comentarios y pantalla de creación de post, todo con Material Design 3, modo claro/oscuro y microanimaciones nativas de Flutter.

## Arquitectura

Clean Architecture simplificada, organizada por *features*:

```
lib/
  app/                 # Punto de entrada de la app (MaterialApp, providers globales)
  core/
    constants/         # Constantes (cantidad de datos mock, etc.)
    theme/              # Colores y ThemeData (claro/oscuro)
  models/               # Entidades: User, Post, Community, Comment, Chat, Notification
  mock/                 # Generador centralizado de datos simulados
  providers/            # Estado con Provider (feed, comunidades, chats, notificaciones, tema)
  widgets/              # Widgets reutilizables (avatar, imagen placeholder, shimmer, drawer, bottom nav)
  features/
    home/               # Feed principal + barra de búsqueda persistente (mejora propuesta)
    post/               # Detalle de publicación + comentarios
    communities/        # Lista de comunidades
    chat/                # Lista de chats
    profile/            # Perfil, guardados y notificaciones
    create/              # Crear publicación
```

## Cómo ejecutar

1. Tener instalado Flutter estable (`flutter --version`).
2. Instalar dependencias:
   ```bash
   flutter pub get
   ```
3. Ejecutar en un emulador o dispositivo:
   ```bash
   flutter run
   ```

## Dependencias

| Paquete | Uso |
|---|---|
| `provider` | Gestión de estado |
| `intl` | Utilidades de formato (opcional, preparado para fechas) |
| `cupertino_icons` | Íconos base de Flutter |

No se usan WebViews ni paquetes de UI de terceros: todos los componentes visuales (feed, tarjetas, shimmer, avatares) están hechos con widgets nativos de Flutter.

## Características implementadas

- ✅ Feed principal con `ListView.builder` / `SliverList` y scroll infinito paginado
- ✅ Lista de comunidades (40) con botón Join/Joined
- ✅ Lista de chats (30) con indicador de no leídos
- ✅ Lista de notificaciones (25) con tipos e íconos
- ✅ 80 publicaciones simuladas con comentarios anidados
- ✅ Navegación inferior (Home, Communities, Create, Chat, Inbox) + Drawer lateral
- ✅ Pantalla de detalle de post con upvote/downvote/reply/share
- ✅ Pantalla de perfil con karma, posts guardados y tabs
- ✅ Pantalla de creación de post (mock, sin persistencia real)
- ✅ Tema claro y oscuro completos, inspirados en la paleta de Reddit
- ✅ Animaciones: `AnimatedContainer`, `AnimatedSwitcher`, `AnimatedOpacity`, `Hero`, `InkWell` ripple, scale al presionar, shimmer loading, pull-to-refresh
- ✅ Mejora propuesta: barra de búsqueda persistente (`SliverPersistentHeader`) con filtrado en tiempo real sobre el feed
- ✅ `ANALISIS.md` con mercado objetivo, psicología del color y auditoría de componentes

## Cumplimiento de requisitos del taller

| Requisito | Estado |
|---|---|
| Mínimo 3 listas (se implementaron 4: feed, comunidades, chats, notificaciones) | ✅ |
| ≥80 publicaciones, ≥30 chats, ≥40 comunidades, ≥25 notificaciones | ✅ |
| Solo widgets nativos, sin WebView | ✅ |
| Arquitectura limpia y escalable | ✅ |
| Modo claro y oscuro | ✅ |
| Mejora propuesta documentada | ✅ |
| `ANALISIS.md` con psicología del color y mercado objetivo | ✅ |

## Capturas esperadas

Al ejecutar la app deberías ver: feed con posts e imágenes placeholder, barra de búsqueda naranja persistente bajo el AppBar, lista de comunidades con botones Join, lista de chats con badges de no leídos, pantalla de notificaciones, y un perfil con gradiente azul-negro similar al de la app oficial.

---
*Proyecto académico. Todo el contenido (usuarios, publicaciones, imágenes) es ficticio y generado localmente; la app funciona completamente sin conexión.*
