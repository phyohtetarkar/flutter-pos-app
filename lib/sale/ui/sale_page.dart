import 'dart:io';

import 'package:badges/badges.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:latte_pos/common/custom.dart';
import 'package:latte_pos/common/custom/pos_search_text_field.dart';
import 'package:latte_pos/common/extensions.dart';
import 'package:latte_pos/common/model/all_category_model.dart';
import 'package:latte_pos/main.dart';
import 'package:latte_pos/sale/model/sale_products_model.dart';
import 'package:latte_pos/sale/model/sale_products_search_display.dart';
import 'package:latte_pos/sale/model/shopping_cart_model.dart';
import 'package:latte_pos/sale/ui/cart_items_page.dart';
import 'package:latte_pos/sale/ui/edit_cart_item_page.dart';
import 'package:latte_pos/service_locator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pos_domain/pos_domain.dart';
import 'package:provider/provider.dart';

class SalePage extends StatefulWidget {

  @override
  _SalePageState createState() => _SalePageState();
}

class _SalePageState extends State<SalePage> {

  final _globalKey = GlobalKey<ScaffoldState>();

  ScrollController _scrollController = ScrollController();

  void _navigateToCartItems() {
    final route = createRoute(
      ChangeNotifierProvider.value(
        value: context.read<ShoppingCartModel>(),
        child: CartItemsPage(),
      ),
    );
    Navigator.of(context).push(route);
  }

  void _navigateToEditItem(SaleItemDTO item) {
    final route = createRoute(MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: context.read<ShoppingCartModel>()),
        ChangeNotifierProvider(create: (context) => Provider.of<ServiceLocator>(context, listen: false).editSaleItemModel),
      ],
      child: EditCartItemPage(item: item),
    ));
    Navigator.of(context).push(route);
  }

  void _add(ProductDTO dto) {
    if (dto.variant > 0) {
      _navigateToEditItem(
        SaleItemDTO(
          productId: dto.id,
          productName: dto.name,
        )
      );
    } else {
      context.read<ShoppingCartModel>().addById(dto.id);
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        context.read<SaleProductsModel>().loadMore();
      }
    });
    context.read<SaleProductsModel>().find();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _appBar = AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Text(
        "Latte POS",
        style: TextStyle(
          fontFamily: "Roboto",
        ),
      ),
      actions: [
        Consumer<ShoppingCartModel>(
          builder: (context, model, child) {
            return Badge(
              badgeContent: Text(
                "${model.totalItem}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
              showBadge: model.totalItem > 0,
              position: BadgePosition.topEnd(top: 0, end: 3),
              animationType: BadgeAnimationType.scale,
              animationDuration: Duration(milliseconds: 200),
              elevation: 0,
              child: IconButton(
                tooltip: "Shopping Cart",
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  if (model.totalItem > 0) {
                    _navigateToCartItems();
                  }
                },
              ),
            );
          },
        ),
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: Container(
          height: 56,
          padding: const EdgeInsets.only(right: 4),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                color: Colors.grey[400],
                width: 0.7,
              ),
            ),
          ),
          child: _FilterBar(),
        ),
      ),
    );
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Scaffold(
          key: _globalKey,
          backgroundColor: bgColor,
          appBar: _appBar,
          bottomNavigationBar: POSBottomNavigationBar(
            currentIndex: 1,
          ),
          body: Consumer<SaleProductsModel>(
            builder: (context, model, child) {
              //print("${model.products.length} products");
              return ListView.separated(
                itemCount: model.products.length ?? 0,
                itemBuilder: (context, index) {
                  final p = model.products[index];
                  return _ProductListItem(
                    dto: p,
                    onTap: () => _add(p),
                  );
                },
                separatorBuilder: (context, index) => Divider(height: 1, color: Colors.transparent),
              );
            },
          ),
        ),
        SafeArea(
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: CircleBorder(),
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

class _FilterBar extends StatelessWidget {

  Future _scanBarcode(BuildContext context) async {
    try {
      var options = ScanOptions(
        restrictFormat: BarcodeFormat.values.toList()..removeWhere((e) => e == BarcodeFormat.unknown),
        useCamera: -1,
        autoEnableFlash: false,
        android: AndroidOptions(
          aspectTolerance: 0.00,
          useAutoFocus: true,
        ),
      );
      var result = await BarcodeScanner.scan(options: options);
      _addByBarcode(context, result.rawContent);
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  void _addByBarcode(BuildContext context, String code) {
    context.read<ShoppingCartModel>().addByBarcode(code).then((_) async {
      // if (await Vibration.hasVibrator()) {
      //   Vibration.vibrate();
      // }
    }, onError: (error) {
      final snackBar = SnackBar(
        content: Text(
          error?.toString() ?? "Something went wrong.",
        ),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            Expanded(
              child: _CategoryChoiceDropDown(),
            ),
            SizedBox(
              width: 46,
              height: 46,
              child: FlatButton(
                padding: const EdgeInsets.all(0),
                shape: CircleBorder(),
                child: Icon(
                  Icons.qr_code,
                ),
                onPressed: () => _scanBarcode(context),
              ),
            ),
            SizedBox(
              width: 46,
              height: 46,
              child: FlatButton(
                padding: const EdgeInsets.all(0),
                shape: CircleBorder(),
                child: Icon(
                  Icons.search_rounded,
                ),
                onPressed: () {
                  final model = context.read<SaleProductsSearchDisplay>();
                  model.searchState = !model.searchState;
                },
              ),
            ),
          ],
        ),
        Consumer<SaleProductsSearchDisplay>(
          builder: (context, model, child) {
            if (model.searchState) {
              return Container(
                color: Colors.white,
                padding: const EdgeInsets.only(left: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: POSSearchTextField(
                        hint: "hint-search".localize(),
                        color: Colors.black,
                        onChange: (value) {
                          final model = context.read<SaleProductsModel>();
                          model.search = model.search.copyWith(name: value);
                        },
                      ),
                    ),
                    SizedBox(width: 16),
                    SizedBox(
                      width: 46,
                      height: 46,
                      child: FlatButton(
                        padding: const EdgeInsets.all(0),
                        shape: CircleBorder(),
                        child: Icon(
                          Icons.close,
                        ),
                        onPressed: () {
                          final model = context.read<SaleProductsSearchDisplay>();
                          model.searchState = !model.searchState;

                          final sm = context.read<SaleProductsModel>();
                          if (sm.search.name?.isNotEmpty ?? false) {
                            sm.search.name = null;
                            sm.search = sm.search;
                          }
                        },
                      ),
                    ),
                  ],
                ),
              );
            }

            return SizedBox.shrink();
          },
        ),
      ],
    );
  }
}

