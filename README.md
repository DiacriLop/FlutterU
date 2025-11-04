# 🚀 FlutterU
Repositorio para todas las actividades de la materia electiva profesional 1

# 📝 Taller 1 – Flutter + Widgets + Git Flow

## 📌Descripción
Este taller consiste en construir una pantalla básica en Flutter usando **StatefulWidget** y evidenciando el uso de **setState()**.  
Se implementan widgets como AppBar dinámico, botones, imágenes, ListView, Stack, GridView y mejoras visuales con Container y Padding.  
Además, se aplica **control de versiones** usando Git Flow: rama feature → dev → main.

## ⚡Pasos para ejecutar

1. **Clonar el repositorio**:

```bash
git clone https://github.com/DiacriLop/FlutterU.git
```

2.Entrar al directorio del proyecto:
```bash
cd FlutterU
```

3.Cambiar a la rama principal (main):
```bash
git checkout main
```

4.Verificar la versión de Flutter (opcional):
```bash
flutter --version
```

5.Instalar dependencias:
```bash
flutter pub get
```

6.Verificar assets
```bash
Asegúrate que las imágenes estén declaradas en pubspec.yaml bajo flutter: → assets:.
```
7.Ejecutar la aplicación:
```bash
flutter run
```
8.Limpiar builds previos si hay errores (opcional):
```bash
flutter clean
flutter pub get
flutter run
```


---
## 📷Capturas

<img width="877" height="593" alt="image" src="https://github.com/user-attachments/assets/c16f10ad-044c-49fb-a0ee-eb95e8d7f380" />
<img width="992" height="402" alt="image" src="https://github.com/user-attachments/assets/3eb4838b-3a06-4521-9e66-a800c6b53ccf" />
<img width="963" height="602" alt="image" src="https://github.com/user-attachments/assets/a8943940-b527-4743-a7c8-e4defe144180" />

---
# 📝 Taller 2 Navegación, widgets y ciclo de vida en Flutter
---
## Descripción
Esta aplicación en Flutter implementa navegación con **go_router**, evidenciando el **ciclo de vida de un StatefulWidget**, el paso de parámetros entre pantallas y el comportamiento de `go`, `push` y `replace`.  
Incluye además **widgets intermedios** como GridView, TabBar y un widget adicional (Card de oferta y barra de búsqueda).

Objetivo: comprender la construcción, actualización y destrucción de widgets, así como la gestión de rutas y parámetros.

---

## Arquitectura y Navegación

La aplicación utiliza **GoRouter** para gestionar rutas y navegación.  

### Rutas definidas

| Ruta | Nombre | Descripción | Parámetros |
|------|--------|-------------|------------|
| `/` | home | Pantalla principal (**HomeScreen**) | - |
| `/perfil` | perfil | Pantalla de perfil (**PerfilScreen**) | - |
| `/perfil-detalle/:nombre/:correo/:metodo` | perfilDetalle | Detalle del perfil (**PerfilDetalleScreen**) | `nombre`, `correo`, `metodo` |
| `/catalogo` | catalogo | Catálogo de productos (**CatalogoScreen**) | Parámetro opcional en query: `?promo=...` |
| `/ciclo-vida` | cicloVida | Pantalla que evidencia el ciclo de vida (**CicloVidaScreen**) | - |
| `/ciclo_vida` | redirect | Alias que redirige a `/ciclo-vida` | - |

### Comportamiento de navegación
- **`go()`**: reemplaza la ruta actual.
- **`push()`**: agrega la nueva ruta al historial, permitiendo regresar.
- **`replace()`**: reemplaza la ruta actual en el historial sin posibilidad de volver atrás.

---

## Widgets usados

### 1. GridView
- Ubicado dentro de cada Tab del catálogo (Ropa, Electrónica, Hogar).  
- Muestra productos en cuadrícula de 2 columnas con imagen, nombre y acción al presionar.  

### 2. TabBar
- Maneja diferentes secciones dentro de **CatalogoScreen**.  
- Tabs: Ropa, Electrónica, Hogar.  
- TabBarView asociado con GridView en cada tab.

