import 'package:flutter/material.dart';
import 'package:latte_pos/common/custom.dart';
import 'package:latte_pos/items/discount.dart';
import 'package:latte_pos/main.dart';
import 'package:latte_pos/service_locator.dart';
import 'package:pos_domain/pos_domain.dart';
import 'package:provider/provider.dart';
import 'package:latte_pos/common/extensions.dart';

class DiscountListPage extends StatelessWidget {

  void _navigateToEdit(BuildContext context, {DiscountDTO discount}) {
    final serviceLocator = Provider.of<ServiceLocator>(context, listen: false);
    final page = Provider<DiscountEditModel>(
      create: (context) => serviceLocator.discountEditModel,
      child: DiscountEditPage(discount: discount),
    );
    final route = discount != null ? createRoute(page) : createModalRoute(page);
    Navigator.of(context).push(route);
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<DiscountListModel>(context, listen: false);
    final _appBar = AppBar(
      elevation: 0,
      title: Text(
        "label-discounts".localize(),
      ),
    );

    return Scaffold(
      backgroundColor: bgColor,
      appBar: _appBar,
      floatingActionButton: FloatingActionButton(
        //backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          _navigateToEdit(context);
        },
        child: Icon(
          Icons.add,
          size: 28,
        ),
      ),
      body: StreamBuilder<List<DiscountDTO>>(
        stream: model.getAll(),
        builder: (context, snapshot) {
          return ListView.separated(
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (context, index) {
              final d = snapshot.data[index];
              return Dismissible(
                key: ValueKey(d.id),
                direction: DismissDirection.endToStart,
                confirmDismiss: (direction) {
                  return showDialog<bool>(
                    context: context,
                    builder: (context) {
                      return POSConfirmDialog(
                        message: "msg-confirm-delete".localize(),
                        okButtonText: "label-delete".localize(),
                        okTextColor: dangerColor,
                      );
                    },
                  ).then((value) {
                    if (value ?? false) {
                      return model.delete(d.id).then((value) => true, onError: (error) {
                        final snackBar = SnackBar(
                          content: Text(
                            "Unable to delete discount.",
                          ),
                          backgroundColor: dangerColor,
                        );
                        Scaffold.of(context).showSnackBar(snackBar);
                        return false;
                      });
                    }
                    return false;
                  });
                },
                onDismissed: (direction) {},
                background: Container(
                  color: dangerColor,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                child: Material(
                  color: Colors.white,
                  child: ListTile(
                    onTap: () {
                      _navigateToEdit(context, discount: d);
                    },
                    title: Text(
                      d.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    trailing: Text("${d.value.format()} ${d.type.name}".trim()),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) =>
                Divider(height: 1, color: Colors.transparent),
          );
        },
      ),
    );
  }
}
