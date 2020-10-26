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

  int year;

  List<PieChartSectionData> _showingSections(List<SaleByCategoryDTO> list, double total) {
    final radius = 120.0;
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
    final interval = largest > 0 ? largest ~/ 4 : 500;

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
          getTextStyles: (value) => TextStyle(
            color: Colors.grey[600],
            fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
          margin: 8,
          getTitles: (value) {
            return _monthsInYear[value.toInt()] ?? "";
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => TextStyle(
            color: Colors.grey[600],
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
          getTextStyles: (value) => TextStyle(
            color: Colors.grey[600],
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
              width: 20,
              backDrawRodData: BackgroundBarChartRodData(
                show: true,
                y: largest,
                colors: [Colors.transparent],
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  LineChartData _lineChartData(Map<int, double> entries) {
    final largest = entries.values.reduce(max);
    final interval = largest > 0 ? largest ~/ 4 : 500;

    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Theme.of(context).primaryColor.withOpacity(0.6),
          getTooltipItems: (list) {
            return list.map((e) {
              return LineTooltipItem(
                e.y.formatCurrency(),
                TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              );
            }).toList();
          },
          fitInsideHorizontally: true,
          fitInsideVertically: true,
        ),
        touchCallback: (resp) {},
        handleBuiltInTouches: true,
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
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 16,
          getTextStyles: (value) => TextStyle(
            color: Colors.grey[600],
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
          getTextStyles: (value) => TextStyle(
            color: Colors.grey[600],
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
          getTextStyles: (value) => TextStyle(
            color: Colors.grey[600],
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
      lineBarsData: [_lineChartBarData(entries)],
    );
  }

  LineChartBarData _lineChartBarData(Map<int, double> entries) {
    return LineChartBarData(
      spots: List.generate(12, (i) => i + 1).map((e) {
        return FlSpot(e.toDouble(), entries[e] ?? 0.0);
      }).toList(),
      isCurved: true,
      colors: [
        Theme.of(context).primaryColor,
      ],
      barWidth: 3,
      isStrokeCapRound: false,
      preventCurveOverShooting: true,
      curveSmoothness: 0.45,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: true,
        colors: [
          Theme.of(context).primaryColor.withOpacity(0.2),
        ],
      ),
    );
  }

  @override
  void initState() {
    year = DateTime.now().year;
    super.initState();
    context.read<OverallReportModel>().find();
    context.read<SaleByYearModel>().find(year);
  }

  @override
  Widget build(BuildContext context) {
    final _appBar = AppBar(
      elevation: 0,
      title: Text(
        "label-reports".localize(),
      ),
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.only(
      //     bottomLeft: Radius.circular(24),
      //     bottomRight: Radius.circular(24),
      //   ),
      // ),
      // bottom: PreferredSize(
      //   preferredSize: Size.fromHeight(80),
      //   child: Container(
      //     alignment: Alignment.center,
      //     height: 80,
      //     padding: const EdgeInsets.symmetric(vertical: 10),
      //     child: Consumer<OverallReportModel>(
      //       builder: (context, model, child) {
      //         return Row(
      //           crossAxisAlignment: CrossAxisAlignment.stretch,
      //           mainAxisAlignment: MainAxisAlignment.spaceAround,
      //           children: [
      //             Expanded(
      //               child: Align(
      //                 alignment: Alignment.center,
      //                 child: Column(
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: [
      //                     Text(
      //                       "label-total-sale".localize(),
      //                       overflow: TextOverflow.ellipsis,
      //                       style: TextStyle(
      //                         fontWeight: FontWeight.bold,
      //                         fontSize: 16,
      //                         color: Colors.white.withOpacity(0.8),
      //                       ),
      //                     ),
      //                     SizedBox(height: 8),
      //                     Text(
      //                       "${model.totalPrice.formatCurrency()}",
      //                       style: TextStyle(
      //                         fontWeight: FontWeight.bold,
      //                         color: Colors.white,
      //                         fontSize: 16,
      //                         fontFamily: "Roboto",
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //             ),
      //             VerticalDivider(width: 1, color: Colors.white54),
      //             Expanded(
      //               child: Align(
      //                 alignment: Alignment.center,
      //                 child: Column(
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: [
      //                     Text(
      //                       "label-total-profit".localize(),
      //                       overflow: TextOverflow.ellipsis,
      //                       style: TextStyle(
      //                         fontWeight: FontWeight.bold,
      //                         fontSize: 16,
      //                         color: Colors.white.withOpacity(0.8),
      //                       ),
      //                     ),
      //                     SizedBox(height: 8),
      //                     Text(
      //                       "${model.totalProfit.formatCurrency()}",
      //                       style: TextStyle(
      //                         fontWeight: FontWeight.bold,
      //                         color: Colors.white,
      //                         fontSize: 16,
      //                         fontFamily: "Roboto",
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //             ),
      //           ],
      //         );
      //       },
      //     ),
      //   ),
      // ),
    );
    return Scaffold(
      appBar: _appBar,
      backgroundColor: bgColor,
      body: Stack(
        children: [
          ClipPath(
            //clipper: POSArcClipper(70),
            child: Container(
              height: 60,
              color: Theme.of(context).primaryColor,
            ),
          ),
          ListView(
            padding: const EdgeInsets.only(
              top: 8,
              left: rootPadding,
              right: rootPadding,
              bottom: rootPadding,
            ),
            children: [
              // Consumer<OverallReportModel>(
              //   builder: (context, model, child) {
              //     return Row(
              //       children: [
              //         Expanded(
              //           child: Card(
              //             margin: const EdgeInsets.all(0),
              //             //color: Colors.purple,
              //             child: Padding(
              //               padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
              //               child: Column(
              //                 crossAxisAlignment: CrossAxisAlignment.stretch,
              //                 children: [
              //                   Text(
              //                     "label-total-sale".localize(),
              //                     overflow: TextOverflow.ellipsis,
              //                     style: TextStyle(
              //                       fontWeight: FontWeight.bold,
              //                       fontSize: 16,
              //                       //color: Colors.white,
              //                     ),
              //                   ),
              //                   SizedBox(height: 8),
              //                   Text(
              //                     "${model.totalPrice.formatCurrency()}",
              //                     style: TextStyle(
              //                       fontWeight: FontWeight.bold,
              //                       color: Colors.grey[600],
              //                       fontSize: 16,
              //                       fontFamily: "Roboto",
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           ),
              //         ),
              //         SizedBox(width: 10),
              //         Expanded(
              //           child: Card(
              //             margin: const EdgeInsets.all(0),
              //             //color: Colors.blue[600],
              //             child: Padding(
              //               padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
              //               child: Column(
              //                 crossAxisAlignment: CrossAxisAlignment.stretch,
              //                 children: [
              //                   Text(
              //                     "label-total-profit".localize(),
              //                     overflow: TextOverflow.ellipsis,
              //                     style: TextStyle(
              //                       fontWeight: FontWeight.bold,
              //                       fontSize: 16,
              //                       //color: Colors.white,
              //                     ),
              //                   ),
              //                   SizedBox(height: 8),
              //                   Text(
              //                     "${model.totalProfit.formatCurrency()}",
              //                     style: TextStyle(
              //                       fontWeight: FontWeight.bold,
              //                       color: Colors.grey[600],
              //                       fontSize: 16,
              //                       fontFamily: "Roboto",
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           ),
              //         ),
              //       ],
              //     );
              //   },
              // ),
              // SizedBox(height: 10)
              Card(
                margin: const EdgeInsets.all(0),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                  height: 100,
                  child: Consumer<OverallReportModel>(
                    builder: (context, model, child) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.center,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "label-total-sale".localize(),
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "${model.totalPrice.formatCurrency()}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 20,
                                      fontFamily: "Roboto",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          VerticalDivider(width: 28, color: Colors.grey[400]),
                          Expanded(
                            child: Align(
                              alignment: Alignment.center,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "label-total-profit".localize(),
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "${model.totalProfit.formatCurrency()}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 20,
                                      fontFamily: "Roboto",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 10),
              Consumer<OverallReportModel>(
                builder: (context, model, child) {
                  Widget bodyView;

                  if (model.salesByCategory.isEmpty) {
                    bodyView = Container(
                      padding: const EdgeInsets.all(16),
                      alignment: Alignment.center,
                      child: Text(
                        "No chart data available.",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    );
                  } else {
                    bodyView = Column(
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
                    );
                  }

                  return Card(
                    margin: const EdgeInsets.all(0),
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "label-sale-by-category".localize(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700],
                              fontSize: 16,
                            ),
                          ),
                          bodyView,
                        ],
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 10),
              Consumer<SaleByYearModel>(
                builder: (context, model, child) {
                  Widget bodyView;
                  if (model.entries.isEmpty) {
                    bodyView = Container(
                      padding: const EdgeInsets.all(16),
                      alignment: Alignment.center,
                      child: Text(
                        "No chart data available.",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    );
                  } else {
                    final screenWidth = MediaQuery.of(context).size.width;
                    if (screenWidth > 580) {
                      bodyView = Container(
                        padding: const EdgeInsets.only(top: 24),
                        child: BarChart(
                          _barChartData(model.entries),
                          swapAnimationDuration: const Duration(milliseconds: 350),
                        ),
                      );
                    } else {
                      bodyView = SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          width: 580,
                          padding: const EdgeInsets.only(top: 24),
                          child: BarChart(
                            _barChartData(model.entries),
                            swapAnimationDuration: const Duration(milliseconds: 350),
                          ),
                        ),
                      );
                    }
                  }

                  // final empty = _monthsInYear.map((key, value) => MapEntry(key, 0.0));
                  // final entries = model.entries.isNotEmpty ? model.entries : empty;

                  return Card(
                    margin: const EdgeInsets.all(0),
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "label-monthly-sale".localize(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[700],
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  context.read<SaleByYearModel>().find(year);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  child: Text(
                                    "2020",
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      fontFamily: "Roboto",
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 6),
                          bodyView,
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
