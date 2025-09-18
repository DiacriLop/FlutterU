import 'package:go_router/go_router.dart';
import 'package:taller1/views/catalogo/catalogo_screen.dart';
import 'package:taller1/views/ciclo_vida/ciclo_vida_screen.dart';
import 'package:taller1/views/perfil/perfil_screen.dart';
import 'package:taller1/views/perfil/perfil_detalle_screen.dart';
import '../views/home/home_screen.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    // Home
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ),

    // Perfil principal
    GoRoute(
      path: '/perfil',
      name: 'perfil',
      builder: (context, state) => const PerfilScreen(),
    ),

    // Perfil Detalle con parámetros
    GoRoute(
      path: '/perfil-detalle/:nombre/:correo/:metodo',
      name: 'perfilDetalle',
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

    // Ciclo de vida
    GoRoute(
      path: '/ciclo-vida', // ruta oficial
      name: 'cicloVida',
      builder: (context, state) => const CicloVidaScreen(),
    ),

    // Alias para evitar errores con guion bajo
    GoRoute(
      path: '/ciclo_vida',
      redirect: (context, state) => '/ciclo-vida',
    ),
  ],
);

