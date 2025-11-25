import 'dart:async';
import 'package:flutter/material.dart';
import '../services/stats_service.dart';
import '../theme/app_colors.dart';

class PomodoroScreen extends StatefulWidget {
  const PomodoroScreen({super.key});

  @override
  State<PomodoroScreen> createState() => _PomodoroScreenState();
}

enum PomodoroPhase { work, shortBreak, longBreak }

class _PomodoroScreenState extends State<PomodoroScreen> {
  static const int _workMinutes = 20;
  static const int _shortBreakMinutes = 5;
  static const int _longBreakMinutes = 15;

  Timer? _timer;

  bool _isRunning = false;
  PomodoroPhase _phase = PomodoroPhase.work;

  late DateTime _startTime;
  int _initialSeconds = _workMinutes * 60;
  int _remainingSeconds = _workMinutes * 60;

  int _completedWorkSessions = 0;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // ⭐ Temporizador basado en tiempo real
  void _startTimer() {
    _startTime = DateTime.now();
    _isRunning = true;

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final elapsed = DateTime.now().difference(_startTime).inSeconds;
      final remaining = _initialSeconds - elapsed;

      if (remaining <= 0) {
        _remainingSeconds = 0;
        _timer?.cancel();
        _handlePhaseCompleted();
      } else {
        setState(() => _remainingSeconds = remaining);
      }
    });

    setState(() {});
  }

  void _pauseTimer() {
    _timer?.cancel();
    _isRunning = false;
    setState(() {});
  }

  void _startPause() {
    if (_isRunning) {
      _pauseTimer();
    } else {
      // Para continuar correctamente
      _initialSeconds = _remainingSeconds;
      _startTime = DateTime.now();
      _startTimer();
    }
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
      _phase = PomodoroPhase.work;
      _initialSeconds = _workMinutes * 60;
      _remainingSeconds = _workMinutes * 60;
      _completedWorkSessions = 0;
    });
  }

  Future<void> _handlePhaseCompleted() async {
    if (_phase == PomodoroPhase.work) {
      _completedWorkSessions++;
      await StatsService.instance.addPomodoro(_workMinutes);

      int breakMinutes;
      PomodoroPhase nextPhase;

      if (_completedWorkSessions % 4 == 0) {
        nextPhase = PomodoroPhase.longBreak;
        breakMinutes = _longBreakMinutes;
      } else {
        nextPhase = PomodoroPhase.shortBreak;
        breakMinutes = _shortBreakMinutes;
      }

      _phase = nextPhase;
      _initialSeconds = breakMinutes * 60;
      _remainingSeconds = breakMinutes * 60;
      _isRunning = false;

      if (mounted) await Navigator.pushNamed(context, "/20rule");
    } else {
      _phase = PomodoroPhase.work;
      _initialSeconds = _workMinutes * 60;
      _remainingSeconds = _workMinutes * 60;
      _isRunning = false;
    }

    setState(() {});
  }

  String _formatTime(int totalSeconds) {
    final minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  String _phaseTitle() {
    switch (_phase) {
      case PomodoroPhase.work:
        return "Tiempo de enfoque";
      case PomodoroPhase.shortBreak:
        return "Descanso corto";
      case PomodoroPhase.longBreak:
        return "Descanso largo";
    }
  }

  String _phaseSubtitle() {
    switch (_phase) {
      case PomodoroPhase.work:
        return "Estudia durante 20 minutos con enfoque total.";
      case PomodoroPhase.shortBreak:
        return "Te corresponde un descanso corto de 5 minutos.";
      case PomodoroPhase.longBreak:
        return "Has completado 4 ciclos. Toma un descanso largo.";
    }
  }

  Color _phaseColor() {
    switch (_phase) {
      case PomodoroPhase.work:
        return AppColors.primary;
      case PomodoroPhase.shortBreak:
        return AppColors.secondary;
      case PomodoroPhase.longBreak:
        return const Color(0xFF5CA741);
    }
  }

  @override
  Widget build(BuildContext context) {
    final timeText = _formatTime(_remainingSeconds);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pomodoro"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          children: [
            const SizedBox(height: 20),

            Text(
              _phaseTitle(),
              style: Theme.of(context).textTheme.headlineSmall,
            ),

            const SizedBox(height: 6),

            Text(
              _phaseSubtitle(),
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.black54),
            ),

            const SizedBox(height: 40),

            // ---- TIMER CIRCLE ----
            Container(
              width: 240,
              height: 240,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _phaseColor().withOpacity(0.14),
                border: Border.all(
                  color: _phaseColor(),
                  width: 10,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                timeText,
                style: const TextStyle(
                  fontSize: 46,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 35),

            Text(
              "Ciclos completados: $_completedWorkSessions",
              style: TextStyle(
                color: Colors.black.withOpacity(0.6),
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 35),

            // ---- BUTTONS (RESPONSIVE) ----
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _startPause,
                    icon: Icon(_isRunning ? Icons.pause : Icons.play_arrow),
                    label: Text(_isRunning ? "Pausar" : "Iniciar"),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _resetTimer,
                    icon: const Icon(Icons.refresh),
                    label: const Text("Reiniciar"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.primary,
                      side: const BorderSide(color: AppColors.primary),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
