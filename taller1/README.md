# 🧾 Taller 1 – Sistema de Parqueo con JWT

Aplicación Flutter creada para el taller de la electiva, orientada a gestionar el flujo de autenticación con **JSON Web Tokens (JWT)**, presentar un catálogo con múltiples vistas de demostración y preparar la distribución del APK mediante Firebase App Distribution.

---

## 🔧 Tech stack principal

| Componente | Versión | Uso |
|------------|---------|-----|
| Flutter SDK | ^3.9.2 | Framework principal |
| `go_router` | ^16.3.0 | Enrutamiento declarativo y guardas |
| `flutter_secure_storage` | ^9.2.2 | Almacenamiento seguro del token JWT |
| `shared_preferences` | ^2.3.2 | Persistencia de datos no sensibles (nombre, correo, id) |
| `http` | ^1.1.0 | Consumo de la API `https://parking.visiontic.com.co/api` |
| `flutter_lints` | ^6.0.0 | Buenas prácticas y estilo |

---

## 🧭 Flujo funcional

1. **Autenticación**
   - Pantallas de **Login** y **Registro** conectadas a los endpoints del backend.
   - Se guarda el token en `flutter_secure_storage` y los datos básicos en `SharedPreferences`.
2. **Protección de rutas**
   - `GoRouter` gestiona la navegación con `initialLocation: '/login'`.
   - Redirecciona a `/login` cuando no hay sesión y a `/` cuando el usuario ya está autenticado.
3. **Home y vistas de práctica**
   - Catálogo, ciclo de vida, manejo de `Future`, `Timer`, `Isolates` y consumo de API (`DogService`).
4. **Perfil con JWT**
   - Visualiza datos almacenados en `SharedPreferences` y estado del token.
   - Opción de **Cerrar sesión** que limpia la información local.

---

## 📱 Capturas clave

- **Login / Registro**: formularios con validaciones y mensajes de feedback.
- **Drawer**: navegación centralizada con enlaces a todas las vistas y botón de logout.
- **Perfil**: tarjetas con información del usuario y token.

(Agregar capturas en la carpeta `/docs` o adjuntar en el informe del taller).

---

## 🛠️ Configuración y ejecución

```bash
flutter pub get
flutter run
```

Para generar el APK release:

```bash
flutter build apk --release
```

---

## 🚀 Distribución con Firebase App Distribution

1. `firebase login` y `firebase use <alias>` para seleccionar proyecto.
2. `flutter build apk --release`.
3. `firebase appdistribution:distribute build/app/outputs/flutter-apk/app-release.apk --app <app-id> --groups qa --release-notes "Actualización taller JWT"`.
4. Confirmar recepción del build con los testers.
5. Documentar feedback en la tarjeta del taller.

---

## 🧾 Versionado

- `pubspec.yaml`: seguir el formato `<major>.<minor>.<patch>+<build>` (ej. `1.0.2+3`).
- `android/app/build.gradle.kts`: sincroniza `versionCode` y `versionName` automáticamente al compilar.
- Registrar cambios en el README y/o en las notas de release.

---

## 👩‍💻 Equipo y responsabilidades

- **Autenticación y persistencia**: manejo de JWT y almacenamiento seguro.
- **UI/UX**: creación de pantallas y navegación.
- **Distribución**: preparación del build y publicación en Firebase App Distribution.

> Este README sirve como bitácora del taller para facilitar la réplica y evaluación del proyecto.
