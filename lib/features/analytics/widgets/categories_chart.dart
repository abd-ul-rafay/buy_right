import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../classes/bar_data.dart';
import '../classes/sales.dart';

class CategoriesChart extends StatelessWidget {
  final List<Sales> data;
  final double maxY;

  const CategoriesChart({
    Key? key,
    required this.data,
    required this.maxY,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myBarData = BarData(
      electronics: data[0].sales,
      fashion: data[1].sales,
      books: data[2].sales,
      health: data[3].sales,
      furniture: data[4].sales,
      entertainment: data[5].sales,
      other: data[6].sales,
    );

    myBarData.initializeBarData();

    return SizedBox(
      height: 350.0,
      child: BarChart(
        BarChartData(
          maxY: maxY,
          minY: 0,
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            show: true,
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: bottomTitles,
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                reservedSize: 40.0,
                showTitles: true,
                getTitlesWidget: (value, _) {
                  return Text(
                    '\$${value.toInt()}',
                    style: const TextStyle(fontSize: 10.0,),
                    textAlign: TextAlign.end,
                  );
                },
              ),
            ),
          ),
          barGroups: myBarData.barData
              .map(
                (i) => BarChartGroupData(
                  x: i.x,
                  barRods: [
                    BarChartRodData(
                      toY: i.y,
                      color: Colors.grey.shade800,
                      width: 25.0,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(4),
                        bottomRight: Radius.zero,
                        bottomLeft: Radius.zero,
                      ),
                      backDrawRodData: BackgroundBarChartRodData(
                        show: true,
                        toY: 100,
                        color: Colors.grey.shade200,
                      ),
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

Widget bottomTitles(double value, TitleMeta meta) {
  const style = TextStyle(fontSize: 10.0);

  late final Widget text;

  switch (value.toInt()) {
    case 0:
      text = const Text('Elec.', style: style);
      break;
    case 1:
      text = const Text('Fash.', style: style);
      break;
    case 2:
      text = const Text('Books', style: style);
      break;
    case 3:
      text = const Text('Health', style: style);
      break;
    case 4:
      text = const Text('Furn.', style: style);
      break;
    case 5:
      text = const Text('Enter.', style: style);
      break;
    case 6:
      text = const Text('Others', style: style);
      break;
    default:
      text = const Text('Undefined', style: style);
      break;
  }

  return Padding(
    padding: const EdgeInsets.only(top: 2.0),
    child: text,
  );
}
