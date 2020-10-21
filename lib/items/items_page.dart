import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latte_pos/common/custom.dart';
import 'package:latte_pos/items/product/model/product_search_display.dart';
import 'package:latte_pos/main.dart';
import 'package:latte_pos/service_locator.dart';
import 'package:provider/provider.dart';
import 'package:latte_pos/common/extensions.dart';

import 'category.dart';
import 'discount.dart';
import 'product.dart';
import 'tax.dart';

class ItemsPage extends StatelessWidget {
  void _navigate(BuildContext context, int index) {
    final serviceLocator = Provider.of<ServiceLocator>(context, listen: false);
    PageRoute route;
    switch (index) {
      case 0:
        route = createRoute(MultiProvider(
          providers: [
            ChangeNotifierProvider<ProductListModel>(create: (_) => serviceLocator.productListModel),
            ChangeNotifierProvider(create: (_) => ProductSearchDisplay()),
            Provider(create: (_) => serviceLocator.allCategoryModel),
          ],
          child: ProductListPage(),
        ));
        break;
      case 1:
        route = createRoute(
          Provider<CategoryListModel>(
            create: (context) => serviceLocator.categoryListModel,
            child: CategoryListPage(),
          ),
        );
        break;
      case 2:
        route = createRoute(
          Provider<DiscountListModel>(
            create: (context) => serviceLocator.discountListModel,
            child: DiscountListPage(),
          ),
        );
        break;
      case 3:
        route = createRoute(
          Provider<TaxListModel>(
            create: (context) => serviceLocator.taxListModel,
            child: TaxListPage(),
          ),
        );
        break;
    }

    if (route != null) {
      Navigator.of(context).push(route);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _appBar = AppBar(
      title: Text(
        "label-items".localize(),
      ),
    );
    return Scaffold(
      backgroundColor: bgColor,
      appBar: _appBar,
      // body: GridView(
      //   padding: const EdgeInsets.all(8.0),
      //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //     crossAxisCount: 2,
      //     childAspectRatio: 3 / 1,
      //     crossAxisSpacing: 8,
      //     mainAxisSpacing: 8,
      //   ),
      //   children: [
      //     _GirdItemCard(
      //       leading: Icon(FontAwesomeIcons.cubes, color: Colors.black54),
      //       title: "label-products".localize(),
      //       onTap: () => _navigate(context, 0),
      //     ),
      //     _GirdItemCard(
      //       leading: Icon(Icons.widgets, color: Colors.black54),
      //       title: "label-categories".localize(),
      //       onTap: () => _navigate(context, 1),
      //     ),
      //     _GirdItemCard(
      //       leading: Icon(Icons.local_offer, color: Colors.black54),
      //       title: "label-discounts".localize(),
      //       onTap: () => _navigate(context, 2),
      //     ),
      //     _GirdItemCard(
      //       leading: Icon(Icons.attach_money, color: Colors.black54),
      //       title: "label-taxes".localize(),
      //       onTap: () => _navigate(context, 3),
      //     ),
      //   ],
      // ),
      body: Card(
        margin: const EdgeInsets.all(rootPadding),
        clipBehavior: Clip.antiAlias,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(8),
        // ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              onTap: () => _navigate(context, 0),
              title: Row(
                children: [
                  Icon(FontAwesomeIcons.cubes, color: Colors.grey[600]),
                  SizedBox(width: 16),
                  Text("label-products".localize()),
                ],
              ),
            ),
            Divider(
              height: 1,
            ),
            ListTile(
              onTap: () => _navigate(context, 1),
              title: Row(
                children: [
                  Icon(Icons.widgets, color: Colors.grey[600]),
                  SizedBox(width: 16),
                  Text("label-categories".localize()),
                ],
              ),
            ),
            Divider(
              height: 1,
            ),
            ListTile(
              onTap: () => _navigate(context, 2),
              title: Row(
                children: [
                  Icon(Icons.local_offer, color: Colors.grey[600]),
                  SizedBox(width: 16),
                  Text("label-discounts".localize()),
                ],
              ),
            ),
            Divider(
              height: 1,
            ),
            ListTile(
              onTap: () => _navigate(context, 3),
              title: Row(
                children: [
                  Icon(Icons.attach_money, color: Colors.grey[600]),
                  SizedBox(width: 16),
                  Text("label-taxes".localize()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GirdItemCard extends StatelessWidget {
  final Widget leading;
  final String title;
  final VoidCallback onTap;

  const _GirdItemCard({
    Key key,
    this.leading,
    this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0),
      clipBehavior: Clip.antiAlias,
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(8),
      // ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              leading,
              SizedBox(width: 16),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
