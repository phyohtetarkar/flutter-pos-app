import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latte_pos/common/custom.dart';
import 'package:latte_pos/main.dart';
import 'package:latte_pos/sale/model/shopping_cart_model.dart';
import 'package:latte_pos/sale/ui/edit_cart_item_page.dart';
import 'package:latte_pos/sale/ui/sale_confirm_page.dart';
import 'package:latte_pos/service_locator.dart';
import 'package:pos_domain/pos_domain.dart';
import 'package:provider/provider.dart';
import 'package:latte_pos/common/extensions.dart';

class CartItemsPage extends StatelessWidget {

  void _navigateToEditItem(BuildContext context, SaleItemDTO item, int index) {
    final route = createRoute(MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: context.read<ShoppingCartModel>()),
        ChangeNotifierProvider(create: (context) => Provider.of<ServiceLocator>(context, listen: false).editSaleItemModel),
      ],
      child: EditCartItemPage(item: item, index: index),
    ));
    Navigator.of(context).push(route);
  }

  void _navigateToConfirm(BuildContext context) {
    final route = createRoute(MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: context.read<ShoppingCartModel>()),
      ],
      child: SaleConfirmPage(),
    ));
    Navigator.of(context).push(route).then((_) {
      final model = context.read<ShoppingCartModel>();
      model.payPrice = null;
      model.change = null;
    });
  }

  void _delete(BuildContext context) {
    showDialog<bool>(
      context: context,
      builder: (context) {
        return POSConfirmDialog(
          message: "msg-remove-all".localize(),
          okButtonText: "label-remove".localize().toUpperCase(),
          okTextColor: dangerColor,
        );
      },
    ).then((value) {
      if (value ?? false) {
        context.read<ShoppingCartModel>().removeAll();
        Navigator.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final _appBar = AppBar(
      elevation: 0,
      title: Text(
        "label-shopping-cart".localize(),
      ),
      actions: [
        IconButton(
          icon: Icon(FontAwesomeIcons.trashAlt, size: 20),
          onPressed: () => _delete(context),
        ),
      ],
    );
    final labelStyle = TextStyle(
      fontSize: 16,
    );
    return Scaffold(
      backgroundColor: bgColor,
      appBar: _appBar,
      body: Consumer<ShoppingCartModel>(
        builder: (context, model, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ListView.separated(
                  itemCount: model.items.length,
                  itemBuilder: (context, index) {
                    final e = model.items[index];
                    return Dismissible(
                      key: Key("${index}_${e.productId}_${e.variantId ?? '0'}"),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: dangerColor,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      onDismissed: (direction) => model.remove(e),
                      child: Material(
                        color: Colors.white,
                        child: ListTile(
                          onTap: () {
                            _navigateToEditItem(context, e, index);
                          },
                          //visualDensity: VisualDensity.comfortable,
                          title: Text(
                            e.productName,
                            overflow: TextOverflow.ellipsis,
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
                                            )
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
                          "${model.subTotalPrice.formatCurrency()}",
                        ),
                      ),
                      Builder(
                        builder: (_) {
                          if (model.discount > 0) {
                            return ListTile(
                              dense: true,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                              visualDensity: VisualDensity.compact,
                              leading: Text(
                                "label-discount".localize(),
                                style: labelStyle,
                              ),
                              trailing: Text(
                                "-${model.discount.formatCurrency()}",
                              ),
                            );
                          }
                          return SizedBox.shrink();
                        },
                      ),
                      Builder(
                        builder: (_) {
                          if (model.tax > 0) {
                            return ListTile(
                              dense: true,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                              visualDensity: VisualDensity.compact,
                              leading: Text(
                                "label-tax".localize(),
                                style: labelStyle,
                              ),
                              trailing: Text(
                                "${model.tax.formatCurrency()}",
                              ),
                            );
                          }
                          return SizedBox.shrink();
                        },
                      ),
                      Divider(),
                      ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                        visualDensity: VisualDensity.compact,
                        leading: Text(
                          "label-total-price".localize(),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Text(
                          "${model.totalPrice.formatCurrency()}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        height: 48,
                        child: RaisedButton(
                          onPressed: () {
                            if (model.items.isNotEmpty) {
                              _navigateToConfirm(context);
                            }
                          },
                          colorBrightness: Brightness.dark,
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          //padding: const EdgeInsets.symmetric(vertical: 14),
                          color: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            "label-charge".localize(),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
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
