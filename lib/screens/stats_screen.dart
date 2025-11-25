import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../services/stats_service.dart';
import '../theme/app_colors.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  int pomodoros = 0;
  int studyMinutes = 0;
  int cycles = 0;
  int twentyBreaks = 0;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  Future<void> _loadStats() async {
    final data = await StatsService.instance.getStats();
    setState(() {
      pomodoros = data['pomodoro_sessions'] ?? 0;
      studyMinutes = data['study_minutes'] ?? 0;
      cycles = data['cycles_completed'] ?? 0;
      twentyBreaks = data['twenty_rule_breaks'] ?? 0;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Estadísticas"),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Resumen general",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 20),

                  // --- DONUT CHART ---
                  _buildDonutChart(),

                  const SizedBox(height: 40),

                  Text(
                    "Progreso",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 18),

                  // --- BAR CHART ---
                  _buildBarChart(),

                  const SizedBox(height: 40),

                  // --- CARDS RESUMEN ---
                  _summaryCard(
                    "Pomodoros completados",
                    pomodoros.toString(),
                  ),
                  _summaryCard(
                    "Minutos totales de estudio",
                    "$studyMinutes min",
                  ),
                  _summaryCard(
                    "Ciclos completos",
                    cycles.toString(),
                  ),
                  _summaryCard(
                    "Descansos visuales (20-20-20)",
                    twentyBreaks.toString(),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
    );
  }

  // ------------------------
  // DONUT CHART
  // ------------------------
  Widget _buildDonutChart() {
    final total = pomodoros + twentyBreaks + cycles;

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18),
        child: Column(
          children: [
            const Text(
              "Distribución de Actividad",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 230,
              child: PieChart(
                PieChartData(
                  centerSpaceRadius: 55,
                  sectionsSpace: 2,
                  sections: [
                    PieChartSectionData(
                      value: pomodoros.toDouble(),
                      color: AppColors.primary,
                      radius: 60,
                      title: pomodoros > 0 ? "$pomodoros" : "",
                      titleStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    PieChartSectionData(
                      value: twentyBreaks.toDouble(),
                      color: AppColors.secondary,
                      radius: 60,
                      title: twentyBreaks > 0 ? "$twentyBreaks" : "",
                      titleStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    PieChartSectionData(
                      value: cycles.toDouble(),
                      color: const Color(0xFF5CA741),
                      radius: 60,
                      title: cycles > 0 ? "$cycles" : "",
                      titleStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Pomodoros • Descansos visuales • Ciclos",
              style: TextStyle(color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }

  // ------------------------
  // BAR CHART
  // ------------------------
  Widget _buildBarChart() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SizedBox(
          height: 260,
          child: BarChart(
            BarChartData(
              borderData: FlBorderData(show: false),
              gridData: const FlGridData(show: false),
              titlesData: FlTitlesData(
                leftTitles: const AxisTitles(),
                rightTitles: const AxisTitles(),
                topTitles: const AxisTitles(),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 38,
                    getTitlesWidget: (value, meta) {
                      switch (value.toInt()) {
                        case 0:
                          return _barLabel("Pomodoros");
                        case 1:
                          return _barLabel("Visuales");
                        case 2:
                          return _barLabel("Ciclos");
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ),
              barGroups: [
                BarChartGroupData(
                  x: 0,
                  barRods: [
                    BarChartRodData(
                        toY: pomodoros.toDouble(),
                        color: AppColors.primary,
                        width: 32,
                        borderRadius: BorderRadius.circular(6)),
                  ],
                ),
                BarChartGroupData(
                  x: 1,
                  barRods: [
                    BarChartRodData(
                        toY: twentyBreaks.toDouble(),
                        color: AppColors.secondary,
                        width: 32,
                        borderRadius: BorderRadius.circular(6)),
                  ],
                ),
                BarChartGroupData(
                  x: 2,
                  barRods: [
                    BarChartRodData(
                        toY: cycles.toDouble(),
                        color: const Color(0xFF5CA741),
                        width: 32,
                        borderRadius: BorderRadius.circular(6)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _barLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.textDark,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // ------------------------
  // SUMMARY CARDS
  // ------------------------
  Widget _summaryCard(String title, String value) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.textDark,
                    fontWeight: FontWeight.w500)),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
