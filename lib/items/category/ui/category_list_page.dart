import 'package:flutter/material.dart';
import 'package:latte_pos/common/custom.dart';
import 'package:latte_pos/items/category.dart';
import 'package:latte_pos/items/category/model/category_list_model.dart';
import 'package:latte_pos/main.dart';
import 'package:latte_pos/service_locator.dart';
import 'package:pos_domain/pos_domain.dart';
import 'package:provider/provider.dart';
import 'package:latte_pos/common/extensions.dart';

class CategoryListPage extends StatelessWidget {
  void _navigateToEdit(BuildContext context, {CategoryDTO category}) {
    final serviceLocator = Provider.of<ServiceLocator>(context, listen: false);
    final page = Provider<CategoryEditModel>(
      create: (context) => serviceLocator.categoryEditModel,
      child: CategoryEditPage(category: category),
    );
    final route = category != null ? createRoute(page) : createModalRoute(page);
    Navigator.of(context).push(route);
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<CategoryListModel>(context, listen: false);
    final _appBar = AppBar(
      elevation: 0,
      title: Text(
        "label-categories".localize(),
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
      body: StreamBuilder<List<CategoryDTO>>(
        stream: model.getAll(),
        builder: (context, snapshot) {
          return ListView.separated(
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (context, index) {
              final c = snapshot.data[index];
              return Dismissible(
                key: Key("${c.id}"),
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
                      return model.delete(c.id).then((value) => true, onError: (error) {
                        final snackBar = SnackBar(
                          content: Text(
                            "Unable to delete category.",
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
                      _navigateToEdit(context, category: c);
                    },
                    leading: CircleAvatar(
                      backgroundColor: Color(c.color),
                      radius: 20,
                    ),
                    title: Text(
                      c.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    subtitle: Text("${c.product} Product${c.product > 1 ? 's' : ''}"),
                  ),
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
