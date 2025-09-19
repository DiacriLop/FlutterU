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

## 👩‍🎓Datos Estudiante
### Diana Cristina Lopez Reyes
### Codigo:230222003
### Grupo:2
---
