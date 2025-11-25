import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class TechniquesScreen extends StatelessWidget {
  const TechniquesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Técnicas de estudio"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _header(context),

          const SizedBox(height: 20),

          _techCard(
            context,
            icon: Icons.timer_outlined,
            iconColor: AppColors.primary,
            title: "Pomodoro",
            desc:
                "Divide tu estudio en ciclos de enfoque y descanso para maximizar la productividad.",
            what:
                "Consiste en estudiar por intervalos de tiempo y descansar en medio. En Ztudying es 20 minutos + descanso visual + descanso corto/largo.",
            how: [
              "Estudia durante 20 minutos.",
              "Haz un descanso visual de 20 segundos.",
              "Realiza un descanso corto.",
              "Cada 4 ciclos, toma un descanso largo.",
            ],
            example:
                "Si estudias matemáticas, resuelve ejercicios por 20 minutos, descansa visualmente y continúa.",
            tip:
                "Si te distraes fácilmente, empieza con intervalos más cortos (10–15 min).",
          ),

          _techCard(
            context,
            icon: Icons.psychology_alt_outlined,
            iconColor: Colors.orange,
            title: "Active Recall",
            desc:
                "La técnica más poderosa para retener información recordando sin ver.",
            what:
                "Obliga a tu cerebro a recuperar información en vez de leerla pasivamente.",
            how: [
              "Lee un tema brevemente.",
              "Cierra el libro o apaga la pantalla.",
              "Hazte preguntas y respóndelas sin ver tus notas.",
              "Refuerza lo que no recuerdes.",
            ],
            example:
                "Después de leer sobre el sistema muscular, intenta describir de memoria los músculos principales.",
            tip: "Mientras más difícil sea recordar, más efectivo será.",
          ),

          _techCard(
            context,
            icon: Icons.event_repeat,
            iconColor: Colors.blue,
            title: "Spaced Repetition",
            desc:
                "Repasa información en intervalos crecientes para consolidar la memoria.",
            what:
                "Refuerza la memoria antes de que olvides la información.",
            how: [
              "Estudia hoy.",
              "Repasa mañana.",
              "Repasa en 3 días.",
              "Repasa en una semana.",
              "Repasa en un mes.",
            ],
            example:
                "Para un examen, repasa cada tema varias veces siguiendo los intervalos.",
            tip: "Puedes usar tarjetas de estudio o apps como Anki.",
          ),

          _techCard(
            context,
            icon: Icons.record_voice_over,
            iconColor: Colors.purple,
            title: "Método Feynman",
            desc: "Aprende explicando temas de manera simple.",
            what:
                "Si no puedes explicar algo con palabras sencillas, aún no lo entiendes completamente.",
            how: [
              "Elige un tema.",
              "Explícalo como si se lo enseñaras a un niño.",
              "Identifica conceptos que no puedes simplificar.",
              "Refuerza y vuelve a explicar.",
            ],
            example:
                "Explica la fotosíntesis como: 'Las plantas crean su alimento usando luz del sol'.",
            tip: "Grábate explicando; notarás rápido qué te falta dominar.",
          ),

          _techCard(
            context,
            icon: Icons.menu_book_outlined,
            iconColor: Colors.redAccent,
            title: "SQ4R",
            desc:
                "Sistema para estudiar textos eficientemente.",
            what:
                "Convierte la lectura pasiva en lectura activa mediante pasos estructurados.",
            how: [
              "Survey: explora títulos y subtítulos.",
              "Question: genera preguntas.",
              "Read: lee buscando respuestas.",
              "Recite: explica lo aprendido.",
              "Review: repasa lo esencial.",
              "Reflect: relaciona ideas.",
            ],
            example:
                "Al leer historia, analiza títulos, formula preguntas y después une ideas importantes.",
            tip: "Haz preguntas ANTES de leer para activar el pensamiento crítico.",
          ),
        ],
      ),
    );
  }

  // --------------------- HEADER -----------------------
  Widget _header(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Aprende mejor con estas técnicas",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 6),
        Text(
          "Cada técnica incluye explicación, guía práctica y ejemplos.",
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Colors.black54),
        ),
      ],
    );
  }

  // --------------------- TECH CARD ------------------------
  Widget _techCard(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String title,
    required String desc,
    required String what,
    required List<String> how,
    required String example,
    required String tip,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ExpansionTile(
        leading: CircleAvatar(
          radius: 20,
          backgroundColor: iconColor.withOpacity(0.15),
          child: Icon(icon, color: iconColor, size: 26),
        ),
        textColor: AppColors.primary,
        iconColor: AppColors.primary,
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: Text(
          desc,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black.withOpacity(0.55),
          ),
        ),
        childrenPadding:
            const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        children: [
          _sectionTitle("¿Qué es?"),
          _sectionText(what),

          const SizedBox(height: 10),
          _sectionTitle("¿Cómo aplicarla?"),
          ...how.map((step) => _bullet(step)).toList(),

          const SizedBox(height: 10),
          _sectionTitle("Ejemplo práctico"),
          _sectionText(example),

          const SizedBox(height: 10),
          _tipBox(tip),

          const SizedBox(height: 16),
        ],
      ),
    );
  }

  // --------------------- COMPONENTES ------------------------

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: AppColors.primary,
      ),
    );
  }

  Widget _sectionText(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 15,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _bullet(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("• ",
            style: TextStyle(fontSize: 16, color: AppColors.primary)),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(
              text,
              style: const TextStyle(fontSize: 15),
            ),
          ),
        ),
      ],
    );
  }

  Widget _tipBox(String tip) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.secondary.withOpacity(0.25),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.lightbulb_outline,
              color: AppColors.primary, size: 26),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              tip,
              style: const TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
