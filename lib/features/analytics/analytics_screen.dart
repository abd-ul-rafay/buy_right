import 'package:buy_right/features/analytics/widgets/categories_chart.dart';
import 'package:flutter/material.dart';
import 'analytics_services.dart';
import 'classes/sales.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  bool _isLoading = true;
  List<Sales> _analyticsData = [
    Sales(category: 'Electronics', sales: 0),
    Sales(category: 'Fashion', sales: 0),
    Sales(category: 'Books', sales: 0),
    Sales(category: 'Health', sales: 0),
    Sales(category: 'Furniture', sales: 0),
    Sales(category: 'Entertainment', sales: 0),
    Sales(category: 'Others', sales: 0),
  ];

  double getMaxY(List<Sales> data) {
    double max = 0;

    for (var i in data) {
      if (max < i.sales) {
        max = i.sales;
      }
    }

    final remainder = max ~/ 100;
    return (remainder * 100) + 100;
  }

  void getAnalytics() async {
    _analyticsData = await AnalyticsServices.getAnalytics(context, mounted);

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getAnalytics();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Business Analytics',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              _isLoading
                  ? const Padding(
                    padding: EdgeInsets.only(top: 300.0),
                    child: Center(
                        child: SizedBox(
                          width: 300.0,
                          child: LinearProgressIndicator(),
                        ),
                      ),
                  )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Data Overview',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        ..._analyticsData
                            .map((e) => Padding(
                                  padding: const EdgeInsets.only(bottom: 5.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(e.category),
                                      Expanded(
                                        child: Divider(
                                          thickness: 1,
                                          color: Colors.grey.shade300,
                                          indent: 10.0,
                                          endIndent: 10.0,
                                        ),
                                      ),
                                      Text('\$${e.sales.toStringAsFixed(2)}'),
                                    ],
                                  ),
                                ))
                            .toList(),
                        const SizedBox(
                          height: 25.0,
                        ),
                        const Text(
                          'Bar Chart Representation',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        CategoriesChart(
                          data: _analyticsData.sublist(1),
                          maxY: getMaxY(_analyticsData.sublist(1)),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
