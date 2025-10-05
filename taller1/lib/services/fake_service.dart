import 'dart:math';

Future<String> fetchData() async {
  print('Antes de la consulta');
  await Future.delayed(const Duration(seconds: 2));
  print('Durante la consulta');
  if (Random().nextBool()) {
    print('Consulta exitosa');
    return '¡Datos cargados correctamente!';
  } else {
    print('Error en la consulta');
    throw Exception('Error al cargar los datos');
  }
}