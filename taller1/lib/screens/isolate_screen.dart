import 'dart:isolate';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Función CPU-bound con progreso
int heavySumWithProgress(int n, SendPort sendPort) {
  int sum = 0;
  final step = n ~/ 100; // enviar progreso cada 1%
  for (int i = 0; i < n; i++) {
    sum += i;
    if (i % step == 0 && i != 0) {
      int percent = (i / n * 100).toInt();
      sendPort.send({'progress': percent});
    }
  }
  return sum;
}

// Entrada del isolate
void isolateEntry(List<dynamic> args) {
  final SendPort sendPort = args[0];
  final int n = args[1];

  sendPort.send({'message': 'Isolate iniciado'});
  final result = heavySumWithProgress(n, sendPort);
  sendPort.send({'message': 'Tarea terminada'});
  sendPort.send({'result': result});
}

class IsolateScreen extends StatefulWidget {
  const IsolateScreen({super.key});

  @override
  State<IsolateScreen> createState() => _IsolateScreenState();
}

class _IsolateScreenState extends State<IsolateScreen> {
  int _progress = 0;
  String _status = '';
  int? _result;
  bool _loading = false;
  double? _elapsedSeconds;

  Future<void> _runIsolate() async {
    setState(() {
      _loading = true;
      _progress = 0;
      _status = '';
      _result = null;
      _elapsedSeconds = null;
    });

    final receivePort = ReceivePort();
    final stopwatch = Stopwatch()..start();

    await Isolate.spawn(isolateEntry, [receivePort.sendPort, 100000000]);

    receivePort.listen((data) {
      if (data is Map) {
        if (data.containsKey('progress')) {
          setState(() {
            _progress = data['progress'] as int;
          });
          print('Progreso: $_progress%');
        } else if (data.containsKey('message')) {
          setState(() {
            _status = data['message'] as String;
          });
          print(_status);
        } else if (data.containsKey('result')) {
          stopwatch.stop();
          setState(() {
            _result = data['result'] as int;
            _loading = false;
            _elapsedSeconds = stopwatch.elapsedMilliseconds / 1000;
            _progress = 100;
            _status = 'Finalizado';
          });
          receivePort.close();
        }
      }
    });
  }

  void _reset() {
    setState(() {
      _progress = 0;
      _status = '';
      _result = null;
      _loading = false;
      _elapsedSeconds = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    Color progressColor;
    if (_progress < 33) {
      progressColor = Colors.red;
    } else if (_progress < 66) {
      progressColor = Colors.orange;
    } else {
      progressColor = Colors.green;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Isolate con Progreso Creativo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            tooltip: 'Menú principal',
            onPressed: () => context.go('/'),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.memory, color: progressColor, size: 64),
              const SizedBox(height: 16),
              Text(_status, style: const TextStyle(fontSize: 20)),
              const SizedBox(height: 16),
              LinearProgressIndicator(
                value: _progress / 100,
                minHeight: 16,
                color: progressColor,
                backgroundColor: Colors.grey[300],
              ),
              const SizedBox(height: 8),
              Text('$_progress%', style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 24),
              if (_result != null)
                Column(
                  children: [
                    Text('Resultado: $_result', style: const TextStyle(fontSize: 24)),
                    if (_elapsedSeconds != null)
                      Text('Tiempo: ${_elapsedSeconds!.toStringAsFixed(2)} s', style: const TextStyle(fontSize: 18)),
                    const SizedBox(height: 16),
                  ],
                ),
              ElevatedButton.icon(
                icon: const Icon(Icons.play_arrow),
                label: const Text('Ejecutar Isolate'),
                onPressed: _loading ? null : _runIsolate,
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                icon: const Icon(Icons.restart_alt),
                label: const Text('Reiniciar'),
                onPressed: _reset,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                icon: const Icon(Icons.menu),
                label: const Text('Menú principal'),
                onPressed: () => context.go('/'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(180, 48),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
