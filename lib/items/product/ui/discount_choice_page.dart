import 'package:flutter/material.dart';
import 'package:latte_pos/common/extensions.dart';
import 'package:latte_pos/items/discount.dart';
import 'package:latte_pos/items/product.dart';
import 'package:latte_pos/main.dart';
import 'package:pos_domain/pos_domain.dart';
import 'package:provider/provider.dart';

class DiscountChoicePage extends StatefulWidget {

  @override
  _DiscountChoicePageState createState() => _DiscountChoicePageState();
}

class _DiscountChoicePageState extends State<DiscountChoicePage> {

  List<DiscountDTO> _selection;

  @override
  void initState() {
    _selection = List.of(context.read<ProductDiscountsModel>().discounts);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<DiscountListModel>(context, listen: false);

    final _appBar = AppBar(
      elevation: 0,
      title: Text(
        "label-choose-discount".localize(),
      ),
      actions: [
        SizedBox(
          width: 70,
          child: FlatButton(
            padding: const EdgeInsets.all(0),
            onPressed: () {
              context.read<ProductDiscountsModel>().addAll(_selection);
              Navigator.of(context).pop();
            },
            shape: CircleBorder(),
            textColor: Colors.white,
            child: Text(
              "label-done".localize().toUpperCase(),
            ),
          ),
        ),
      ],
    );
    return Scaffold(
      backgroundColor: bgColor,
      appBar: _appBar,
      body: StreamBuilder<List<DiscountDTO>>(
        stream: model.getAll(),
        builder: (context, snapshot) {
          return ListView.separated(
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (context, index) {
              final d = snapshot.data[index];
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                color: Colors.white,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(d.name),
                    ),
                    SizedBox(width: 16),
                    Text("${d.value.format()} ${d.type.name}".trim()),
                    SizedBox(width: 16),
                    Checkbox(
                      value: _selection.any((e) => e.id == d.id),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      onChanged: (checked) {
                        setState(() {
                          if (checked) {
                            _selection.add(d);
                          } else {
                            _selection.removeWhere((e) => e.id == d.id);
                          }
                        });
                      },
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => Divider(height: 1, color: Colors.transparent),
          );
        },
      ),
    );
  }
}
