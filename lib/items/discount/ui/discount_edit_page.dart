import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latte_pos/common/custom.dart';
import 'package:latte_pos/common/extensions.dart';
import 'package:latte_pos/items/discount.dart';
import 'package:latte_pos/main.dart';
import 'package:pos_domain/pos_domain.dart';
import 'package:provider/provider.dart';

class DiscountEditPage extends StatefulWidget {
  final DiscountDTO discount;

  const DiscountEditPage({
    Key key,
    this.discount,
  }) : super(key: key);

  @override
  _DiscountEditPageState createState() => _DiscountEditPageState();
}

class _DiscountEditPageState extends State<DiscountEditPage> {
  List<bool> _isSelected;

  String _nameInputError;
  String _valueInputError;

  TextEditingController _nameInputController;
  TextEditingController _valueInputController;
  DiscountType _discountType;

  final _globalKey = GlobalKey<ScaffoldState>();

  void _save(BuildContext context) {
    if (_validateInputs()) {
      final dto = DiscountDTO(
        id: widget.discount?.id,
        name: _nameInputController.text,
        value: double.tryParse(_valueInputController.text),
        type: _discountType,
      );
      context.read<DiscountEditModel>().save(dto).then((value) {
        Navigator.of(context).pop();
      }, onError: (error) {
        setState(() {
          _nameInputError = error.toString();
        });
      });
    }
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
        Provider.of<DiscountEditModel>(context, listen: false).delete(widget.discount.id).then((value) {
          Navigator.of(context).pop();
        }, onError: (error) {
          final snackBar = SnackBar(
            content: Text(
              "Unable to delete discount.",
            ),
            backgroundColor: dangerColor,
          );
          _globalKey.currentState.showSnackBar(snackBar);
        });
      }
    });
  }

  bool _validateInputs() {
    bool valid = true;

    valid &= _nameInputController.text.isNotEmpty;
    valid &= _valueInputController.text.isNotEmpty;

    setState(() {
      _nameInputError = _nameInputController.text.isEmpty ? "error-input-discount-name".localize() : null;
      _valueInputError = _valueInputController.text.isEmpty ? "error-input-discount-value".localize() : null;
    });

    return valid;
  }

  @override
  void initState() {
    _nameInputController = TextEditingController(text: widget.discount?.name);
    _valueInputController = TextEditingController(text: widget.discount?.value?.format());
    _discountType = widget.discount?.type ?? DiscountType.percentage;
    _isSelected = List.generate(2, (index) {
      return index == _discountType.index;
    });
    super.initState();
  }

  @override
  void dispose() {
    _nameInputController.dispose();
    _valueInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool update = (widget.discount?.id ?? 0) > 0;
    final _appBar = AppBar(
      elevation: 0,
      title: Text(
        "${update ? 'label-update-discount' : 'label-create-discount'}".localize(),
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
                          label: "label-name".localize(),
                          hint: "hint-enter-discount-name".localize(),
                          errorText: _nameInputError,
                        ),
                        SizedBox(height: 16),
                        POSTextLabel("label-value".localize()),
                        SizedBox(height: 6),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: POSTextField(
                                controller: _valueInputController,
                                hint: "hint-enter-discount-value".localize(),
                                errorText: _valueInputError,
                                inputType: TextInputType.number,
                              ),
                            ),
                            SizedBox(width: 16),
                            Container(
                              height: 46,
                              child: ToggleButtons(
                                children: [
                                  Icon(FontAwesomeIcons.percent, size: 18),
                                  Text("00"),
                                ],
                                onPressed: (index) {
                                  setState(() {
                                    for (int i = 0; i < _isSelected.length; i++) {
                                      if (index == i) {
                                        _isSelected[i] = true;
                                        _discountType = DiscountType.values[i];
                                      } else {
                                        _isSelected[i] = false;
                                      }
                                    }
                                  });
                                },
                                isSelected: _isSelected,
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                                fillColor: Theme.of(context).accentColor.withOpacity(0.4),
                                selectedColor: Theme.of(context).accentColor,
                                color: Colors.black45,
                                selectedBorderColor: Theme.of(context).accentColor,
                                borderColor: Theme.of(context).accentColor,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 16),
                        POSPrimaryButton(
                          onPressed: () => _save(context),
                          text: "label-save".localize(),
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
