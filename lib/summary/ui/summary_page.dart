import 'dart:io';
import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:latte_pos/common/custom.dart';
import 'package:latte_pos/main.dart';
import 'package:latte_pos/summary/model/summary_chart_data_model.dart';
import 'package:latte_pos/summary/model/recent_sale_items_model.dart';
import 'package:pos_domain/pos_domain.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:latte_pos/common/extensions.dart';
import 'dart:math';

const Map<int, String> _weeks = {
  1: "Mon",
  2: "Tue",
  3: "Wed",
  4: "Thu",
  5: "Fri",
  6: "Sat",
  7: "Sun",
};

class SummaryPage extends StatefulWidget {
  @override
  _SummaryPageState createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  //final _dateFormat = DateFormat("hh:mm a", "en_US");

  Widget _buildRecentItem(RecentSaleItemDTO dto) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        height: 70,
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1 / 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: FutureBuilder<File>(
                  future: getImage(dto.image),
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      return Image.file(
                        snapshot.data,
                        fit: BoxFit.cover,
                      );
                    }
                    return Image.asset(
                      "images/placeholder.png",
                      fit: BoxFit.fill,
                    );
                  },
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Builder(
                builder: (context) {
                  final title = Text(
                    dto.productName,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  );
                  if (dto.variantName != null) {
                    final subTitle = Text(
                      dto.variantName,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    );

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        title,
                        //SizedBox(height: 4),
                        subTitle,
                      ],
                    );
                  }

                  return title;
                },
              ),
            ),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${dto.price.formatCurrency()}",
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                //SizedBox(height: 4),
                Text(
                  "${dto.quantity} x",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<File> getImage(String image) async {
    if (image == null) {
      return null;
    }

    var dir = await getApplicationDocumentsDirectory();
    var file = File("${dir.path}/$imageRoot/$image");

    return (await file.exists()) ? file : null;
  }

  LineChartData _chartData(Map<int, double> entries) {
    final largest = entries.values.reduce(max);
    final interval = largest > 0 ? largest ~/ 5 : 500;

    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.white.withOpacity(0.3),
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
        ),
        touchCallback: (resp) {},
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(
        show: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.white,
            strokeWidth: 0.3,
          );
        },
        horizontalInterval: interval.toDouble(),
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 16,
          getTextStyles: (value) => const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
          margin: 8,
          getTitles: (value) {
            return _weeks[value.toInt()];
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
          getTitles: (value) {
            return value.formatCompactCurrency();
          },
          interval: interval.toDouble(),
          margin: 8,
          reservedSize: 24,
        ),
        rightTitles: SideTitles(
          showTitles: true,
          reservedSize: 8,
          getTitles: (value) => "",
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(
            color: Colors.white,
            width: 0.3,
          ),
          left: BorderSide(
            color: Colors.white,
            width: 0.3,
          ),
          right: BorderSide(
            color: Colors.transparent,
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
      spots: List.generate(7, (i) => i + 1).map((e) {
        return FlSpot(e.toDouble(), entries[e] ?? 0.0);
      }).toList(),
      isCurved: true,
      colors: [
        Colors.white,
      ],
      barWidth: 1.5,
      isStrokeCapRound: false,
      preventCurveOverShooting: true,
      curveSmoothness: 0.45,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: true,
        colors: [
          Colors.white.withOpacity(0.3),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<RecentSaleItemsModel>().find();
    context.read<SummaryChartDataModel>().find();
  }

  @override
  Widget build(BuildContext context) {

    final _appBar = AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      title: Text(
        "Dashboard",
        style: TextStyle(
          fontFamily: "Roboto",
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: bgColor,
      brightness: Brightness.light,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(1),
        child: Divider(height: 1, color: Colors.grey),
      ),
    );
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Scaffold(
          backgroundColor: bgColor,
          appBar: _appBar,
          bottomNavigationBar: POSBottomNavigationBar(
            currentIndex: 0,
          ),
          body: Stack(
            children: [
              ClipPath(
                //clipper: POSArcClipper(70),
                child: Container(
                  height: 120,
                  color: bgColor,
                ),
              ),
              ListView(
                padding: const EdgeInsets.all(rootPadding),
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.7,
                    child: Card(
                      elevation: 4,
                      margin: const EdgeInsets.all(0),
                      color: Theme.of(context).primaryColor,
                      // decoration: BoxDecoration(
                      //   color: Theme.of(context).primaryColor,
                      //   borderRadius: BorderRadius.circular(4),
                      //   boxShadow: [
                      //     BoxShadow(
                      //       color: Colors.grey[600].withOpacity(0.45),
                      //       blurRadius: 8,
                      //       spreadRadius: 2,
                      //       offset: Offset(0.6, 0.6),
                      //     )
                      //   ],
                      // ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              "label-weekly-sales".localize(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 16),
                            Expanded(
                              child: Consumer<SummaryChartDataModel>(
                                builder: (context, model, child) {
                                  //print(model.entries);
                                  // if (model.entries.isEmpty) {
                                  //   return Center(
                                  //     child: Text(
                                  //       "No chart data available.",
                                  //       style: TextStyle(
                                  //         color: Colors.white,
                                  //       ),
                                  //     ),
                                  //   );
                                  // }
                                  final empty = _weeks.map((key, value) => MapEntry(key, 0.0));
                                  final entries = model.entries.isNotEmpty ? model.entries : empty;

                                  return LineChart(
                                    _chartData(entries),
                                    swapAnimationDuration: const Duration(milliseconds: 350),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Consumer<RecentSaleItemsModel>(
                    builder: (context, model, child) {
                      final widgets = <Widget>[];
                      final len = model.recentItems.length;

                      final heading = Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          "label-recent-sales".localize(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                            fontSize: 16,
                          ),
                        ),
                      );

                      final divider = Divider(height: 1, color: Colors.grey[300]);

                      widgets.add(heading);
                      widgets.add(divider);

                      if (len <= 0) {
                        final noData = Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            "label-no-sale-today".localize(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        );
                        widgets.add(noData);
                      } else {
                        for (int i = 0; i < len; i++) {
                          widgets.add(_buildRecentItem(model.recentItems[i]));

                          if (i < len - 1) {
                            widgets.add(divider);
                          }
                        }
                      }

                      return Card(
                        margin: const EdgeInsets.all(0),
                        elevation: 0,
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                          side: BorderSide(
                            color: Colors.grey[400],
                            width: 0.5,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: widgets,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        SafeArea(
          child: Container(
            //padding: const EdgeInsets.all(6),
            margin: EdgeInsets.only(
              bottom: Platform.isAndroid ? 12 : 6,
            ),
            decoration: ShapeDecoration(
              color: Theme.of(context).accentColor,
              shape: CircleBorder(),
              shadows: [
                BoxShadow(
                  color: Theme.of(context).accentColor.withOpacity(0.35),
                  blurRadius: 8,
                  spreadRadius: 1.5,
                  offset: Offset(0.6, 0.6),
                ),
              ],
            ),
            child: FlatButton(
              padding: const EdgeInsets.all(14),
              onPressed: () => navigateToSale(context),
              child: Icon(
                Icons.store_rounded,
                color: Colors.white,
                size: 30,
              ),
              color: Theme.of(context).accentColor,
              shape: CircleBorder(),
            ),
          ),
        ),
      ],
    );
  }
}