### 3. Widget adicional
- **Card de oferta especial** y **barra de búsqueda** dentro de CatalogoScreen.
- Card de oferta: notifica promociones especiales de manera visual y atractiva.  
- Barra de búsqueda: permite filtrar productos de forma sencilla.  

---

## Ciclo de Vida de un StatefulWidget

La pantalla **CicloVidaScreen** evidencia el ciclo de vida de un widget con estado. Se registran en consola los métodos principales para comprender su ejecución:

| Método | Momento de ejecución | Ejemplo en app |
|--------|--------------------|----------------|
| `initState()` | Al crear el widget | Inicializa `cantidad=1` y registra: `"🟢 initState() -> La pantalla del carrito se ha inicializado"` |
| `didChangeDependencies()` | Cuando cambian dependencias | Registra: `"🟡 didChangeDependencies() -> Dependencias cambiaron"` |
| `build()` | Cada reconstrucción de UI | Construye la pantalla y registra: `"🔵 build() -> Construyendo la pantalla del carrito"` |
| `setState()` | Al actualizar estado | Incrementa `cantidad` y dispara `build()`, registra: `"🟠 setState() -> Cantidad aumentada a X"` |
| `dispose()` | Al eliminar widget de memoria | Limpia recursos y registra: `"🔴 dispose() -> La pantalla del carrito se ha destruido"` |

### Flujo de interacción
1. Navegar al carrito → `initState()`.
2. Verificar dependencias → `didChangeDependencies()`.
3. Construcción de UI → `build()`.
4. Actualizar cantidad → `setState()` → reconstrucción (`build()`).
5. Volver al Home → `dispose()`.

---

## Ejemplo de registro en consola
🟢 initState() -> La pantalla del carrito se ha inicializado
🟡 didChangeDependencies() -> Dependencias cambiaron (ej: tema)
🔵 build() -> Construyendo la pantalla del carrito
🟠 setState() -> Cantidad aumentada a 2
🔵 build() -> Construyendo la pantalla del carrito
🔴 dispose() -> La pantalla del carrito se ha destruido

---

## Uso de la app

1. Desde **HomeScreen**, presionar el botón “Ir al Catálogo” (con parámetro opcional `promo`).  
2. Explorar las **secciones del catálogo** con TabBar y GridView.  
3. Presionar un producto para navegar a **CicloVidaScreen** y ver la ejecución del ciclo de vida.  
4. Usar botones de navegación para regresar al Home y observar `dispose()`.  
5. Explorar navegación con `go()`, `push()` y `replace()` para comparar el comportamiento del historial.

---

## Repositorio

- Flujo GitFlow Taller2:
  1. Rama feature: `feature/taller_paso_parametros`  
  2. PR hacia `dev`  
  3. Merge a `dev`  
  4. Integración de cambios a `main`
---
## 📷Capturas

### Paginas
<img width="1050" height="555" alt="image" src="https://github.com/user-attachments/assets/627589c6-5edb-460f-be7a-63645790a8a3" />

### Ciclo de Vida de un StatefulWidget

<img width="1919" height="1019" alt="image" src="https://github.com/user-attachments/assets/6024bc39-a636-4616-a008-2a82da78e879" />

### Menu
<img width="489" height="1021" alt="image" src="https://github.com/user-attachments/assets/9188f6ec-5b2e-4859-9ac2-8d6713d5a3e4" />


---
# 📝 Taller 3 – Asincronía, Timer e Isolates en Flutter

---

## 📌 Descripción

Este taller tiene como objetivo aplicar conceptos de **programación asíncrona en Flutter**, utilizando:

* **Future y async/await** → para manejar procesos asíncronos sin bloquear la UI.
* **Timer** → para implementar un cronómetro con inicio, pausa, reanudación y reinicio.
* **Isolate** → para ejecutar tareas pesadas en segundo plano sin afectar la interfaz.

Además, se emplea **GitFlow** para la correcta gestión de versiones del proyecto.

---

## 🎯 Objetivos de aprendizaje

* Comprender y evidenciar el uso de **Future, async y await**.
* Implementar un **cronómetro funcional** con Timer.
* Ejecutar procesos pesados usando **Isolate**, comunicando progreso y resultados a la UI.
* Aplicar un flujo de trabajo estructurado con **GitFlow**:
  `feature/taller_segundo_plano → dev → main`.

