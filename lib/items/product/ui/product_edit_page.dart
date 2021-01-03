import 'dart:io';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latte_pos/common/custom.dart';
import 'package:latte_pos/items/product.dart';
import 'package:latte_pos/items/product/ui/category_choice_page.dart';
import 'package:latte_pos/items/product/ui/discount_choice_page.dart';
import 'package:latte_pos/items/product/ui/tax_choice_page.dart';
import 'package:latte_pos/items/product/ui/variant_edit_page.dart';
import 'package:latte_pos/main.dart';
import 'package:latte_pos/service_locator.dart';
import 'package:pos_domain/pos_domain.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:latte_pos/common/extensions.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

const _spacing = SizedBox(height: 16);

class ProductEditPage extends StatefulWidget {
  final int productId;

  const ProductEditPage({
    Key key,
    this.productId,
  }) : super(key: key);

  @override
  _ProductEditPageState createState() => _ProductEditPageState();
}

class _ProductEditPageState extends State<ProductEditPage> {
  String _nameInputError;
  String _priceInputError;
  String _categoryChoiceError;
  String _barCodeInputError;

  TextEditingController _nameInputController;
  TextEditingController _priceInputController;
  TextEditingController _costInputController;
  TextEditingController _barcodeInputController;

  final _globalKey = GlobalKey<ScaffoldState>();

  ProgressDialog progress;

  void _navigateToCategoryChoice() {
    final serviceLocator = Provider.of<ServiceLocator>(context, listen: false);
    final route = createRoute(MultiProvider(
      providers: [
        Provider(create: (context) => serviceLocator.allCategoryModel),
        ChangeNotifierProvider.value(value: context.read<ProductCategoryModel>()),
      ],
      child: CategoryChoicePage(),
    ));
    Navigator.of(context).push(route);
  }

