# ANALISIS.md — Reddit Clone (Taller de Desarrollo de Aplicaciones Móviles)

## 1. Mercado objetivo

| Variable | Descripción |
|---|---|
| **Edad** | Principalmente 18–34 años (Gen Z y millennials jóvenes), con un núcleo muy activo en el rango 18–24. |
| **Intereses** | Cultura de internet, nicho de comunidades temáticas (tecnología, gaming, humor, noticias, hobbies muy específicos), anonimato y discusión en foros. |
| **Nivel socioeconómico** | Transversal, con mayor concentración en usuarios urbanos con acceso constante a internet móvil; perfil típico de estudiantes y profesionales jóvenes. |
| **Tipo de usuario** | Mezcla de "lurkers" (consumen sin publicar, la mayoría) y usuarios activos que comentan, votan y publican. La app debe optimizarse para consumo rápido en scroll (feed) más que para creación de contenido. |

## 2. Psicología del color

Reddit construye su identidad visual sobre una paleta muy acotada: **naranja (#FF4500)**, **blanco**, **negro** y **grises neutros**. Esta elección no es arbitraria:

- **Naranja (#FF4500) — energía y urgencia**: el naranja es un color cálido que combina la energía del rojo con la accesibilidad del amarillo. Psicológicamente se asocia con entusiasmo, acción y comunidad informal (no es tan agresivo como el rojo puro). Reddit lo reserva para elementos interactivos clave: el logo, el botón de upvote activo, el botón "Join" y los CTAs principales. Al ser el único color saturado en la interfaz, cualquier elemento naranja capta la atención de inmediato (contraste de saturación).
- **Blanco y negro — legibilidad y neutralidad**: el contenido de Reddit es mayoritariamente texto generado por usuarios. Un fondo blanco (modo claro) o negro casi puro (modo oscuro, #030303) maximiza el contraste y minimiza la fatiga visual en sesiones de lectura largas, sin competir visualmente con el naranja de marca.
- **Grises — jerarquía sin ruido**: los grises (bordes, texto secundario, chips de acciones) permiten crear jerarquía visual (separar metadatos de contenido principal) sin introducir más colores que distraigan del naranja como único acento.
- **Contraste como sistema, no como decoración**: al limitar la paleta a 3–4 colores, cada uso del naranja funciona como una señal semántica ("esto es interactivo" o "esto está activo"), lo que reduce la carga cognitiva del usuario al navegar cientos de publicaciones por sesión.

En el clon, esta lógica se replicó en `lib/core/theme/app_colors.dart` y `app_theme.dart`: el naranja se usa exclusivamente para upvotes activos, el botón "Join", el FAB de crear post y acentos de marca; el resto de la interfaz se mantiene en escala de grises para no competir con esas señales.

## 3. Auditoría de componentes: las tres listas principales

| Lista | Contenido por ítem | Por qué es una lista "pesada" |
|---|---|---|
| **Feed** | Avatar, texto variable, imagen opcional, contadores, 4 acciones | Puede crecer indefinidamente (scroll infinito) y mezcla texto e imágenes |
| **Chats** | Avatar, último mensaje, hora, badge de no leídos | Lista corta pero con actualizaciones frecuentes de estado (leído/no leído) |
| **Comunidades** | Icono, nombre, contador de miembros, botón de acción | Lista densa, mayormente texto, con un botón interactivo por fila |

### ¿Por qué usar listas virtualizadas?

Reddit —y este clon— usan **`ListView.builder`** (y `SliverList` dentro de `CustomScrollView`) en lugar de construir todos los widgets de una vez (`ListView(children: [...])`). La virtualización construye únicamente los ítems visibles en pantalla (más un pequeño margen definido por `cacheExtent`), y los destruye cuando salen del viewport. Esto es crítico porque:

1. **Memoria constante**: con 80 publicaciones o más, renderizar todo de una vez multiplicaría el uso de memoria sin necesidad, ya que el usuario solo ve 3–5 ítems a la vez.
2. **Rendimiento de scroll**: reconstruir solo lo visible evita jank (caídas de frames) durante el scroll rápido, manteniendo 60/120 fps.
3. **Escalabilidad**: el mismo patrón funciona igual de bien con 80 o con 80,000 publicaciones, ya que el costo es proporcional a lo que se muestra, no al total de datos.

## 4. Mejora propuesta: barra de búsqueda persistente con filtro en tiempo real

**Qué es**: a diferencia de la app oficial de Reddit —donde la búsqueda vive en un `AppBar` que puede desplazarse fuera de vista al hacer scroll—, este clon implementa la búsqueda como un `SliverPersistentHeader` con `pinned: true`, ubicado justo debajo del AppBar principal (que sí puede ocultarse con `floating/snap`). El campo de texto filtra el feed en tiempo real contra título, comunidad y autor.

**Justificación técnica y de UX**:

- **Reducción de fricción**: el usuario no necesita hacer scroll hacia arriba ni tocar un ícono de lupa para iniciar una búsqueda; el campo siempre está a un toque de distancia mientras navega el feed.
- **Costo de implementación bajo, beneficio alto**: al usar `SliverPersistentHeaderDelegate` con `minExtent == maxExtent`, el header no requiere lógica de colapso compleja y se integra de forma nativa con el resto de los slivers del `CustomScrollView`, sin necesidad de paquetes externos.
- **Filtrado reactivo sin llamadas de red**: como los datos son simulados y están en memoria (`FeedProvider`), el filtro se aplica de forma instantánea sobre la lista ya cargada, usando `notifyListeners()` de Provider; no hay debounce necesario porque no hay latencia de red que mitigar.
- **Descubribilidad**: estudios de UX sobre patrones de búsqueda "sticky" muestran que la visibilidad constante de un campo de búsqueda aumenta su tasa de uso frente a búsquedas ocultas detrás de un ícono, especialmente en apps de consumo de contenido tipo feed.

---
*Documento generado como parte de la entrega del taller. Todos los datos de usuarios, publicaciones y estadísticas son simulados (mock data) y no representan información real de Reddit.*
