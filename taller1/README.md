# 🏫 Gestión de Universidades con Firebase

Aplicación Flutter para la gestión de universidades que utiliza Firebase como backend, implementando operaciones CRUD con Firestore y autenticación de usuarios.

## 🚀 Características

- **Autenticación** de usuarios con Firebase Auth
- **CRUD** completo de universidades
- **Tiempo real** con Firestore
- **Validaciones** de formularios
- **Diseño responsivo** siguiendo Material Design 3
- **Manejo de estado** con Provider

## 🛠️ Requisitos Previos

- Flutter SDK (última versión estable)
- Cuenta de Firebase
- Android Studio / Xcode (para emuladores)
- Dispositivo físico o emulador

## 🔧 Configuración del Proyecto

1. **Clonar el repositorio**
   ```bash
   git clone <url-del-repositorio>
   cd taller1
   ```

2. **Instalar dependencias**
   ```bash
   flutter pub get
   ```

3. **Configurar Firebase**
   - Crear proyecto en [Firebase Console](https://console.firebase.google.com/)
   - Añadir una aplicación Android/iOS
   - Descargar el archivo de configuración:
     - Android: `google-services.json` en `android/app/`
     - iOS: `GoogleService-Info.plist` en `ios/Runner/`

4. **Configurar reglas de Firestore**
   ```javascript
   rules_version = '2';
   service cloud.firestore {
     match /databases/{database}/documents {
       match /universidades/{universidad} {
         allow read: if true;
         allow create, update, delete: if request.auth != null;
         
         // Validaciones de esquema
         allow create: if (
           request.resource.data.nit is string &&
           request.resource.data.nombre is string &&
           request.resource.data.direccion is string &&
           request.resource.data.telefono is string &&
           (request.resource.data.pagina_web == null || 
            request.resource.data.pagina_web is string)
         );
       }
     }
   }
   ```

## 🚀 Ejecutar la Aplicación

```bash
# Obtener dependencias
flutter pub get

# Ejecutar en modo desarrollo
flutter run

# Generar APK de lanzamiento
flutter build apk --release
```

## 📱 Estructura del Proyecto

```
lib/
├── models/          # Modelos de datos
│   └── universidad.dart
├── services/        # Servicios
│   ├── auth_service.dart
│   └── universidad_service.dart
├── screens/         # Pantallas
│   ├── auth/
│   │   ├── login_screen.dart
│   │   └── register_screen.dart
│   └── universidad/
│       ├── universidad_list_screen.dart
│       └── universidad_form_screen.dart
├── widgets/         # Componentes reutilizables
├── utils/           # Utilidades
└── main.dart        # Punto de entrada
```

## 🔒 Autenticación

La aplicación incluye:
- Inicio de sesión con correo/contraseña
- Registro de nuevos usuarios
- Cierre de sesión
- Protección de rutas

## 📊 Modelo de Datos

### Colección: `universidades`
```typescript
{
  "nit": string,           // Ej: "890.123.456-7"
  "nombre": string,        // Ej: "Universidad del Valle"
  "direccion": string,     // Ej: "Calle 13 #100-00, Cali"
  "telefono": string,      // Ej: "+57 602 3212100"
  "pagina_web": string,    // Ej: "https://www.univalle.edu.co"
  "fecha_creacion": timestamp
}
```

## 📱 Capturas de Pantalla

| Inicio de Sesión | Lista de Universidades | Formulario |
|-----------------|----------------------|------------|
| ![Login]()      | ![Lista]()          | ![Form]()  |

## 📝 Notas de Versión

### v1.0.0
- Versión inicial del proyecto
- CRUD completo de universidades
- Autenticación con Firebase
- Interfaz de usuario responsiva

## 🤝 Contribución

1. Hacer fork del proyecto
2. Crear rama de características: `git checkout -b feature/nueva-funcionalidad`
3. Hacer commit de los cambios: `git commit -m 'Añadir nueva funcionalidad'`
4. Hacer push a la rama: `git push origin feature/nueva-funcionalidad`
5. Abrir un Pull Request

## 📄 Licencia

Este proyecto está bajo la Licencia MIT. Ver el archivo `LICENSE` para más detalles.

## 📧 Contacto

- **Nombre**: [Tu Nombre]
- **Email**: tu@email.com
- **Proyecto**: [Enlace al Repositorio](https://github.com/tu-usuario/tu-proyecto)
