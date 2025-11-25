import 'package:shared_preferences/shared_preferences.dart';

class StatsService {
  StatsService._();
  static final StatsService instance = StatsService._();

  static const String _kPomodoroSessions = 'pomodoro_sessions';
  static const String _kStudyMinutes = 'study_minutes';
  static const String _kCyclesCompleted = 'cycles_completed';
  static const String _kTwentyRuleBreaks = 'twenty_rule_breaks';

  Future<SharedPreferences> get _prefs async =>
      await SharedPreferences.getInstance();

  /// Registrar un pomodoro completado
  Future<void> addPomodoro(int minutes) async {
    final prefs = await _prefs;
    final sessions = prefs.getInt(_kPomodoroSessions) ?? 0;
    final studyMinutes = prefs.getInt(_kStudyMinutes) ?? 0;
    final cycles = prefs.getInt(_kCyclesCompleted) ?? 0;

    await prefs.setInt(_kPomodoroSessions, sessions + 1);
    await prefs.setInt(_kStudyMinutes, studyMinutes + minutes);
    await prefs.setInt(_kCyclesCompleted, cycles + 1);
  }

  /// Registrar un descanso 20-20-20 (lo usaremos después)
  Future<void> addTwentyRuleBreak() async {
    final prefs = await _prefs;
    final breaks = prefs.getInt(_kTwentyRuleBreaks) ?? 0;
    await prefs.setInt(_kTwentyRuleBreaks, breaks + 1);
  }

  Future<Map<String, int>> getStats() async {
    final prefs = await _prefs;
    return {
      _kPomodoroSessions: prefs.getInt(_kPomodoroSessions) ?? 0,
      _kStudyMinutes: prefs.getInt(_kStudyMinutes) ?? 0,
      _kCyclesCompleted: prefs.getInt(_kCyclesCompleted) ?? 0,
      _kTwentyRuleBreaks: prefs.getInt(_kTwentyRuleBreaks) ?? 0,
    };
  }
}
