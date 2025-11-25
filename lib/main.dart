import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/pomodoro_screen.dart';
import 'screens/techniques_screen.dart';
import 'screens/twenty_rule_screen.dart';
import 'screens/stats_screen.dart';

void main() {
  runApp(const ZtudyingApp());
}

class ZtudyingApp extends StatelessWidget {
  const ZtudyingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ztudying',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
  useMaterial3: true,  
  scaffoldBackgroundColor: const Color(0xFFFDFEFB),

  colorScheme: const ColorScheme.light(
    primary: Color(0xFF6FBF73),
    secondary: Color(0xFFAEDFAA),
  ),

  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF6FBF73),
    foregroundColor: Colors.white,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),

  // BOTONES
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(Color(0xFF6FBF73)),
      foregroundColor: WidgetStateProperty.all(Colors.white),
      padding: WidgetStateProperty.all(
        EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      ),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(14)),
        ),
      ),
      elevation: WidgetStateProperty.all(3),
      shadowColor: WidgetStateProperty.all(Colors.black12),
    ),
  ),

  // TARJETAS (MODERNO CON CardThemeData)
  cardTheme: const CardThemeData(
    color: Colors.white,
    elevation: 4,
    shadowColor: Colors.black12,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
  ),

  textTheme: const TextTheme(
    bodyMedium: TextStyle(
      color: Color(0xFF333333),
      fontSize: 16,
    ),
    bodyLarge: TextStyle(
      color: Color(0xFF333333),
      fontSize: 18,
    ),
    headlineSmall: TextStyle(
      color: Color(0xFF6FBF73),
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
  ),
),

      initialRoute: '/',
      routes: {
        '/': (_) => const HomeScreen(),
        '/pomodoro': (_) => const PomodoroScreen(),
        '/techniques': (_) => const TechniquesScreen(),
        '/20rule': (_) => const TwentyRuleScreen(),
        '/stats': (_) => const StatsScreen(),
      },
    );
  }
}
