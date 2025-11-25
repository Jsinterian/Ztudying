import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ztudying"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),

            // Título bonito
            Text(
              "Bienvenido a Ztudying",
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 12),

            Text(
              "Tu compañero para estudiar mejor,\ncuidar tu vista y organizar tus técnicas.",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: AppColors.textDark.withOpacity(0.75),
                  ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 40),

            // Botón Pomodoro
            _menuButton(
              context,
              icon: Icons.timer_outlined,
              label: "Temporizador Pomodoro",
              route: "/pomodoro",
            ),

            // Botón Técnicas
            _menuButton(
              context,
              icon: Icons.menu_book_outlined,
              label: "Técnicas de estudio",
              route: "/techniques",
            ),

            // Botón Regla 20-20-20
            _menuButton(
              context,
              icon: Icons.visibility_outlined,
              label: "Regla 20-20-20",
              route: "/20rule",
            ),

            // Botón estadísticas
            _menuButton(
              context,
              icon: Icons.bar_chart_rounded,
              label: "Estadísticas",
              route: "/stats",
            ),

            const Spacer(),

            // Copyright
            Text(
              "© 2025 Ztudying",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.grey.shade600,
                  ),
            ),

            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  // --- WIDGET REUTILIZABLE PARA BOTONES DEL MENÚ ---
  Widget _menuButton(BuildContext context,
      {required IconData icon,
      required String label,
      required String route}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: ElevatedButton(
        onPressed: () => Navigator.pushNamed(context, route),
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 58),
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 26),
            const SizedBox(width: 12),
            Text(
              label,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
