import 'package:flutter/material.dart';
import 'package:latte_pos/common/custom.dart';
import 'package:latte_pos/sale/model/shopping_cart_model.dart';
import 'package:latte_pos/service_locator.dart';
import 'package:provider/provider.dart';
import 'package:latte_pos/common/extensions.dart';

import 'sale_complete_page.dart';

class SaleConfirmPage extends StatelessWidget {

  void _navigateToCompleteSale(BuildContext context, int saleId) {
    final serviceLocator = Provider.of<ServiceLocator>(context, listen: false);
    final route = createRoute(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => serviceLocator.saleCompleteModel),
      ],
      child: SaleCompletePage(saleId: saleId),
    ));

    context.read<ShoppingCartModel>().reset();
    
    Navigator.of(context).pushAndRemoveUntil(route, (route) => route.isFirst);
  }

  void _numClick(BuildContext context, int num) {
    final model = context.read<ShoppingCartModel>();
    String pay = model.payPrice?.toString() ?? '';
    model.setPayPrice(int.tryParse("$pay$num"));
  }

  void _deleteClick(BuildContext context) {
    final model = context.read<ShoppingCartModel>();
    String pay = model.payPrice?.toString() ?? '';
    if (pay.isNotEmpty) {
      model.setPayPrice(int.tryParse(pay.substring(0, pay.length - 1)));
    }
  }

  void _skip(BuildContext context) {
    showDialog<bool>(
      context: context,
      builder: (context) {
        return POSConfirmDialog(
          message: "msg-skip-pay-price".localize(),
          okButtonText: "OK",
        );
      },
    ).then((value) {
      if (value ?? false) {
        _save(context, skip: true);
      }
    });
  }

  void _save(BuildContext context, {bool skip = false}) {
    final model = context.read<ShoppingCartModel>();

    if ((model.change ?? 0) <= 0 && !skip) {
      return;
    }

    if (skip) {
      model.payPrice = null;
      model.change = null;
    }

    model.createSale().then((saleId) {
      _navigateToCompleteSale(context, saleId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final _appBar = AppBar(
      elevation: 0,
      title: Text(
        "label-payment".localize(),
      ),
      actions: [
        SizedBox(
          width: 70,
          child: FlatButton(
            padding: const EdgeInsets.all(0),
            onPressed: () => _skip(context),
            shape: CircleBorder(),
            textColor: Colors.white,
            child: Text(
              "label-skip".localize().toUpperCase(),
            ),
          ),
        ),
      ],
    );
    final labelStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "${'label-total-price'.localize()} : ",
                    textAlign: TextAlign.end,
                    style: labelStyle,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Consumer<ShoppingCartModel>(
                    builder: (context, model, child) {
                      return Text(
                        "${model.totalSalePrice.formatCurrency()}",
                        style: labelStyle,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "${'label-change'.localize()} : ",
                    textAlign: TextAlign.end,
                    style: labelStyle,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Consumer<ShoppingCartModel>(
                    builder: (context, model, child) {
                      return Text(
                        "${model.change?.formatCurrency() ?? 0}",
                        overflow: TextOverflow.ellipsis,
                        style: labelStyle,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: Colors.grey),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: Consumer<ShoppingCartModel>(
                    builder: (context, model, child) {
                      return Text(
                        "${model.payPrice?.formatCurrency() ?? 'hint-pay-price'.localize()}",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: model.payPrice != null ? FontWeight.bold : FontWeight.normal,
                          color: model.payPrice != null ? Colors.black : Colors.grey,
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(width: 10),
                IconButton(
                  onPressed: () => _deleteClick(context),
                  icon: Icon(
                    Icons.backspace,
                    size: 32,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: Colors.grey),
          Expanded(
            child: NumberRow(
              start: 9,
              mid: 8,
              end: 7,
              onClick: (v) => _numClick(context, v),
            ),
          ),
          Divider(height: 1, color: Colors.grey),
          Expanded(
            child: NumberRow(
              start: 4,
              mid: 5,
              end: 6,
              onClick: (v) => _numClick(context, v),
            ),
          ),
          Divider(height: 1, color: Colors.grey),
          Expanded(
            child: NumberRow(
              start: 1,
              mid: 2,
              end: 3,
              onClick: (v) => _numClick(context, v),
            ),
          ),
          Divider(height: 1, color: Colors.grey),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 2,
                  child: InkWell(
                    onTap: () => _numClick(context, 0),
                    child: Center(
                      child: Text(
                        "0",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                VerticalDivider(width: 1, color: Colors.grey),
                Expanded(
                  flex: 1,
                  child: Material(
                    color: Theme.of(context).primaryColor,
                    child: InkWell(
                      onTap: () => _save(context),
                      child: Center(
                        child: Text(
                          "label-pay".localize(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
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
}

typedef NumberClick(int num);

class NumberRow extends StatelessWidget {
  final int start;
  final int mid;
  final int end;
  final NumberClick onClick;

  const NumberRow({
    Key key,
    this.start = 0,
    this.mid = 0,
    this.end = 0,
    this.onClick,
  }) : super(key: key);

  Widget _createNumButton(int num) {
    return InkWell(
      onTap: () => onClick?.call(num),
      child: Center(
        child: Text(
          "$num",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: _createNumButton(start),
        ),
        VerticalDivider(width: 1, color: Colors.grey),
        Expanded(
          child: _createNumButton(mid),
        ),
        VerticalDivider(width: 1, color: Colors.grey),
        Expanded(
          child: _createNumButton(end),
        ),
      ],
    );
  }
}
