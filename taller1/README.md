# 📝 Taller 1 Corte 3 – Distribución de APK con Firebase App Distribution

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
- **Versionado en `pubspec.yaml`**: se incrementa `version:` siguiendo el formato `<major>.<minor>.<patch>+<build>` (ej. `1.0.2+3`).
- **Sincronización con Android**: `versionCode` y `versionName` quedan alineados al ejecutar `flutter build`, evitando desfaces.
- **Formato de Release Notes**: usar viñetas breves destacando cambios clave, p.ej.:
  - `• Icono de la app actualizado.`
  - `• Integración con Firebase App Distribution.`
  - `• Ajustes para flujo de pruebas QA.`
- **Publicación**: adjuntar las notas en el comando de distribución (`--release-notes file.txt`) o directamente en el panel.

## 📸 Capturas o GIFs del panel (opcional)
- Enlazar capturas del panel App Distribution o anexarlas en el PDF de evidencias.
