import 'package:go_router/go_router.dart';
import 'package:taller1/views/catalogo/catalogo_screen.dart';
import 'package:taller1/views/ciclo_vida/ciclo_vida_screen.dart';
import 'package:taller1/views/perfil/perfil_screen.dart';
import 'package:taller1/views/perfil/perfil_detalle_screen.dart';
import '../views/home/home_screen.dart';

// Importa las nuevas pantallas:
import '../screens/future_screen.dart';
import '../screens/timer_screen.dart';
import '../screens/isolate_screen.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/perfil',
      name: 'perfil',
      builder: (context, state) => const PerfilScreen(),
    ),
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
    GoRoute(
      path: '/catalogo',
      name: 'catalogo',
      builder: (context, state) => const CatalogoScreen(),
    ),
    GoRoute(
      path: '/ciclo-vida',
      name: 'cicloVida',
      builder: (context, state) => const CicloVidaScreen(),
    ),
    GoRoute(
      path: '/ciclo_vida',
      redirect: (context, state) => '/ciclo-vida',
    ),
    GoRoute(
      path: '/future',
      name: 'future',
      builder: (context, state) => const FutureScreen(),
    ),
    GoRoute(
      path: '/timer',
      name: 'timer',
      builder: (context, state) => const TimerScreen(),
    ),
    GoRoute(
      path: '/isolate',
      name: 'isolate',
      builder: (context, state) => const IsolateScreen(),
    ),
  ],
);

