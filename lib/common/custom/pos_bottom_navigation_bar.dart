import 'package:flutter/material.dart';
import 'package:latte_pos/common/custom.dart';
import 'package:latte_pos/main.dart';
import 'package:latte_pos/menu/menu.dart';
import 'package:latte_pos/sale/model/sale_products_search_display.dart';
import 'package:latte_pos/sale/sale.dart';
import 'package:latte_pos/service_locator.dart';
import 'package:latte_pos/summary/summary.dart';
import 'package:provider/provider.dart';

class POSBottomNavigationBar extends StatelessWidget {
  final int currentIndex;

  const POSBottomNavigationBar({
    Key key,
    this.currentIndex = 0,
  }) : super(key: key);

  void _navigate(BuildContext context, int index) {
    final serviceLocator = Provider.of<ServiceLocator>(context, listen: false);
    PageRoute route;
    switch (index) {
      case 0:
        route = createNavRoute(MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => serviceLocator.recentSaleItemsModel),
            ChangeNotifierProvider(create: (_) => serviceLocator.summaryChartDataModel),
          ],
          child: SummaryPage(),
        ));
        break;
      case 1:
        route = createNavRoute(MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => serviceLocator.saleModel),
            ChangeNotifierProvider(create: (_) => SaleProductsSearchDisplay()),
            Provider(create: (_) => Provider.of<ServiceLocator>(context, listen: false).allCategoryModel),
          ],
          child: SalePage(),
        ));
        break;
      case 2:
        route = createNavRoute(MenuPage());
        break;
    }

    if (route != null) {
      Navigator.of(context).pushReplacement(route);
    }
  }

  @override
  Widget build(BuildContext context) {
    const menuImage = AssetImage("images/icons/menu.png");

    return BottomNavigationBar(
      backgroundColor: Colors.white,
      onTap: (index) => _navigate(context, index),
      currentIndex: currentIndex,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: Theme.of(context).accentColor,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.dashboard,
          ),
          label: "Dashboard",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.store_rounded),
          label: "Sale",
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            menuImage,
            size: 22,
            color: Colors.black54,
          ),
          activeIcon: ImageIcon(
            menuImage,
            size: 22,
            color: accentColor,
          ),
          label: "Menu",
        ),
      ],
    );
    // return Stack(
    //   alignment: Alignment.bottomCenter,
    //   children: [
    //     BottomNavigationBar(
    //       elevation: 0,
    //       backgroundColor: Colors.white,
    //       onTap: (index) => _navigate(context, index),
    //       currentIndex: currentIndex,
    //       showSelectedLabels: false,
    //       showUnselectedLabels: false,
    //       selectedItemColor: Theme.of(context).accentColor,
    //       items: const <BottomNavigationBarItem>[
    //         BottomNavigationBarItem(
    //           icon: Icon(
    //             Icons.dashboard,
    //           ),
    //           label: "Dashboard",
    //         ),
    //         BottomNavigationBarItem(
    //           icon: Icon(Icons.store_rounded),
    //           label: "Sale",
    //         ),
    //         BottomNavigationBarItem(
    //           icon: ImageIcon(
    //             menuImage,
    //             size: 22,
    //             color: Colors.black54,
    //           ),
    //           activeIcon: ImageIcon(
    //             menuImage,
    //             size: 22,
    //             color: accentColor,
    //           ),
    //           label: "Menu",
    //         ),
    //       ],
    //     ),
    //     // SafeArea(
    //     //   child: Container(
    //     //     padding: const EdgeInsets.all(6),
    //     //     decoration: ShapeDecoration(
    //     //       color: Colors.white,
    //     //       shape: CircleBorder(),
    //     //     ),
    //     //     child: FlatButton(
    //     //       padding: const EdgeInsets.all(14),
    //     //       onPressed: () => _navigate(context, 1),
    //     //       child: Icon(
    //     //         Icons.store_rounded,
    //     //         color: Colors.white,
    //     //         size: 30,
    //     //       ),
    //     //       color: Theme.of(context).accentColor,
    //     //       shape: CircleBorder(),
    //     //     ),
    //     //   ),
    //     // ),
    //   ],
    // );
  }
}
