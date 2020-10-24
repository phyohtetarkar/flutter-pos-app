import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:latte_pos/common/extensions.dart';
import 'package:latte_pos/main.dart';
import 'package:latte_pos/report/model/overall_report_model.dart';
import 'package:latte_pos/report/model/sale_by_year_model.dart';
import 'package:pos_domain/pos_domain.dart';
import 'package:provider/provider.dart';

const Map<int, String> _monthsInYear = {
  1: "Jan",
  2: "Feb",
  3: "Mar",
  4: "Apr",
  5: "May",
  6: "Jun",
  7: "Jul",
  8: "Aug",
  9: "Sep",
  10: "Oct",
  11: "Nov",
  12: "Dec",
};

class ReportPage extends StatefulWidget {

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {

  List<PieChartSectionData> _showingSections(List<SaleByCategoryDTO> list, double total) {
    final radius = MediaQuery.of(context).size.width / 3.5;
    return list.map((e) {
      final percentage = (e.totalPrice * 100) ~/ total;
      return PieChartSectionData(
        color: Color(e.color),
        value: percentage.toDouble(),
        title: "$percentage%",
        radius: radius,
        titleStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();
  }

  BarChartData _barChartData(Map<int, double> entries) {
    final largest = entries.values.reduce(max);
    final interval = largest > 0 ? largest ~/ 5 : 500;

    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.black26,
          fitInsideVertically: true,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            //final month = _monthsInYear[group.x + 1];
            return BarTooltipItem(
              "${rod.y.formatCurrency()}",
              TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            );
          },
          fitInsideHorizontally: true,
        ),
        touchCallback: (resp) {},
        handleBuiltInTouches: true,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 16,
          getTextStyles: (value) => const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
          margin: 8,
          getTitles: (value) {
            return _monthsInYear[value.toInt()];
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
          getTitles: (value) {
            return value.formatCompactCurrency();
          },
          interval: interval.toDouble(),
          margin: 8,
          reservedSize: 26,
        ),
        rightTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
          getTitles: (value) {
            return value.formatCompactCurrency();
          },
          interval: interval.toDouble(),
          margin: 8,
          reservedSize: 26,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 0.3,
          ),
          left: BorderSide(
            color: Colors.grey,
            width: 0.3,
          ),
          right: BorderSide(
            color: Colors.grey,
            width: 0.3,
          ),
          top: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
      gridData: FlGridData(
        show: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.grey,
            strokeWidth: 0.3,
          );
        },
        horizontalInterval: interval.toDouble(),
      ),
      barGroups: List.generate(12, (i) => i + 1).map((e) {
        return BarChartGroupData(
          x: e,
          barsSpace: 0,
          barRods: [
            BarChartRodData(
              y: entries[e] ?? 0,
              colors: [Theme.of(context).primaryColor],
              width: 35,
              backDrawRodData: BackgroundBarChartRodData(
                show: true,
                y: largest,
                colors: [Colors.transparent],
              ),
              borderRadius: BorderRadius.circular(0),
            ),
          ],
        );
      }).toList(),
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<OverallReportModel>().find();
    context.read<SaleByYearModel>().find(DateTime.now().year);
  }

  @override
  Widget build(BuildContext context) {
    final _appBar = AppBar(
      title: Text(
        "label-reports".localize(),
      ),
    );
    return Scaffold(
      appBar: _appBar,
      backgroundColor: bgColor,
      body: Stack(
        children: [
          // ClipPath(
          //   //clipper: POSArcClipper(70),
          //   child: Container(
          //     height: 120,
          //     color: Theme.of(context).primaryColor,
          //   ),
          // ),
          ListView(
            padding: const EdgeInsets.all(rootPadding),
            children: [
              Consumer<OverallReportModel>(
                builder: (context, model, child) {
                  return Row(
                    children: [
                      Expanded(
                        child: Card(
                          margin: const EdgeInsets.all(0),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  "label-total-sale".localize(),
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "${model.totalPrice.formatCurrency()}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[600],
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Card(
                          margin: const EdgeInsets.all(0),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  "label-total-profit".localize(),
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "${model.totalProfit.formatCurrency()}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[600],
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: 10),
              Consumer<OverallReportModel>(
                builder: (context, model, child) {
                  if (model.salesByCategory.isEmpty) {
                    return Card(
                      margin: const EdgeInsets.all(0),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              "Sale By Category",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[600],
                                fontSize: 16,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(16),
                              alignment: Alignment.center,
                              child: Text(
                                "No chart data available.",
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return Card(
                    margin: const EdgeInsets.all(0),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "Sale By Category",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[600],
                              fontSize: 16,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              PieChart(
                                PieChartData(
                                  borderData: FlBorderData(
                                    show: false,
                                  ),
                                  sectionsSpace: 2,
                                  centerSpaceRadius: 0,
                                  sections: _showingSections(model.salesByCategory, model.totalSaleByCategory),
                                ),
                              ),
                              Wrap(
                                children: model.salesByCategory.map((e) {
                                  return Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Color(e.color),
                                        radius: 6,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        e.categoryName,
                                      ),
                                    ],
                                  );
                                }).toList(),
                                spacing: 8,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 10),
              Consumer<SaleByYearModel>(
                builder: (context, model, child) {
                  if (model.entries.isEmpty) {
                    return Card(
                      margin: const EdgeInsets.all(0),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              "Monthly Sales",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[600],
                                fontSize: 16,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(16),
                              alignment: Alignment.center,
                              child: Text(
                                "No chart data available.",
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return Card(
                    margin: const EdgeInsets.all(0),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        top: 10,
                        right: 18,
                        bottom: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "Monthly Sales",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[600],
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 6),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Container(
                              width: 580,
                              padding: const EdgeInsets.only(top: 10),
                              child: BarChart(
                                _barChartData(model.entries),
                                swapAnimationDuration: const Duration(milliseconds: 350),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
