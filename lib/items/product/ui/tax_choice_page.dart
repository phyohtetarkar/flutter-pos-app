import 'package:flutter/material.dart';
import 'package:latte_pos/common/extensions.dart';
import 'package:latte_pos/items/product.dart';
import 'package:latte_pos/items/tax.dart';
import 'package:latte_pos/main.dart';
import 'package:pos_domain/pos_domain.dart';
import 'package:provider/provider.dart';

class TaxChoicePage extends StatefulWidget {

  @override
  _TaxChoicePageState createState() => _TaxChoicePageState();
}

class _TaxChoicePageState extends State<TaxChoicePage> {

  List<TaxDTO> _selection;

  @override
  void initState() {
    _selection = List.of(context.read<ProductTaxesModel>().taxes);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<TaxListModel>(context, listen: false);

    final _appBar = AppBar(
      elevation: 0,
      title: Text(
        "label-choose-tax".localize(),
      ),
      actions: [
        SizedBox(
          width: 70,
          child: FlatButton(
            padding: const EdgeInsets.all(0),
            onPressed: () {
              context.read<ProductTaxesModel>().addAll(_selection);
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
      body: StreamBuilder<List<TaxDTO>>(
        stream: model.getAll(),
        builder: (context, snapshot) {
          return ListView.separated(
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (context, index) {
              final t = snapshot.data[index];
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                color: Colors.white,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(t.name),
                    ),
                    SizedBox(width: 16),
                    Text("${t.value.format()}%"),
                    SizedBox(width: 16),
                    Checkbox(
                      value: _selection.any((e) => e.id == t.id),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      onChanged: (checked) {
                        setState(() {
                          if (checked) {
                            _selection.add(t);
                          } else {
                            _selection.removeWhere((e) => e.id == t.id);
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
