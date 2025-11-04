import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taller1/services/auth_service.dart';
import 'package:taller1/views/catalogo/catalogo_screen.dart';
import 'package:taller1/views/ciclo_vida/ciclo_vida_screen.dart';
import 'package:taller1/views/perfil/perfil_screen.dart';
import 'package:taller1/views/perfil/perfil_detalle_screen.dart';
import '../views/home/home_screen.dart';

// Importa las nuevas pantallas:
import '../screens/future_screen.dart';
import '../screens/timer_screen.dart';
import '../screens/isolate_screen.dart';
import 'package:taller1/views/dog/dog_list_screen.dart';
import 'package:taller1/views/dog/dog_detail_screen.dart';
import '../screens/login_screen.dart';
import '../screens/register_screen.dart';
import '../views/categorias_fb/categoria_fb_list_view.dart';
import '../views/categorias_fb/categoria_fb_form_view.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/login',
  redirect: (context, state) async {
    final authService = AuthService();
    final isLogged = await authService.isLoggedIn();

    final path = state.uri.path;
    final loggingIn = path == '/login' || path == '/register';

    if (!isLogged && !loggingIn) {
      return '/login';
    }

    if (isLogged && loggingIn) {
      return '/';
    }

    return null;
  },
  routes: [
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      name: 'register',
      builder: (context, state) => const RegisterScreen(),
    ),
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
    GoRoute(
      path: '/dogs',
      name: 'dogs',
      builder: (context, state) => const DogListScreen(),
    ),
    //! Rutas para el manejo de Categorías (CRUD)
    GoRoute(
      path: '/categoriasFirebase',
      name: 'categoriasFirebase',
      builder: (context, state) => const CategoriaFbListView(),
    ),
    GoRoute(
      path: '/categoriasfb/create',
      name: 'categoriasfb.create',
      builder: (context, state) => const CategoriaFbFormView(),
    ),
    GoRoute(
      path: '/categoriasfb/edit/:id',
      name: 'categoriasfb.edit',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return CategoriaFbFormView(id: id);
      },
    ),
    GoRoute(
      path: '/dog/:breed',
      name: 'dogDetail',
      builder: (context, state) {
        final breed = state.pathParameters['breed']!;
        final imageUrl = state.uri.queryParameters['imageUrl']!;
        return DogDetailScreen(
          breed: breed,
          imageUrl: imageUrl,
        );
      },
    ),
  ],
);

