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
