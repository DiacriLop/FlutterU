import 'package:go_router/go_router.dart';
import 'package:taller1/views/catalogo/catalogo_screen.dart';
import 'package:taller1/views/ciclo_vida/ciclo_vida_screen.dart';
import 'package:taller1/views/perfil/perfil_screen.dart';
import 'package:taller1/views/perfil/perfil_detalle_screen.dart';
import '../views/home/home_screen.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),

    // Perfil principal
    GoRoute(
      path: '/perfil',
      builder: (context, state) => const PerfilScreen(),
    ),

    // Perfil Detalle (con parámetros en path)
    GoRoute(
      path: '/perfil-detalle/:nombre/:correo/:metodo',
      builder: (context, state) {
        final nombre = state.pathParameters['nombre']!;
        final correo = state.pathParameters['correo']!;
        final metodo = state.pathParameters['metodo']!;
        return PerfilDetalleScreen(
          nombre: nombre,
          correo: correo,
          metodo: metodo,
        );
      },
    ),

    // Catálogo
    GoRoute(
      path: '/catalogo',
      name: 'catalogo',
      builder: (context, state) => const CatalogoScreen(),
    ),
    // 🚀 Ciclo de vida
    GoRoute(
      path: '/ciclo-vida', // <-- corregido, ahora es /ciclo-vida
      builder: (context, state) => const CicloVidaScreen(),
    ),
  ],
);
