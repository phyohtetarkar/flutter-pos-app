import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latte_pos/common/custom.dart';
import 'package:latte_pos/common/extensions.dart';
import 'package:latte_pos/items/tax.dart';
import 'package:latte_pos/main.dart';
import 'package:pos_domain/pos_domain.dart';
import 'package:provider/provider.dart';

class TaxEditPage extends StatefulWidget {
  final TaxDTO tax;

  const TaxEditPage({
    Key key,
    this.tax,
  }) : super(key: key);

  @override
  _TaxEditPageState createState() => _TaxEditPageState();
}

class _TaxEditPageState extends State<TaxEditPage> {
  String _nameInputError;
  String _valueInputError;

  TextEditingController _nameInputController;
  TextEditingController _valueInputController;

  final _globalKey = GlobalKey<ScaffoldState>();

  void _save(BuildContext context) {
    if (_validateInputs()) {
      final dto = TaxDTO(
        id: widget.tax?.id,
        name: _nameInputController.text,
        value: double.tryParse(_valueInputController.text),
      );
      context.read<TaxEditModel>().save(dto).then((value) {
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
        Provider.of<TaxEditModel>(context, listen: false).delete(widget.tax.id).then((value) {
          Navigator.of(context).pop();
        }, onError: (error) {
          final snackBar = SnackBar(
            content: Text(
              "Unable to delete tax.",
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
      _nameInputError = _nameInputController.text.isEmpty ? "error-input-tax-name".localize() : null;
      _valueInputError = _valueInputController.text.isEmpty ? "error-input-tax-value".localize() : null;
    });

    return valid;
  }

  @override
  void initState() {
    _nameInputController = TextEditingController(text: widget.tax?.name);
    _valueInputController = TextEditingController(text: widget.tax?.value?.format());
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
    bool update = (widget.tax?.id ?? 0) > 0;
    final _appBar = AppBar(
      elevation: 0,
      title: Text(
        "${update ? 'label-update-tax' : 'label-create-tax'}".localize(),
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
                          hint: "hint-enter-tax-name".localize(),
                          errorText: _nameInputError,
                        ),
                        SizedBox(height: 16),
                        POSTextLabel("label-value".localize()),
                        SizedBox(height: 6),
                        POSTextField(
                          controller: _valueInputController,
                          hint: "hint-enter-tax-value".localize(),
                          errorText: _valueInputError,
                          inputType: TextInputType.number,
                          trailing: Padding(
                            padding: const EdgeInsets.only(right: 14),
                            child: Icon(
                              FontAwesomeIcons.percent,
                              color: Colors.grey[600],
                              size: 18,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        POSPrimaryButton(
                          onPressed: () => _save(context),
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
