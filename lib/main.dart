import 'package:data_source/data_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:latte_pos/sale/sale.dart';
import 'package:latte_pos/service_locator.dart';
import 'package:latte_pos/summary/summary.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common/custom.dart';
import 'sale/model/sale_products_search_display.dart';

const Color bgColor = Color(0xFFf2f2f2);
const Color dangerColor = Color(0xFFD50002);

const double rootPadding = 14.0;
const Color primaryColor = Color(0xFF1AA113);
const Color accentColor = primaryColor;

const String KEY_LOCALE = "KEY_LOCALE";
const String KEY_RECEIPT_HEADER = "KEY_RECEIPT_HEADER";

// POSDatabase _db;
//
// POSDatabase get db => _db;

const String imageRoot = "images";

enum AppLocale {
  EN, MM
}

AppLocale appLocale = AppLocale.EN;

void main() {
  //_db = POSDatabase();

  runApp(
    Provider<ServiceLocator>(
      create: (context) => DefaultServiceLocator(POSDatabase()),
      dispose: (context, s) => s.close(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(
    //   SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    // );
    final serviceLocator = Provider.of<ServiceLocator>(context, listen: false);

    return MaterialApp(
      title: 'POS Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        //primaryColorBrightness: Brightness.dark,
        primaryColor: primaryColor,
        //accentColor: Color(0xFFF9DB6D),
        accentColor: accentColor,
        //accentColor: Color(0xFFff8d00),
        // textTheme: Theme.of(context).textTheme.apply(
        //   fontFamily: "Roboto"
        // ),
        fontFamily: "Pyidaungsu",
        snackBarTheme: Theme.of(context).snackBarTheme.copyWith(
          contentTextStyle: TextStyle(
            color: Colors.white.withOpacity(0.85),
          ),
        ),
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: MultiProvider(
      //   providers: [
      //     ChangeNotifierProvider(create: (_) => Provider.of<ServiceLocator>(context, listen: false).saleModel),
      //     ChangeNotifierProvider(create: (_) => SaleSearchDisplay()),
      //     Provider(create: (_) => Provider.of<ServiceLocator>(context, listen: false).allCategoryModel),
      //   ],
      //   child: SalePage(),
      // ),
      home: LaunchScreenPage(),
    );
  }
}

class LaunchScreenPage extends StatefulWidget {
  @override
  _LaunchScreenPageState createState() => _LaunchScreenPageState();
}

class _LaunchScreenPageState extends State<LaunchScreenPage> {

  Future _load() async {
    final prefs = await SharedPreferences.getInstance();
    appLocale = AppLocale.values[prefs.getInt(KEY_LOCALE) ?? 0];
  }

  @override
  void initState() {
    super.initState();
    _load();
    Future.delayed(Duration(seconds: 3), () {
      final serviceLocator = Provider.of<ServiceLocator>(context, listen: false);
      final route = createRoute(MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => serviceLocator.recentSaleItemsModel),
          ChangeNotifierProvider(create: (_) => serviceLocator.summaryChartDataModel),
        ],
        child: SummaryPage(),
      ));
      Navigator.of(context).pushReplacement(route);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      alignment: Alignment.center,
      child: Material(
        color: Colors.transparent,
        child: Text(
          "Latte POS",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Roboto",
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}


void navigateToSale(BuildContext context) {
  final serviceLocator = Provider.of<ServiceLocator>(context, listen: false);
  final route = createNavRoute(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => serviceLocator.saleModel),
      ChangeNotifierProvider(create: (_) => SaleProductsSearchDisplay()),
      ChangeNotifierProvider(create: (_) => serviceLocator.shoppingCartModel),
      Provider(create: (_) => Provider.of<ServiceLocator>(context, listen: false).allCategoryModel),
    ],
    child: SalePage(),
  ));
  Navigator.of(context).pushReplacement(route);
}
