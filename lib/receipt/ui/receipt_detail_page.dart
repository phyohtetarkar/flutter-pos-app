import 'package:flutter/material.dart';
import 'package:latte_pos/main.dart';
import 'package:latte_pos/receipt/model/receipt_detail_model.dart';
import 'package:provider/provider.dart';
import 'package:latte_pos/common/extensions.dart';

class ReceiptDetailPage extends StatefulWidget {
  final int saleId;

  const ReceiptDetailPage({
    Key key,
    @required this.saleId,
  }) : super(key: key);

  @override
  _ReceiptDetailPageState createState() => _ReceiptDetailPageState();
}

class _ReceiptDetailPageState extends State<ReceiptDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<ReceiptDetailModel>().findDetail(widget.saleId);
  }

  @override
  Widget build(BuildContext context) {
    final _appBar = AppBar(
      elevation: 0,
      title: Text(
        "label-sale-items".localize(),
      ),
    );
    final labelStyle = TextStyle(
      fontSize: 16,
    );
    return Scaffold(
      backgroundColor: bgColor,
      appBar: _appBar,
      body: Consumer<ReceiptDetailModel>(
        builder: (context, model, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ListView.separated(
                  itemCount: model.items.length,
                  itemBuilder: (context, index) {
                    final e = model.items[index];
                    return Material(
                      color: Colors.white,
                      child: ListTile(
                        onTap: () {},
                        //visualDensity: VisualDensity.comfortable,
                        title: Text(
                          e.productName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: e.variantName != null
                            ? Text(
                                e.variantName,
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              )
                            : null,
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("${e.quantity}  x"),
                            SizedBox(width: 8),
                            Builder(
                              builder: (_) {
                                if (e.discount > 0) {
                                  return Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "${e.price.formatCurrency()}\n",
                                          style: TextStyle(
                                            color: Colors.grey,
                                            decoration: TextDecoration.lineThrough,
                                          ),
                                        ),
                                        TextSpan(
                                          text: "${(e.price - e.computedSingleDiscount).formatCurrency()}",
                                        ),
                                      ],
                                    ),
                                    textAlign: TextAlign.end,
                                  );
                                }
                                return Text("${e.price.formatCurrency()}");
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(height: 1, color: Colors.transparent),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 8,
                  right: 16,
                  bottom: 16,
                ),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey,
                      width: 0.5,
                    ),
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ListTile(
                        dense: true,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                        visualDensity: VisualDensity.compact,
                        leading: Text(
                          "label-subtotal".localize(),
                          style: labelStyle,
                        ),
                        trailing: Text(
                          "${model.sale?.subTotalPrice?.formatCurrency() ?? 0}",
                        ),
                      ),
                      ListTile(
                        dense: true,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                        visualDensity: VisualDensity.compact,
                        leading: Text(
                          "label-discount".localize(),
                          style: labelStyle,
                        ),
                        trailing: Text(
                          "-${model.sale?.discount?.formatCurrency() ?? 0}",
                        ),
                      ),
                      ListTile(
                        dense: true,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                        visualDensity: VisualDensity.compact,
                        leading: Text(
                          "label-tax".localize(),
                          style: labelStyle,
                        ),
                        trailing: Text(
                          "${model.sale?.tax?.formatCurrency() ?? 0}",
                        ),
                      ),
                      Divider(color: Colors.grey[400]),
                      ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                        visualDensity: VisualDensity.compact,
                        leading: Text(
                          "label-total-price".localize(),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        trailing: Text(
                          "${model.sale?.totalPrice?.formatCurrency() ?? 0}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
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
    );
  }
}
