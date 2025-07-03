import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class TasbeehChartWidget extends StatelessWidget {
  final List<int> weeklyCounts;

  const TasbeehChartWidget({super.key, required this.weeklyCounts});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Daily Tasbeeh Progress",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 300, // 📏 Grafikni kattalashtirdik
              child: BarChart(
                BarChartData(
                  gridData: FlGridData(show: false), // ✖️ Grid chiziqlarni olib tashlash
                  borderData: FlBorderData(
                    show: true,
                    border: const Border(
                      left: BorderSide(color: Colors.black, width: 1), // faqat chap chiziq
                      bottom: BorderSide(color: Colors.black, width: 1),
                    ),
                  ),
                  titlesData: FlTitlesData(
                    // leftTitles: AxisTitles(
                    //   sideTitles: SideTitles(showTitles: true, reservedSize: 30),
                    // ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        getTitlesWidget: (value, meta) {
                          const days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(days[value.toInt() % 7]),
                          );
                        },
                      ),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false), // ✖️ O‘ng raqamlar yo‘q
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false), // ✖️ Yuqori raqamlar yo‘q
                    ),
                  ),
                  barGroups: List.generate(weeklyCounts.length, (index) {
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: weeklyCounts[index].toDouble(),
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(4),
                          width: 20,
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
