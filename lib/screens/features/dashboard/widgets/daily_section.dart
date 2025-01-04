import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:my_finance/common/gap.dart';
import 'package:my_finance/utils/color.dart';
import 'package:my_finance/utils/typography.dart';

class DailySection extends StatefulWidget {
  const DailySection({super.key});

  @override
  State<StatefulWidget> createState() => DailySectionState();
}

class DailySectionState extends State<DailySection> {
  List<Color> gradientColors = [
    Colors.cyan,
    Colors.blue,
  ];

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.bar_chart,
                    color: textColor,
                    size: 24,
                  ),
                  const HorizontalGap5(),
                  Text(
                    'Dayly Transaction',
                    style: poppinsH4.copyWith(
                      color: textColor,
                    ),
                  ),
                ],
              ),
              // InkWell(
              //   onTap: () {},
              //   child: const Icon(
              //     Icons.arrow_circle_right,
              //     color: textColor,
              //     size: 28,
              //   ),
              // )
            ],
          ),
          const VerticalGap10(),
          // const VerticalGap20(),
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: secondaryColor,
            ),
            child: Column(
              children: [
                AspectRatio(
                  aspectRatio: 1.70,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: 20,
                      left: 10,
                      top: 10,
                      bottom: 10,
                    ),
                    child: LineChart(
                      mainData(),
                      // showAvg ? avgData() : mainData(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    List<String> labels = [
      'Senin',
      'Selasa',
      'Rabu',
      'Kamis',
      'Jumat',
      'Sabtu',
      'Minggu'
    ];
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12,
      color: textColor,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = Text(labels[0], style: style);
        break;
      case 2:
        text = Text(labels[1], style: style);
        break;
      case 4:
        text = Text(labels[2], style: style);
        break;
      case 6:
        text = Text(labels[3], style: style);
        break;
      case 8:
        text = Text(labels[4], style: style);
        break;
      case 10:
        text = Text(labels[5], style: style);
        break;
      case 12:
        text = Text(labels[6], style: style);
        break;
      default:
        text = Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    List<String> labels = ['10K', '30K', '50K', '70K', '90K'];
    const style =
        TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: textColor);
    String text;
    switch (value.toInt()) {
      case 1:
        text = labels[0];
        break;
      case 3:
        text = labels[1];
        break;
      case 5:
        text = labels[2];
        break;
      case 7:
        text = labels[3];
        break;
      case 9:
        text = labels[4];
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Colors.white10,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Colors.white10,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            // getTitlesWidget: leftTitleWidgets,
            reservedSize: 30,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 12,
      minY: 0,
      maxY: 10,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 2),
            FlSpot(2, 2),
            FlSpot(4, 5),
            FlSpot(6, 3.1),
            FlSpot(8, 4),
            FlSpot(10, 3),
            FlSpot(12, 4),
            // FlSpot(11, 4),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          isStrokeJoinRound: true,
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: true,
          ),
          showingIndicators: const [10, 10, 10, 10, 10, 10, 10, 10],
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withValues(alpha: 0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