  void _delete() {
    showDialog<bool>(
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
        final model = context.read<ProductEditModel>();
        model.delete(widget.productId, image: model.editDTO?.image).then((value) {
          Navigator.of(context).pop(true);
        }, onError: (error) {
          final snackBar = SnackBar(
            content: Text(
              "Unable to delete product.",
            ),
            backgroundColor: dangerColor,
          );
          _globalKey.currentState.showSnackBar(snackBar);
        });
      }
    });
  }

  Future _save() async {
    if (_validateInputs()) {
      await progress.show();
      try {
        await context.read<ProductEditModel>().save(
          variants: context.read<ProductVariantsModel>().allVariants,
          discounts: context.read<ProductDiscountsModel>().discounts,
          taxes: context.read<ProductTaxesModel>().taxes,
        );
        await progress.hide();
        Navigator.of(context).pop(true);
      } catch (error) {
        await progress.hide();
        final snackBar = SnackBar(
          content: Text(
            error?.toString()?.localize() ?? "Something went wrong.",
          ),
          backgroundColor: dangerColor,
        );
        _globalKey.currentState.showSnackBar(snackBar);
      }

      // context.read<ProductEditModel>().save(
      //   variants: context.read<ProductVariantsModel>().allVariants,
      //   discounts: context.read<ProductDiscountsModel>().discounts,
      //   taxes: context.read<ProductTaxesModel>().taxes,
      // ).then((value) {
      //   Navigator.of(context).pop(true);
      // }, onError: (error) {
      //   final snackBar = SnackBar(
      //     content: Text(
      //       error?.toString()?.localize() ?? "Something went wrong.",
      //     ),
      //     backgroundColor: dangerColor,
      //   );
      //   _globalKey.currentState.showSnackBar(snackBar);
      // });
    }
  }

  bool _validateInputs() {
    final _dto = context.read<ProductEditModel>().editDTO;
    final _variants = context.read<ProductVariantsModel>().variants;
    bool valid = true;
    _nameInputError = null;
    _priceInputError = null;
    _barCodeInputError = null;

    setState(() {
      if (_dto.name?.isEmpty ?? true) {
        valid = false;
        _nameInputError = "error-input-product-name".localize();
      }

      if ((_dto.categoryId ?? 0) <= 0) {
        valid = false;
        _categoryChoiceError = "error-input-choose-category".localize();
      }

      if ((_dto.price ?? 0) <= 0 && context.read<ProductVariantsModel>().variants.isEmpty) {
        valid = false;
        _priceInputError = "error-input-product-price".localize();
      }

      if (_variants.any((e) => (e.barcode?.isNotEmpty ?? false) && e.barcode == _dto.barcode)) {
        valid = false;
        _barCodeInputError = "error-barcode-duplicate".localize();
      }
    });

    return valid;
  }

  Future _scanBarcode() async {
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
      _barcodeInputController.text = result.rawContent;
      context.read<ProductEditModel>().editDTO?.barcode = result.rawContent;
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  Future _loadProduct() async {
    final model = context.read<ProductEditModel>();
    final p = await model.getProduct(widget.productId);
    final doc = await getApplicationDocumentsDirectory();
    setState(() {
      model.editDTO = p?.toEdit() ?? ProductEditDTO();
      if (p != null) {
        context.read<ProductCategoryModel>().category = p.category;
        context.read<ProductDiscountsModel>().discounts = p.discounts;
        context.read<ProductTaxesModel>().taxes = p.taxes;
        context.read<ProductVariantsModel>().variants = p.variants;
      }

      if (p?.image != null) {
        model.editDTO.imageFile = File("${doc.path}/$imageRoot/${p.image}");
      }
    });
  }

  @override
  void initState() {
    _nameInputController = TextEditingController();
    _priceInputController = TextEditingController();
    _costInputController = TextEditingController();
    _barcodeInputController = TextEditingController();

    progress = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      isDismissible: false,
      showLogs: false,
      customBody: Container(
        height: 64,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(16),
        child: Text(
          "Saving ...",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            fontFamily: "Roboto",
          ),
        ),
      ),
    );
    super.initState();

    _loadProduct();
  }

  @override
  void dispose() {
    _nameInputController.dispose();
    _priceInputController.dispose();
    _costInputController.dispose();
    _barcodeInputController.dispose();

    progress = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final model = Provider.of<ProductEditModel>(context, listen: false);

    bool update = widget.productId > 0;

    final _appBar = AppBar(
      elevation: 0,
      title: Text(
        "${update ? 'label-update-product' : 'label-create-product'}".localize(),
      ),
      actions: [
        Visibility(
          visible: update,
          child: IconButton(
            icon: Icon(FontAwesomeIcons.trashAlt, size: 20),
            tooltip: "label-delete".localize(),
            onPressed: _delete,
          ),
        ),
      ],
    );

    final _categoryErrorText = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Text(
        _categoryChoiceError ?? "",
        style: TextStyle(
          color: dangerColor,
          fontSize: 12.0,
        ),
      ),
    );

    return Scaffold(
      key: _globalKey,
      backgroundColor: bgColor,
      appBar: _appBar,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: [
            ClipPath(
              //clipper: POSArcClipper(70),
              child: Container(
                height: 120,
                color: Theme.of(context).primaryColor,
              ),
            ),
            ListView(
              padding: const EdgeInsets.only(
                left: rootPadding,
                top: 8,
                right: rootPadding,
                bottom: rootPadding,
              ),
              children: [
                Card(
                  margin: const EdgeInsets.all(0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Consumer<ProductEditModel>(
                      builder: (context, pm, child) {
                        _nameInputController.text = pm.editDTO?.name;
                        _priceInputController.text = pm.editDTO?.price?.format();
                        _costInputController.text = pm.editDTO?.cost?.format();
                        _barcodeInputController.text = pm.editDTO?.barcode;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            POSTextField(
                              controller: _nameInputController,
                              label: "${'label-name'.localize()} *",
                              hint: "hint-enter-product-name".localize(),
                              errorText: _nameInputError,
                              onChanged: (value) {
                                pm.editDTO?.name = value;
                              },
                            ),
                            _spacing,
                            POSTextLabel("${'label-category'.localize()} *"),
                            SizedBox(height: 6),
                            Card(
                              elevation: 0,
                              margin: const EdgeInsets.all(0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                                side: BorderSide(
                                  color: _categoryChoiceError != null ? dangerColor : Colors.grey,
                                ),
                              ),
                              child: InkWell(
                                onTap: _navigateToCategoryChoice,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 11,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Consumer<ProductCategoryModel>(
                                          builder: (context, model, child) {
                                            pm.editDTO?.categoryId = model.category?.id;
                                            return Text(
                                              model.category?.name ?? "hint-choose-category".localize(),
                                              style: TextStyle(
                                                color: model.category == null ? Colors.grey[600] : Colors.black,
                                                fontSize: model.category == null ? 14 : 16,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: _categoryChoiceError != null ? 6 : 0),
                            _categoryChoiceError != null ? _categoryErrorText : SizedBox.shrink(),
                            _spacing,
                            Row(
                              children: [
                                POSTextLabel("label-price".localize()),
                                SizedBox(width: 4),
                                Text(
                                  "(Conditional)",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 6),
                            POSTextField(
                              controller: _priceInputController,
                              hint: "hint-enter-product-price".localize(),
                              errorText: _priceInputError,
                              inputType: TextInputType.numberWithOptions(decimal: true),
                              onChanged: (value) {
                                pm.editDTO?.price = double.tryParse(value);
                              },
                            ),
                            _spacing,
                            POSTextField(
                              controller: _costInputController,
                              label: "label-cost".localize(),
                              hint: "hint-enter-product-cost".localize(),
                              inputType: TextInputType.numberWithOptions(decimal: true),
                              onChanged: (value) {
                                pm.editDTO?.cost = double.tryParse(value);
                              },
                            ),
                            _spacing,
                            POSTextField(
                              controller: _barcodeInputController,
                              label: "label-barcode".localize(),
                              hint: "hint-enter-product-barcode".localize(),
                              errorText: _barCodeInputError,
                              trailing: SizedBox(
                                width: 48,
                                child: FlatButton(
                                  padding: const EdgeInsets.all(0),
                                  shape: CircleBorder(),
                                  child: Icon(
                                    Icons.qr_code,
                                  ),
                                  onPressed: _scanBarcode,
                                ),
                              ),
                              onChanged: (value) {
                                pm.editDTO?.barcode = value;
                              },
                            ),
                            _spacing,
                            POSTextLabel("label-status".localize()),
                            Row(
                              children: [
                                Radio(
                                  value: true,
                                  groupValue: pm.editDTO?.available ?? false,
                                  onChanged: (value) {
                                    pm.updateAvailable(value);
                                  },
                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                                Text("label-available".localize()),
                                Radio(
                                  value: false,
                                  groupValue: pm.editDTO?.available ?? false,
                                  onChanged: (value) {
                                    pm.updateAvailable(value);
                                  },
                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                                Text("label-not-available".localize()),
                              ],
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 8),
                _VariantsCard(),
                SizedBox(height: 8),
                _DiscountsCard(),
                SizedBox(height: 8),
                _TaxesCard(),
                SizedBox(height: 8),
                _ImageCard(
                  onSave: _save,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _VariantsCard extends StatelessWidget {
  void _navigateToEdit(BuildContext context, {VariantDTO dto, int index}) {
    final route = createRoute(MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: context.read<ProductVariantsModel>()),
        Provider.value(value: context.read<ProductEditModel>().editDTO),
      ],
      child: VariantEditPage(variant: dto, index: index),
    ));
    Navigator.of(context).push(route);
  }

  @override
  Widget build(BuildContext context) {
    //final model = Provider.of<ProductVariantsModel>(context, listen: false);

    return Card(
      margin: const EdgeInsets.all(0),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: POSTextLabel("label-variants".localize()),
                ),
                InkResponse(
                  onTap: () => _navigateToEdit(context),
                  child: Text(
                    "label-add".localize(),
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Consumer<ProductVariantsModel>(
              builder: (context, model, child) {
                final len = model.variants.length;
                var widgets = <Widget>[];
                for (int i = 0; i < len; i++) {
                  var dto = model.variants[i];
                  widgets.add(
                    InkWell(
                      onTap: () => _navigateToEdit(context, dto: dto.clone(), index: i),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Row(
                          children: [
                            Expanded(child: Text(dto.name)),
                            SizedBox(width: 16),
                            Text(dto.price.formatCurrency()),
                            SizedBox(width: 16),
                            SizedBox(
                              width: 48,
                              height: 46,
                              child: FlatButton(
                                padding: const EdgeInsets.all(0),
                                shape: CircleBorder(),
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.grey,
                                ),
                                onPressed: () => model.remove(dto),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                  if (i + 1 < len) {
                    widgets.add(Divider(height: 1));
                  }
                }
                return Container(
                  clipBehavior: Clip.antiAlias,
                  margin: EdgeInsets.only(top: (len > 0 ? 12 : 0)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    border: len > 0
                        ? Border.all(
                            color: Colors.grey.withOpacity(0.7),
                            width: 0.5,
                          )
                        : null,
                  ),
                  child: Column(
                    children: widgets,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _DiscountsCard extends StatelessWidget {
  void _navigateToChoice(BuildContext context) {
    final serviceLocator = Provider.of<ServiceLocator>(context, listen: false);
    final route = createRoute(MultiProvider(
      providers: [
        Provider(create: (context) => serviceLocator.discountListModel),
        ChangeNotifierProvider.value(value: context.read<ProductDiscountsModel>()),
      ],
      child: DiscountChoicePage(),
    ));
    Navigator.of(context).push(route);
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ProductDiscountsModel>(context);
    return Card(
      margin: const EdgeInsets.all(0),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: POSTextLabel("label-discounts".localize()),
                ),
                InkResponse(
                  onTap: () => _navigateToChoice(context),
                  child: Text(
                    "label-choose".localize(),
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              height: model.discounts.length > 0 ? 16 : 0,
              color: model.discounts.length > 0 ? null : Colors.transparent,
            ),
            Wrap(
              spacing: 8,
              children: model.discounts.map((e) {
                return Chip(
                  label: Text("${e.name} - ${e.value.format()} ${e.type.name}".trim()),
                  onDeleted: () => model.remove(e),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _TaxesCard extends StatelessWidget {
  void _navigateToChoice(BuildContext context) {
    final serviceLocator = Provider.of<ServiceLocator>(context, listen: false);
    final route = createRoute(MultiProvider(
      providers: [
        Provider(create: (context) => serviceLocator.taxListModel),
        ChangeNotifierProvider.value(value: context.read<ProductTaxesModel>()),
      ],
      child: TaxChoicePage(),
    ));
    Navigator.of(context).push(route);
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ProductTaxesModel>(context);
    return Card(
      margin: const EdgeInsets.all(0),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: POSTextLabel("label-taxes".localize()),
                ),
                InkResponse(
                  onTap: () => _navigateToChoice(context),
                  child: Text(
                    "label-choose".localize(),
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              height: model.taxes.length > 0 ? 16 : 0,
              color: model.taxes.length > 0 ? null : Colors.transparent,
            ),
            Wrap(
              children: model.taxes.map((e) {
                return Chip(
                  label: Text("${e.name} - ${e.value.format()}%"),
                  onDeleted: () => model.remove(e),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _ImageCard extends StatefulWidget {
  final VoidCallback onSave;

  const _ImageCard({
    Key key,
    this.onSave,
  }) : super(key: key);

  @override
  __ImageCardState createState() => __ImageCardState();
}

class __ImageCardState extends State<_ImageCard> {
  File _image;
  final _picker = ImagePicker();

  Future _getImage() async {
    String error;
    try {
      final pickedFile = await _picker.getImage(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
          context.read<ProductEditModel>().editDTO.imageFile = _image;
        } else {
          print('No image selected.');
        }
      });
    } on PlatformException catch (e) {
      error = e.message;
      print(e.message);
    } catch (e) {
      error = e.toString();
      print(e);
    }

    if (error != null) {
      final snackBar = SnackBar(
        content: Text(
          error,
        ),
        backgroundColor: dangerColor,
      );

      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    _image = Provider.of<ProductEditModel>(context, listen: false).editDTO?.imageFile;
    return Card(
      margin: const EdgeInsets.all(0),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            POSTextLabel("label-product-image".localize()),
            _spacing,
            Center(
              child: Container(
                width: 140,
                height: 140,
                clipBehavior: Clip.antiAlias,
                padding: const EdgeInsets.all(0.5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
                child: Stack(
                  children: [
                    Builder(
                      builder: (context) {
                        if (_image != null) {
                          return Image.file(
                            _image,
                            height: 140,
                            width: 140,
                            fit: BoxFit.cover,
                          );
                        }
                        return Image.asset(
                          "images/placeholder.png",
                          fit: BoxFit.fill,
                        );
                      },
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: _getImage,
                      ),
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: Builder(
                        builder: (context) {
                          if (_image != null) {
                            return Material(
                              color: Colors.black38,
                              shape: CircleBorder(),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _image = null;
                                    context.read<ProductEditModel>().editDTO.imageFile = _image;
                                  });
                                },
                                customBorder: CircleBorder(),
                                child: CircleAvatar(
                                  radius: 14,
                                  backgroundColor: Colors.transparent,
                                  child: Icon(
                                    Icons.clear_rounded,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            );
                          }
                          return SizedBox.shrink();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(height: 24),
            POSPrimaryButton(
              onPressed: widget.onSave,
              text: "label-save".localize().toUpperCase(),
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 14),
              color: Theme.of(context).accentColor,
            ),
          ],
        ),
      ),
    );
  }
}
