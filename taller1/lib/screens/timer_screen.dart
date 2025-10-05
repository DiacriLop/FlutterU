import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  int _seconds = 0;
  Timer? _timer;
  bool _isRunning = false;
  bool _disposed = false; // Nuevo flag

  /// Inicia el cronómetro
  void _start() {
    if (_timer != null) return; // evitar múltiples timers
    setState(() => _isRunning = true);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_disposed) {
        timer.cancel();
        return;
      }
      if (mounted) {
        setState(() => _seconds++);
      }
    });
  }

  /// Pausa el cronómetro
  void _pause() {
    _timer?.cancel();
    _timer = null;
    if (mounted) setState(() => _isRunning = false);
  }

  /// Reanuda si estaba en pausa
  void _resume() {
    if (_isRunning || _timer != null) return;
    _start();
  }

  /// Reinicia el cronómetro
  void _reset() {
    _pause();
    if (mounted) setState(() => _seconds = 0);
  }

  /// Navega al menú principal de forma segura
  void _goToHome(BuildContext context) {
    _pause(); // Cancela el timer antes de navegar
    context.go('/');
  }

  @override
  void dispose() {
    _disposed = true;
    _pause(); // limpiar siempre el timer
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final timeStyle = TextStyle(
      fontSize: 56,
      fontWeight: FontWeight.bold,
      color: _isRunning ? Colors.green : Colors.deepOrange,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cronómetro'),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            tooltip: 'Menú principal',
            onPressed: () => _goToHome(context),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _isRunning ? Icons.timer : Icons.pause_circle,
                color: _isRunning ? Colors.green : Colors.deepOrange,
                size: 48,
              ),
              const SizedBox(height: 16),
              Text('$_seconds s', style: timeStyle),
              const SizedBox(height: 32),

              // Controles principales
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('Iniciar'),
                    onPressed: _isRunning ? null : _start,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.pause),
                    label: const Text('Pausar'),
                    onPressed: _isRunning ? _pause : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.play_circle),
                    label: const Text('Reanudar'),
                    onPressed: (!_isRunning && _seconds > 0) ? _resume : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.restart_alt),
                    label: const Text('Reiniciar'),
                    onPressed: _seconds > 0 ? _reset : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // Botón de salida al menú principal
              ElevatedButton.icon(
                icon: const Icon(Icons.menu),
                label: const Text('Menú principal'),
                onPressed: () => _goToHome(context),
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


