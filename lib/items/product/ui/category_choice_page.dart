import 'package:flutter/material.dart';
import 'package:latte_pos/common/custom.dart';
import 'package:latte_pos/common/model/all_category_model.dart';
import 'package:latte_pos/items/category.dart';
import 'package:latte_pos/items/product.dart';
import 'package:latte_pos/main.dart';
import 'package:latte_pos/service_locator.dart';
import 'package:pos_domain/pos_domain.dart';
import 'package:provider/provider.dart';
import 'package:latte_pos/common/extensions.dart';

class CategoryChoicePage extends StatelessWidget {

  void _navigateToAdd(BuildContext context) {
    final serviceLocator = Provider.of<ServiceLocator>(context, listen: false);
    final page = Provider<CategoryEditModel>(
      create: (context) => serviceLocator.categoryEditModel,
      child: CategoryEditPage(category: null),
    );
    final route = createModalRoute(page);
    Navigator.of(context).push(route);
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AllCategoryModel>(context, listen: false);

    final _appBar = AppBar(
      elevation: 0,
      title: Text(
        "label-choose-category".localize(),
      ),
    );
    return Scaffold(
      backgroundColor: bgColor,
      appBar: _appBar,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAdd(context),
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
              return Material(
                color: Colors.white,
                child: ListTile(
                  onTap: () {
                    context.read<ProductCategoryModel>().setCategory(c);
                    Navigator.of(context).pop();
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
