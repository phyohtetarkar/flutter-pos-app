import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:latte_pos/common/custom.dart';
import 'package:latte_pos/items/product.dart';
import 'package:latte_pos/main.dart';
import 'package:pos_domain/pos_domain.dart';
import 'package:latte_pos/common/extensions.dart';
import 'package:provider/provider.dart';

const _spacing = SizedBox(height: 16);

class VariantEditPage extends StatefulWidget {
  final int index;
  final VariantDTO variant;

  const VariantEditPage({
    Key key,
    this.variant,
    this.index,
  }) : super(key: key);

  @override
  _VariantEditPageState createState() => _VariantEditPageState();
}

class _VariantEditPageState extends State<VariantEditPage> {
  VariantDTO _dto;

  String _nameInputError;
  String _priceInputError;
  String _barCodeInputError;

  TextEditingController _nameInputController;
  TextEditingController _priceInputController;
  TextEditingController _costInputController;
  TextEditingController _barcodeInputController;

  void _save() {
    if (_validateInputs()) {
      final model = context.read<ProductVariantsModel>();
      final code = _barcodeInputController.text;
      model.checkBarcodeDuplicate(code, variantId: _dto.id).then((duplicated) {
        if (duplicated && !model.allVariants.any((e) => e.removed && e.barcode == code)) {
          setState(() {
            _barCodeInputError = "error-barcode-duplicate".localize();
          });
        } else {
          _dto.barcode = _barcodeInputController.text;
          if (widget.variant != null && widget.index != null) {
            model.replaceAt(widget.index, _dto);
          } else {
            model.add(_dto);
          }
          Navigator.of(context).pop();
        }
      });
    }
  }

  bool _validateInputs() {
    bool valid = true;
    _nameInputError = null;
    _priceInputError = null;
    _barCodeInputError = null;
    final model = context.read<ProductVariantsModel>();
    final productDTO = context.read<ProductEditDTO>();

    final barcode = _barcodeInputController.text;

    setState(() {
      if (_dto.name?.isEmpty ?? true) {
        valid = false;
        _nameInputError = "error-input-variant-name".localize();
      }

      if ((_dto.price ?? 0) <= 0) {
        valid = false;
        _priceInputError = "error-input-variant-price".localize();
      }

      if ((_dto.barcode?.isNotEmpty ?? false) && model.variants.any((e) => (e.barcode?.isNotEmpty ?? false) && e != _dto && e.barcode == barcode)) {
        valid = false;
        _barCodeInputError = "error-barcode-duplicate".localize();
      } else if ((productDTO.barcode?.isNotEmpty ?? false) && productDTO.barcode == barcode) {
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
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  @override
  void initState() {
    _dto = widget.variant ?? VariantDTO();
    _nameInputController = TextEditingController(text: _dto.name);
    _priceInputController = TextEditingController(text: _dto.price?.format());
    _costInputController = TextEditingController(text: _dto.cost?.format());
    _barcodeInputController = TextEditingController(text: _dto.barcode);
    super.initState();
  }

  @override
  void dispose() {
    _nameInputController.dispose();
    _priceInputController.dispose();
    _costInputController.dispose();
    _barcodeInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final update = widget.variant != null;
    final _appBar = AppBar(
      elevation: 0,
      title: Text(
        "${update ? 'label-update-variant' : 'label-create-variant'}".localize(),
      ),
    );
    return Scaffold(
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
              padding: const EdgeInsets.only(left: rootPadding, top: 8, right: rootPadding, bottom: rootPadding),
              children: [
                Card(
                  margin: const EdgeInsets.all(0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        POSTextField(
                          controller: _nameInputController,
                          label: "${'label-name'.localize()} *",
                          hint: "hint-enter-variant-name".localize(),
                          errorText: _nameInputError,
                          onChanged: (value) {
                            _dto.name = value;
                          },
                        ),
                        _spacing,
                        POSTextField(
                          controller: _priceInputController,
                          label: "${'label-price'.localize()} *",
                          hint: "hint-enter-variant-price".localize(),
                          errorText: _priceInputError,
                          inputType: TextInputType.numberWithOptions(decimal: true),
                          onChanged: (value) {
                            _dto.price = double.tryParse(value);
                          },
                        ),
                        _spacing,
                        POSTextField(
                          controller: _costInputController,
                          label: "label-cost".localize(),
                          hint: "hint-enter-variant-cost".localize(),
                          inputType: TextInputType.numberWithOptions(decimal: true),
                          onChanged: (value) {
                            _dto.cost = double.tryParse(value);
                          },
                        ),
                        _spacing,
                        POSTextField(
                          controller: _barcodeInputController,
                          label: "label-barcode".localize(),
                          hint: "hint-enter-variant-barcode".localize(),
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
                        ),
                        _spacing,
                        POSTextLabel("Status"),
                        Row(
                          children: [
                            Radio(
                              value: true,
                              groupValue: _dto.available ?? false,
                              onChanged: (value) {
                                setState(() {
                                  _dto.available = value;
                                });
                              },
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            Text("label-available".localize()),
                            Radio(
                              value: false,
                              groupValue: _dto.available ?? false,
                              onChanged: (value) {
                                setState(() {
                                  _dto.available = value;
                                });
                              },
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            Text("label-not-available".localize()),
                          ],
                        ),
                        _spacing,
                        POSPrimaryButton(
                          onPressed: _save,
                          text: "label-save".localize().toUpperCase(),
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          color: Theme.of(context).accentColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