---

## ⚡ Funcionalidades implementadas

### 1️⃣ Asincronía con Future / async / await

* Simulación de consulta de datos con `Future.delayed`.
* UI con estados: **Cargando… / Éxito / Error**.
* Mensajes en consola para evidenciar el orden de ejecución.
* Catálogo de ítems en cuadrícula tras la carga exitosa.

### 2️⃣ Timer – Cronómetro

* Funciones: **Iniciar, Pausar, Reanudar y Reiniciar**.
* Actualización del tiempo cada segundo.
* Colores e íconos dinámicos para reflejar el estado.
* Liberación de recursos al pausar o salir de la vista.

### 3️⃣ Isolate – Proceso pesado

* Implementación de una **suma iterativa grande (CPU-bound)**.
* Ejecución en **Isolate** para no bloquear la UI.
* Comunicación de progreso en **%** hacia la interfaz.
* Resultado final + tiempo total de ejecución.
* **Barra de progreso creativa** (rojo → naranja → verde).

---

## 🖼️ Flujo de pantallas

### 🏠 HomeScreen

* Acceso a cada funcionalidad: **Future**, **Timer** e **Isolate**.

### ⏳ FutureScreen

* Pantalla con consulta simulada asíncrona.
* Estados de carga, éxito o error.
* Catálogo con **GridView**.

### ⌚ TimerScreen

* Cronómetro con botones de control: **Iniciar, Pausar, Reanudar, Reiniciar**.
* Visualización del tiempo transcurrido.

### ⚙️ IsolateScreen

* Ejecución de tarea pesada en segundo plano.
* Progreso dinámico y resultado final.

---

## 📷 Espacio para capturas

## 📷 Capturas de la aplicación

Las siguientes imágenes muestran la evidencia visual del **Taller 3 – Asincronía, Timer e Isolates en Flutter**, organizadas por pantalla y funcionalidad.

---

### 🏠 **Pantalla principal – HomeScreen**

Acceso a cada funcionalidad: **Future**, **Timer** e **Isolate**.

<p align="center">  
  <img width="327" height="651" alt="HomeScreen" src="https://github.com/user-attachments/assets/6a7d5721-ed31-420e-a043-89d3f8863afa" />  
</p>  

---

### ⏳ **FutureScreen**

Simulación de consulta asíncrona con **Future/async/await**.

* Estado **Cargando…**
* Estado **Éxito** con catálogo en cuadrícula.

<p align="center">  
  <img width="305" height="654" alt="Future Loading" src="https://github.com/user-attachments/assets/272ba1d5-a774-4343-b030-96618009f71f" />  
  <img width="306" height="646" alt="Future Success" src="https://github.com/user-attachments/assets/5b10fbea-e9c4-49e2-92d0-325f696d8b84" /> 
  <img width="320" height="654" alt="TimerScreen" src="https://github.com/user-attachments/assets/61aaa70e-65f1-4efc-add3-328cb9a23083" />  
</p>  

---

### ⌚ **TimerScreen**

<p align="center">  
  <img width="236" height="476" alt="IsolateScreen" src="https://github.com/user-attachments/assets/04d7c444-518e-4297-96bd-8a48e09b753b" />  
</p>  


---

### ⚙️ **IsolateScreen**

Ejecución de una tarea pesada en segundo plano con **Isolate**, mostrando progreso y resultado final.
<p align="center">  
  <img width="921" height="478" alt="image" src="https://github.com/user-attachments/assets/c5e900c1-36f9-4a34-a6b3-03709696782e" /> 
</p>  



---


## 📊 Diagrama de flujo de navegación


👉 <img width="1536" height="1024" alt="image" src="https://github.com/user-attachments/assets/49b5ecf0-e87a-4c59-97ce-ed78b94210e6" />


---

## 🚀 Pasos para ejecutar

1. **Clonar el repositorio**

   ```bash
   git clone https://github.com/DiacriLop/FlutterU.git
   ```

2. **Entrar al directorio**

   ```bash
   cd FlutterU
   ```

3. **Cambiar a la rama principal**

   ```bash
   git checkout main
   ```

