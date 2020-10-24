import 'dart:io';

import 'package:flutter/material.dart';
import 'package:latte_pos/common/custom.dart';
import 'package:latte_pos/items/items_page.dart';
import 'package:latte_pos/main.dart';
import 'package:latte_pos/menu/ui/about_page.dart';
import 'package:latte_pos/receipt/ui/receipt_list_page.dart';
import 'package:latte_pos/report/ui/report_page.dart';
import 'package:latte_pos/service_locator.dart';
import 'package:provider/provider.dart';
import 'package:latte_pos/common/extensions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  List<bool> _isSelected;
  String _receiptHeader = "";

  void _navigate(BuildContext context, int index) {
    final serviceLocator = Provider.of<ServiceLocator>(context, listen: false);
    PageRoute route;
    switch (index) {
      case 0:
        route = createRoute(ItemsPage());
        break;
      case 1:
        route = createRoute(MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => serviceLocator.receiptListModel),
          ],
          child: ReceiptListPage(),
        ));
        break;
      case 2:
        route = createRoute(MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => serviceLocator.overallReportModel),
            ChangeNotifierProvider(create: (_) => serviceLocator.saleByYearModel),
          ],
          child: ReportPage(),
        ));
        break;
    }

    if (route != null) {
      Navigator.of(context).push(route);
    }
  }

  void _showHeaderEdit() {
    showDialog<String>(
      context: context,
      builder: (context) {
        return _ReceiptHeaderUpdateDialog(header: _receiptHeader);
      },
    ).then((value) {
      if (value != null) {
        _updateHeader(value);
      }
    });
  }

  Future _load() async {
    final prefs = await SharedPreferences.getInstance();
    final locale = prefs.getInt(KEY_LOCALE) ?? 0;
    setState(() {
      _isSelected[0] = locale == AppLocale.EN.index;
      _isSelected[1] = locale == AppLocale.MM.index;
      _receiptHeader = prefs.getString(KEY_RECEIPT_HEADER);
    });
  }

  Future _updateLocale(int index) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(KEY_LOCALE, index);
    setState(() {
      for (int i = 0; i < _isSelected.length; i++) {
        if (index == i) {
          _isSelected[i] = true;
        } else {
          _isSelected[i] = false;
        }
      }
      appLocale = AppLocale.values[index];
    });
  }

  Future _updateHeader(String header) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(KEY_RECEIPT_HEADER, header.isEmpty ? null : header);
    setState(() {
      _receiptHeader = header.isEmpty ? null : header;
    });
  }

  @override
  void initState() {
    _isSelected = [false, false];
    super.initState();
    _load();
  }

  @override
  Widget build(BuildContext context) {
    final _appBar = AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        "label-menu".localize(),
        style: TextStyle(
          fontFamily: "Roboto",
        ),
      ),
    );
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Scaffold(
          backgroundColor: bgColor,
          appBar: _appBar,
          bottomNavigationBar: POSBottomNavigationBar(
            currentIndex: 2,
          ),
          body: ListView(
            padding: const EdgeInsets.all(rootPadding),
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 4.0, top: 2.0),
                child: Text(
                  "label-information".localize(),
                ),
              ),
              SizedBox(height: 8),
              Card(
                margin: const EdgeInsets.all(0),
                clipBehavior: Clip.antiAlias,
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.circular(8),
                // ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ListTile(
                      onTap: () => _navigate(context, 0),
                      //leading: Icon(Icons.all_inbox),
                      title: Row(
                        children: [
                          Icon(Icons.assignment, color: Colors.grey[600]),
                          SizedBox(width: 16),
                          Text("label-items".localize()),
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                    ),
                    ListTile(
                      onTap: () => _navigate(context, 1),
                      //leading: Icon(Icons.receipt_long),
                      //title: Text("label-receipts".localize()),
                      title: Row(
                        children: [
                          Icon(Icons.receipt_long, color: Colors.grey[600]),
                          SizedBox(width: 16),
                          Text("label-receipts".localize()),
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                    ),
                    ListTile(
                      onTap: () => _navigate(context, 2),
                      //leading: Icon(Icons.assignment),
                      //title: Text("label-reports".localize()),
                      title: Row(
                        children: [
                          Icon(Icons.pie_chart, color: Colors.grey[600]),
                          SizedBox(width: 16),
                          Text("label-reports".localize()),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Text(
                  "label-setting".localize(),
                ),
              ),
              SizedBox(height: 8),
              Card(
                margin: const EdgeInsets.all(0),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ListTile(
                      title: Row(
                        children: [
                          Icon(Icons.language, color: Colors.grey[600]),
                          SizedBox(width: 16),
                          Text("label-language".localize()),
                        ],
                      ),
                      trailing: SizedBox(
                        height: 38,
                        child: ToggleButtons(
                          children: [
                            Text("EN"),
                            Text("MM"),
                          ],
                          onPressed: (index) => _updateLocale(index),
                          isSelected: _isSelected,
                          fillColor: Theme.of(context).accentColor.withOpacity(0.4),
                          selectedColor: Theme.of(context).accentColor,
                          color: Colors.black45,
                          selectedBorderColor: Theme.of(context).accentColor,
                          borderColor: Theme.of(context).accentColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    Divider(
                      height: 1,
                    ),
                    ListTile(
                      onTap: _showHeaderEdit,
                      //leading: Icon(Icons.assignment),
                      //title: Text("label-reports".localize()),
                      title: Row(
                        children: [
                          Icon(Icons.text_fields, color: Colors.grey[600]),
                          SizedBox(width: 16),
                          Text("Receipt Header".localize()),
                        ],
                      ),
                      trailing: SizedBox(
                        width: 120,
                        child: Text(
                          _receiptHeader ?? "Latte POS",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      height: 1,
                    ),
                    ListTile(
                      onTap: () {
                        final route = createRoute(AboutPage());
                        Navigator.of(context).push(route);
                      },
                      title: Row(
                        children: [
                          Icon(Icons.info_outline, color: Colors.grey[600]),
                          SizedBox(width: 16),
                          Text("About".localize()),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SafeArea(
          child: Container(
            margin: EdgeInsets.only(
              bottom: Platform.isAndroid ? 12 : 6,
            ),
            decoration: ShapeDecoration(
              color: Theme.of(context).accentColor,
              shape: CircleBorder(),
              shadows: [
                BoxShadow(
                  color: Theme.of(context).accentColor.withOpacity(0.35),
                  blurRadius: 8,
                  spreadRadius: 1.5,
                  offset: Offset(0.6, 0.6),
                ),
              ],
            ),
            child: FlatButton(
              padding: const EdgeInsets.all(14),
              onPressed: () => navigateToSale(context),
              child: Icon(
                Icons.store_rounded,
                color: Colors.white,
                size: 30,
              ),
              color: Theme.of(context).accentColor,
              shape: CircleBorder(),
            ),
          ),
        ),
      ],
    );
  }
}

class _ReceiptHeaderUpdateDialog extends StatefulWidget {
  final String header;

  const _ReceiptHeaderUpdateDialog({
    Key key,
    this.header,
  }) : super(key: key);

  @override
  __ReceiptHeaderUpdateDialogState createState() => __ReceiptHeaderUpdateDialogState();
}

class __ReceiptHeaderUpdateDialogState extends State<_ReceiptHeaderUpdateDialog> {
  TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.header);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  POSTextLabel("Receipt Header"),
                  SizedBox(height: 8),
                  POSTextField(
                    controller: _controller,
                    hint: "Latte POS",
                  ),
                ],
              ),
            ),
            Divider(height: 1),
            SizedBox(
              height: 48,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: FlatButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        "label-cancel".localize().toUpperCase(),
                      ),
                    ),
                  ),
                  VerticalDivider(width: 1),
                  Expanded(
                    child: FlatButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      onPressed: () {
                        final text = _controller.text;
                        Navigator.of(context).pop(text);
                      },
                      child: Text(
                        "OK",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
