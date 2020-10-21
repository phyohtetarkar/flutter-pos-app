import 'dart:io';
import 'dart:typed_data';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:latte_pos/main.dart';
import 'package:latte_pos/sale/model/sale_complete_model.dart';
import 'package:provider/provider.dart';
import 'package:latte_pos/common/extensions.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:ui' as ui;

import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaleCompletePage extends StatefulWidget {
  final int saleId;

  const SaleCompletePage({
    Key key,
    @required this.saleId,
  }) : super(key: key);

  @override
  _SaleCompletePageState createState() => _SaleCompletePageState();
}

class _SaleCompletePageState extends State<SaleCompletePage> {

  GlobalKey _receiptKey = GlobalKey();
  String _receiptHeader;

  Future _shareReceipt() async {
    try {
      RenderRepaintBoundary boundary = _receiptKey.currentContext.findRenderObject();
      ui.Image image = await boundary.toImage(pixelRatio: 4.0);
      ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
      final path = await getTemporaryDirectory();
      final file = File("${path.path}/latte_pos_receipt.png");
      await file.writeAsBytes(pngBytes);
      await Share.shareFiles([file.path], text: "Latte POS Receipt");
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      _receiptHeader = prefs.getString(KEY_RECEIPT_HEADER);
      context.read<SaleCompleteModel>().findDetail(widget.saleId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final _appBar = AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      title: Text(
        "Receipt",
        style: TextStyle(
          fontFamily: "Roboto",
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.share),
          onPressed: _shareReceipt,
        ),
      ],
    );
    return Scaffold(
      backgroundColor: bgColor,
      appBar: _appBar,
      floatingActionButton: FloatingActionButton.extended(
        label: Text(
          "label-new-sale".localize(),
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: RepaintBoundary(
                key: _receiptKey,
                child: Card(
                  margin: const EdgeInsets.all(0),
                  child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: Consumer<SaleCompleteModel>(
                      builder: (context, model, child) {

                        if (model.sale == null || model.items.isEmpty) {
                          return SizedBox.shrink();
                        }

                        final widgets = <Widget>[];

                        final dottedLine = DottedLine(
                          dashColor: Colors.grey[600],
                          dashLength: 2,
                          dashGapLength: 2,
                        );

                        final heading = Padding(
                          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                          child: Text(
                            _receiptHeader ?? "Latte POS",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );

                        widgets.add(heading);

                        final timeAndCode = Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${DateFormat("MMMM dd, yyyy hh:mm a", "en_US").format(model.sale.issueAt)}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              Text(
                                "${model.sale.code}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        );

                        widgets.add(timeAndCode);
                        widgets.add(dottedLine);

                        final tableHeader = Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 30,
                                child: Text(
                                  "Qty",
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "Description",
                                ),
                              ),
                              Text(
                                "Amount",
                              )
                            ],
                          ),
                        );

                        widgets.add(tableHeader);
                        widgets.add(dottedLine);

                        for (var item in model.items) {
                          var desc = item.productName;

                          if (item.variantName != null) {
                            desc += " ${item.variantName}";
                          }

                          desc += " @${item.price.formatCurrency()}";

                          final tableRow = Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 30,
                                  child: Text(
                                    "${item.quantity}",
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    desc,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "${item.total.formatCurrency()}",
                                )
                              ],
                            ),
                          );
                          widgets.add(tableRow);
                        }

                        widgets.add(dottedLine);

                        final subtotal = Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Subtotal",
                                ),
                              ),
                              Text(
                                "${model.sale?.subTotalPrice?.formatCurrency() ?? 0}",
                              )
                            ],
                          ),
                        );

                        final discount = Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Discount",
                                ),
                              ),
                              Text(
                                "-${model.sale?.discount?.formatCurrency() ?? 0}",
                              )
                            ],
                          ),
                        );

                        final tax = Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Tax",
                                ),
                              ),
                              Text(
                                "${model.sale?.tax?.formatCurrency() ?? 0}",
                              )
                            ],
                          ),
                        );

                        widgets.add(subtotal);
                        widgets.add(discount);
                        widgets.add(tax);
                        widgets.add(dottedLine);

                        final total = Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Total Price",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Text(
                                "${model.sale?.totalPrice?.formatCurrency() ?? 0}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                        );

                        widgets.add(total);

                        widgets.add(dottedLine);

                        if (model.sale?.payPrice != null) {
                          final pay = Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Pay",
                                  ),
                                ),
                                Text(
                                  "${model.sale?.payPrice?.formatCurrency() ?? 0}",
                                )
                              ],
                            ),
                          );

                          final change = Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Change",
                                  ),
                                ),
                                Text(
                                  "${model.sale?.change?.formatCurrency() ?? 0}",
                                )
                              ],
                            ),
                          );

                          widgets.add(pay);
                          widgets.add(change);
                          widgets.add(dottedLine);
                        }

                        final footer = Padding(
                          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                          child: Text(
                            "Thank You",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        );
                        widgets.add(footer);

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: widgets,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Material(
          //   color: Theme.of(context).primaryColor,
          //   child: InkWell(
          //     onTap: () => Navigator.of(context).pop(),
          //     child: SafeArea(
          //       child: Container(
          //         height: 54,
          //         alignment: Alignment.center,
          //         child: Text(
          //           "New Sale",
          //           style: TextStyle(
          //             fontSize: 16,
          //             color: Colors.white,
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      )
    );
  }
}
