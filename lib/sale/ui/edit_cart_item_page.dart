import 'package:flutter/material.dart';
import 'package:latte_pos/common/custom.dart';
import 'package:latte_pos/main.dart';
import 'package:latte_pos/sale/model/edit_sale_item_model.dart';
import 'package:latte_pos/sale/model/shopping_cart_model.dart';
import 'package:pos_domain/pos_domain.dart';
import 'package:provider/provider.dart';
import 'package:latte_pos/common/extensions.dart';

class EditCartItemPage extends StatefulWidget {
  final int index;
  final SaleItemDTO item;

  const EditCartItemPage({
    Key key,
    @required this.item,
    this.index,
  })  : assert(item != null),
        super(key: key);

  @override
  _EditCartItemPageState createState() => _EditCartItemPageState();
}

class _EditCartItemPageState extends State<EditCartItemPage> {

  TextEditingController _quantityInputController;

  void _save() {
    final item = context.read<EditSaleItemModel>().getUpdatedItem();
    item.quantity = int.tryParse(_quantityInputController.text);
    if (widget.index != null) {
      context.read<ShoppingCartModel>().update(item, widget.index);
    } else {
      context.read<ShoppingCartModel>().add(item);
    }

    Navigator.of(context).pop();
  }

  @override
  void initState() {
    _quantityInputController = TextEditingController(text: "${widget.item.quantity}");
    super.initState();

    context.read<EditSaleItemModel>().init(widget.item);
  }

  @override
  void dispose() {
    _quantityInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _appBar = AppBar(
      elevation: 0,
      title: Text(
        widget.item.productName,
      ),
      actions: [
        SizedBox(
          width: 70,
          child: FlatButton(
            padding: const EdgeInsets.all(0),
            onPressed: _save,
            shape: CircleBorder(),
            textColor: Colors.white,
            child: Text(
              "label-save".localize().toUpperCase(),
            ),
          ),
        ),
      ],
    );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Consumer<EditSaleItemModel>(
          builder: (context, model, child) {
            return ListView(
              padding: const EdgeInsets.all(rootPadding),
              children: [
                _VariantChoice(),
                POSTextLabel("label-quantity".localize()),
                SizedBox(height: 10),
                Row(
                  children: [
                    _QtyButton(
                      icon: Icons.remove,
                      onPressed: () {
                        int current = int.tryParse(_quantityInputController.text);
                        if (current > 1) {
                          _quantityInputController.text = "${current - 1}";
                        }
                      },
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: POSTextField(
                        controller: _quantityInputController,
                        hint: "label-quantity".localize(),
                        textAlign: TextAlign.center,
                        inputType: TextInputType.numberWithOptions(signed: true, decimal: true),
                        readOnly: true,
                      ),
                    ),
                    SizedBox(width: 16),
                    _QtyButton(
                      icon: Icons.add,
                      onPressed: () {
                        int current = int.tryParse(_quantityInputController.text);
                        _quantityInputController.text = "${current + 1}";
                      },
                    ),
                  ],
                ),
                SizedBox(height: 16),
                _DiscountsChoice(),
              ],
            );
          },
        )
      ),
    );
  }
}

class _VariantChoice extends StatefulWidget {
  @override
  __VariantChoiceState createState() => __VariantChoiceState();
}

class __VariantChoiceState extends State<_VariantChoice> {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<EditSaleItemModel>(context, listen: false);
    final widgets = <Widget>[];
    int len = model.variants.length;

    if (len <= 0) {
      return SizedBox.shrink();
    }

    widgets.add(POSTextLabel("label-variants".localize()));

    widgets.add(SizedBox(height: 10));

    for (int i = 0; i < len; i++) {
      final v = model.variants[i];
      final selected = v.id == model.selectedVariant.id;
      final widget = Material(
        color: selected ? Theme.of(context).primaryColor.withOpacity(0.15) : Colors.white,
        borderRadius: BorderRadius.circular(4),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              width: 0.8,
              color: selected ? Theme.of(context).primaryColor : Colors.grey,
            ),
          ),
          child: ListTile(
            visualDensity: VisualDensity.compact,
            onTap: () {
              setState(() {
                model.selectedVariant = v;
              });
            },
            title: Row(
              children: [
                Builder(
                  builder: (_) {
                    if (selected) {
                      return Icon(Icons.radio_button_checked, color: Theme.of(context).primaryColor);
                    }
                    return Icon(Icons.radio_button_off);
                  },
                ),
                SizedBox(width: 16),
                Text(v.name),
              ],
            ),
            trailing: Text("${v.price.formatCurrency()}"),
          ),
        ),
      );

      widgets.add(widget);

      if (i < len - 1) {
        widgets.add(Divider(color: Colors.transparent));
      }
    }

    widgets.add(SizedBox(height: 16));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: widgets,
    );
  }
}


class _DiscountsChoice extends StatefulWidget {
  @override
  __DiscountsChoiceState createState() => __DiscountsChoiceState();
}

class __DiscountsChoiceState extends State<_DiscountsChoice> {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<EditSaleItemModel>(context, listen: false);
    final widgets = <Widget>[];
    int len = model.discounts.length;

    if (len <= 0) {
      return SizedBox.shrink();
    }

    widgets.add(POSTextLabel("label-discounts".localize()));

    widgets.add(SizedBox(height: 10));

    for (var dto in model.discounts) {
      final selected = model.selectedDiscounts.any((e) => e.id == dto.id);
      final icon = selected ? Icons.check_box_rounded : Icons.check_box_outline_blank_rounded;
      final color = selected ? Theme.of(context).primaryColor : Colors.grey;
      final widget = Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                dto.name,
              ),
            ),
            SizedBox(width: 16),
            Text(
              "${dto.value.formatCurrency()} ${dto.type.name}".trim(),
            ),
            SizedBox(width: 16),
            InkResponse(
              child: Icon(icon, color: color),
              onTap: () {
                setState(() {
                  if (!selected) {
                    model.addDiscount(dto);
                  } else {
                    model.removeDiscount(dto.id);
                  }
                });
              },
            ),
          ],
        ),
      );

      widgets.add(widget);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: widgets,
    );
  }
}

class _QtyButton extends StatelessWidget {

  final IconData icon;
  final VoidCallback onPressed;

  const _QtyButton({Key key, this.onPressed, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 46,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: Theme.of(context).primaryColor,
        ),
      ),
      child: InkWell(
        onTap: onPressed,
        child: Icon(icon, color: Theme.of(context).primaryColor),
      ),
    );
  }
}