class _CategoryChoiceDropDown extends StatefulWidget {
  @override
  __CategoryChoiceDropDownState createState() => __CategoryChoiceDropDownState();
}

class __CategoryChoiceDropDownState extends State<_CategoryChoiceDropDown> {
  final List<CategoryDTO> _list = [CategoryDTO(id: 0, name: "label-all-products".localize())];
  CategoryDTO _selected;

  @override
  void initState() {
    _selected = _list[0];
    super.initState();

    context.read<AllCategoryModel>().getAllStatic().then((list) {
      setState(() {
        _list.addAll(list);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<SaleProductsModel>(context, listen: false);
    //print("${_list.length} categories");
    return DropdownButtonHideUnderline(
      child: ButtonTheme(
        alignedDropdown: true,
        child: DropdownButton<CategoryDTO>(
          value: _selected,
          onChanged: (value) {
            model.search = model.search.copyWith(categoryId: value.id);
            setState(() {
              _selected = value;
            });
          },
          items: _list.map((e) {
            return DropdownMenuItem<CategoryDTO>(
              value: e,
              child: Text(e.name),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _ProductListItem extends StatelessWidget {
  final ProductDTO dto;
  final VoidCallback onTap;

  const _ProductListItem({
    Key key,
    this.dto,
    this.onTap,
  }) : super(key: key);

  Future<File> getImage() async {
    if (dto.image == null) {
      return null;
    }

    var dir = await getApplicationDocumentsDirectory();
    var file = File("${dir.path}/$imageRoot/${dto.image}");

    return (await file.exists()) ? file : null;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 70,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              AspectRatio(
                aspectRatio: 1 / 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: FutureBuilder<File>(
                    future: getImage(),
                    builder: (context, snapshot) {
                      if (snapshot.data != null) {
                        return Image.file(
                          snapshot.data,
                          fit: BoxFit.cover,
                        );
                      }
                      return Image.asset(
                        "images/placeholder.png",
                        fit: BoxFit.fill,
                      );
                    },
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Text(
                  dto.name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(width: 16),
              Text(
                dto.safeVariant > 0 ? "${dto.variant} Variant${dto.variant > 1 ? 's' : ''}" : dto.price?.formatCurrency() ?? "",
                style: TextStyle(
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