4. **Instalar dependencias**

   ```bash
   flutter pub get
   ```

5. **Verificar assets en pubspec.yaml**

6. **Ejecutar la aplicación**

   ```bash
   flutter run
   ```

7. **(Opcional) Limpiar builds previos**

   ```bash
   flutter clean
   flutter pub get
   flutter run
   ```

---

## 🔀 Flujo GitFlow aplicado

1. **Crear rama de feature desde dev**

   ```bash
   git checkout dev
   git pull origin dev
   git checkout -b feature/taller_segundo_plano
   ```

2. **Subir cambios**

   ```bash
   git push origin feature/taller_segundo_plano
   ```

3. **Abrir Pull Request (PR)**

   * **Base branch**: `dev`
   * **Compare branch**: `feature/taller_segundo_plano`

4. **Revisar y mergear a dev**

5. **Integrar cambios a main**

---


---
# Taller HTTP - Dog CEO API

## API Utilizada
- **API**: Dog CEO API
- **Endpoint Principal**: `https://dog.ceo/api/breeds/list/all`
- **Ejemplo de Respuesta**:
```json
{
  "message": {
    "affenpinscher": [],
    "african": [],
    "airedale": []
  },
  "status": "success"
}
```

## Arquitectura
```
lib/
  ├── models/
  │   └── dog_model.dart
  ├── services/
  │   └── dog_service.dart
  ├── views/
  │   └── dog/
  │       ├── dog_list_screen.dart
  │       └── dog_detail_screen.dart
```

## Rutas (go_router)
- `/dogs` - Lista de razas
- `/dog/:breed?imageUrl=` - Detalle de raza específica

## Estados y Manejo de Errores
- Loading: CircularProgressIndicator + mensaje
- Error: Icono rojo + mensaje + botón reintentar
- Success: Lista de razas con imágenes
- Network Error: SnackBar con opción de reintentar

## 📷 Capturas de la aplicación
<img width="1490" height="1023" alt="image" src="https://github.com/user-attachments/assets/14f892b8-2a87-4f84-8d23-4b954f56fab2" />
<img width="921" height="518" alt="image" src="https://github.com/user-attachments/assets/268bff99-54a2-4fcf-8c1e-197d1379918f" />
<img width="921" height="518" alt="image" src="https://github.com/user-attachments/assets/03c6cb97-a64d-453b-913b-fe42e9b5f389" />
<img width="921" height="518" alt="image" src="https://github.com/user-attachments/assets/6ba1a2ac-a550-4b66-9e9a-60a9b2a09501" />

---

# 📝 Taller 1 Corte 3– Distribución de APK con Firebase App Distribution

## 🔄 Flujo general
- **Generar APK**: compilar el artefacto con `flutter build apk --release` y validar firma/variant.
- **App Distribution**: subir `app-release.apk` desde la CLI de Firebase o panel web y seleccionar testers.
- **Testers**: el lote de QA recibe notificaciones por correo/console y acepta la invitación.
- **Instalación**: descargan e instalan el build en dispositivos físicos/emuladores para validar.
- **Actualización**: nuevos artefactos reemplazan la versión previa, manteniendo historial en Firebase.

## 🚀 Publicación
1. **Preparar variables locales**: validar `firebase login` y proyecto con `firebase use <alias>`.
2. **Generar el artefacto**: `flutter build apk --release` (o `--split-per-abi` si se requiere).
3. **Distribuir**: ejecutar `firebase appdistribution:distribute build/app/outputs/flutter-apk/app-release.apk --app <app-id> --groups qa`.
4. **Compartir con el equipo**: confirmar recepción del correo y acceso en `App Tester`. Documentar feedback en la tarjeta de seguimiento.
5. **Replicar en equipo**: los integrantes solo requieren el mismo `firebase-tools`, credenciales y acceso al proyecto para repetir los pasos anteriores.

## 🧾 Versionado y Release Notes
- **Versionado en `taller1/pubspec.yaml`**: se incrementa `version:` siguiendo el formato `<major>.<minor>.<patch>+<build>` (ej. `1.0.2+3`).
- **Sincronización con Android**: `versionCode` y `versionName` quedan alineados al ejecutar `flutter build`, evitando desfaces.
- **Formato de Release Notes**: usar viñetas breves destacando cambios clave, p.ej.:
  - `• Icono de la app actualizado.`
  - `• Integración con Firebase App Distribution.`
  - `• Ajustes para flujo de pruebas QA.`
