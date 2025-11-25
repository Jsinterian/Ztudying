import 'dart:async';
import 'package:flutter/material.dart';
import '../services/stats_service.dart';
import '../theme/app_colors.dart';

class TwentyRuleScreen extends StatefulWidget {
  const TwentyRuleScreen({super.key});

  @override
  State<TwentyRuleScreen> createState() => _TwentyRuleScreenState();
}

class _TwentyRuleScreenState extends State<TwentyRuleScreen> {
  static const int breakSeconds = 20;

  late DateTime _startTime;
  int _remaining = breakSeconds;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startRealTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // ⭐ TIMER BASADO EN EL TIEMPO REAL
  void _startRealTimer() {
    _startTime = DateTime.now();

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final elapsed = DateTime.now().difference(_startTime).inSeconds;
      final remaining = breakSeconds - elapsed;

      if (remaining <= 0) {
        _timer?.cancel();
        setState(() => _remaining = 0);
        _finishBreak();
      } else {
        setState(() => _remaining = remaining);
      }
    });
  }

  Future<void> _finishBreak() async {
    await StatsService.instance.addTwentyRuleBreak();
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Regla 20-20-20"),
      ),

      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),

                Text(
                  "Descanso visual",
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 10),

                Text(
                  "Mira un objeto que esté a aproximadamente 20 metros de distancia.\n\n"
                  "Relaja tu vista durante estos 20 segundos.",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.black87),
                ),

                const SizedBox(height: 40),

                // TIMER
                Container(
                  width: 230,
                  height: 230,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary.withOpacity(0.15),
                    border: Border.all(
                      color: AppColors.primary,
                      width: 10,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "${_remaining}s",
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                Text(
                  "Este descanso ayuda a prevenir fatiga ocular.",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.black54),
                ),

                const SizedBox(height: 50),

                TextButton(
                  onPressed: () {
                    _timer?.cancel();
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Omitir descanso",
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 16,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
