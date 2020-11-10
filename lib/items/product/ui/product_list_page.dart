import 'dart:io';

import 'package:flutter/material.dart';
import 'package:latte_pos/common/custom.dart';
import 'package:latte_pos/common/custom/pos_search_text_field.dart';
import 'package:latte_pos/common/extensions.dart';
import 'package:latte_pos/common/model/all_category_model.dart';
import 'package:latte_pos/items/product.dart';
import 'package:latte_pos/items/product/model/product_search_display.dart';
import 'package:latte_pos/items/product/ui/product_edit_page.dart';
import 'package:latte_pos/main.dart';
import 'package:latte_pos/service_locator.dart';
import 'package:pos_domain/pos_domain.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';

class ProductListPage extends StatefulWidget {
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  void _navigateToEdit(BuildContext context, {int productId = 0}) {
    final serviceLocator = Provider.of<ServiceLocator>(context, listen: false);
    final page = MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => serviceLocator.productEditModel),
        ChangeNotifierProvider(create: (context) => serviceLocator.productVariantsModel),
        ChangeNotifierProvider(create: (context) => serviceLocator.productDiscountsModel),
        ChangeNotifierProvider(create: (context) => serviceLocator.productTaxesModel),
        ChangeNotifierProvider(create: (context) => serviceLocator.productCategoryModel),
      ],
      child: ProductEditPage(productId: productId),
    );
    final route = productId > 0 ? createRoute(page) : createModalRoute(page);
    Navigator.of(context).push(route).then((value) {
      if (value ?? false) {
        context.read<ProductListModel>().findStatic();
      }
    });
  }

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        context.read<ProductListModel>().loadMore();
      }
    });
    context.read<ProductListModel>().findStatic();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pm = Provider.of<ProductListModel>(context, listen: false);

    final _appBar = AppBar(
      elevation: 0,
      title: Consumer<ProductSearchDisplay>(
        builder: (context, model, child) {
          if (model.searchState) {
            return POSSearchTextField(
              hint: "hint-search".localize(),
              onChange: (value) {
                pm.search = pm.search.copyWith(
                  name: value,
                );
              },
            );
          }
          return Text(
            "label-products".localize(),
          );
        },
      ),
      actions: [
        Consumer<ProductSearchDisplay>(
          builder: (context, model, child) {
            return IconButton(
              icon: Icon(model.searchState ? Icons.close : Icons.search),
              tooltip: model.searchState ? "Close" : "Search",
              onPressed: () {
                model.searchState = !model.searchState;
                if (!model.searchState && (pm.search.name?.isNotEmpty ?? false)) {
                  pm.search = pm.search.copyWith(
                    name: "",
                  );
                }
              },
            );
          },
        ),
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(47),
        child: Container(
          height: 47,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                color: Colors.grey[400],
                width: 0.7,
              ),
            ),
          ),
          child: StreamBuilder<List<CategoryDTO>>(
            stream:
                Provider.of<AllCategoryModel>(context, listen: false).getAll(),
            builder: (context, snapshot) {
              return Consumer<ProductListModel>(
                builder: (context, model, child) {
                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      final c = snapshot.data[index];
                      final selected = c.id == model.search.categoryId;
                      return ChoiceChip(
                        label: Text(
                          c.name,
                          style: TextStyle(
                            color: selected ? Colors.white : Colors.black,
                          ),
                        ),
                        selected: selected,
                        onSelected: (selected) {
                          if (selected) {
                            model.search =
                                model.search.copyWith(categoryId: c.id);
                          } else {
                            model.search.categoryId = null;
                            model.search = model.search;
                          }
                        },
                        avatar: selected
                            ? Icon(Icons.check_circle, color: Colors.white)
                            : null,
                        selectedColor: Theme.of(context).primaryColor,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(width: 8);
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
    return Scaffold(
      backgroundColor: bgColor,
      appBar: _appBar,
      floatingActionButton: FloatingActionButton(
        //backgroundColor: Theme.of(context).primaryColor,
        onPressed: () => _navigateToEdit(context),
        child: Icon(
          Icons.add,
          size: 28,
        ),
      ),
      body: Consumer<ProductListModel>(
        builder: (context, model, child) {
          return ListView.separated(
            controller: _scrollController,
            itemCount: model.products.length ?? 0,
            itemBuilder: (context, index) {
              final p = model.products[index];
              return Dismissible(
                key: ValueKey(p.id),
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
                      return model.delete(p.id, image: p.image).then((value) {
                        model.remove(p.id);
                        return true;
                      }, onError: (error) {
                        final snackBar = SnackBar(
                          content: Text(
                            "Unable to delete product.",
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
                child: _ProductListItem(
                  dto: p,
                  onTap: () => _navigateToEdit(context, productId: p.id),
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
          height: 80,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      dto.name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    //SizedBox(height: 2),
                    Text(
                      dto.category,
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16),
              Text(
                dto.variant > 0
                    ? "${dto.variant} Variant${dto.variant > 1 ? 's' : ''}"
                    : dto.price?.formatCurrency(),
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