- **Publicación**: adjuntar las notas en el comando de distribución (`--release-notes file.txt`) o directamente en el panel.

## 📸 Capturas

| Captura 1 | Captura 2 |
|------------|------------|
| <img src="https://github.com/user-attachments/assets/bfd8a4fe-037f-46cf-ae82-64ea953ad0dd" width="250"> | <img src="https://github.com/user-attachments/assets/46f3e14d-7709-48d9-bb85-ba9c1b576a09" width="250"> |

| Captura 3 | Captura 4 |
|------------|------------|
---

# 🔥 Taller 4 – Integración con Firebase

## 🏫 Gestión de Universidades con Firebase

Aplicación Flutter para la gestión de universidades que utiliza Firebase como backend, implementando operaciones CRUD con Firestore y autenticación de usuarios.

## 🚀 Características Principales

- **Autenticación** segura con Firebase Auth
- **CRUD** completo de universidades
- **Sincronización en tiempo real** con Firestore
- **Validaciones** de formularios
- **Diseño responsivo** siguiendo Material Design 3
- **Manejo de estado** con Provider

## 🛠️ Configuración Requerida

- Flutter SDK (última versión estable)
- Cuenta de Firebase
- Dispositivo físico o emulador Android/iOS
- Paquetes principales:
  ```yaml
  firebase_core: ^2.15.1
  cloud_firestore: ^4.9.1
  firebase_auth: ^4.8.3
  provider: ^6.0.5
  ```

## 🔥 Configuración de Firebase

1. **Crear proyecto en Firebase**
   - Ir a [Firebase Console](https://console.firebase.google.com/)
   - Hacer clic en "Añadir proyecto"
   - Seguir el asistente de configuración

2. **Añadir aplicación Flutter**
   - Seleccionar el proyecto
   - Hacer clic en el ícono de Android/iOS
   - Seguir las instrucciones para registrar la aplicación
   - Descargar el archivo de configuración:
     - Android: `google-services.json` en `android/app/`
     - iOS: `GoogleService-Info.plist` en `ios/Runner/`

3. **Habilitar Autenticación**
   - En Firebase Console, ir a "Authentication"
   - Ir a la pestaña "Sign-in method"
   - Habilitar "Email/Password"

4. **Configurar Firestore**
   - Crear base de datos Firestore
   - Configurar reglas de seguridad:
   ```javascript
   rules_version = '2';
   service cloud.firestore {
     match /databases/{database}/documents} {
       match /universidades/{universidad} {
         allow read: if true;
         allow create, update, delete: if request.auth != null;
       }
     }
   }
   ```

## 🏗️ Estructura del Proyecto

```
lib/
├── models/
│   └── universidad.dart
├── services/
│   ├── auth_service.dart
│   └── universidad_service.dart
├── screens/
│   ├── auth/
│   │   ├── login_screen.dart
│   │   └── register_screen.dart
│   └── universidad/
│       ├── universidad_list_screen.dart
│       └── universidad_form_screen.dart
└── main.dart
```

## 📱 Capturas de Pantalla

| Inicio de Sesión | Lista de Universidades | Formulario |
|-----------------|----------------------|------------|
| ![Login]()      | ![Lista]()          | ![Form]()  |

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

## 🚀 Despliegue

1. **Generar APK release**
   ```bash
   flutter build apk --release
   ```

2. **Distribuir con Firebase App Distribution**
   ```bash
   firebase appdistribution:distribute build/app/outputs/flutter-apk/app-release.apk \
     --app <app-id> \
     --groups testers
   ```

## 📝 Notas de Versión

### v1.0.0
- Versión inicial del módulo de universidades
- Integración con Firebase Auth y Firestore
- CRUD completo de universidades
- Validaciones de formulario
- Diseño responsivo

---

## Datos Estudiante
### Diana Cristina Lopez Reyes
### Codigo:230222003
### Grupo:2
---

