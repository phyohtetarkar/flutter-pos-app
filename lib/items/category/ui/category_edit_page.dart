import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latte_pos/common/custom.dart';
import 'package:latte_pos/items/category.dart';
import 'package:latte_pos/main.dart';
import 'package:pos_domain/pos_domain.dart';
import 'package:provider/provider.dart';
import 'package:latte_pos/common/extensions.dart';

const List<int> _colors = [
  0xffa2a2a2,
  0xffe91e63,
  0xff2196f3,
  0xff00bcd4,
  0xffD50002,
  0xff4caf50,
  0xffff5722,
  0xffffc107,
  0xffcddc39,
  0xffff9800,
  0xff795548,
  0xff9C27B0,
  0xff3f51b5,
];

class CategoryEditPage extends StatefulWidget {
  final CategoryDTO category;

  CategoryEditPage({
    Key key,
    this.category,
  }) : super(key: key);

  @override
  _CategoryEditPageState createState() => _CategoryEditPageState();
}

class _CategoryEditPageState extends State<CategoryEditPage> with TickerProviderStateMixin {
  String _nameInputError;
  int _selectedColor;

  TextEditingController _nameInputController;
  ScrollController _colorScrollController;
  //AnimationController _controller;
  //Animation<Offset> _offset;

  final _globalKey = GlobalKey<ScaffoldState>();

  void _save(BuildContext context) {
    if (_validateInputs()) {
      final dto = CategoryDTO(
        id: widget.category?.id,
        name: _nameInputController.text,
        color: _selectedColor,
      );
      Provider.of<CategoryEditModel>(context, listen: false).save(dto).then((value) {
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
        context.read<CategoryEditModel>().delete(widget.category.id).then(
          (value) {
            Navigator.of(context).pop();
          },
          onError: (error) {
            final snackBar = SnackBar(
              content: Text(
                "Unable to delete category.",
              ),
              backgroundColor: dangerColor,
            );
            _globalKey.currentState.showSnackBar(snackBar);
          },
        );
      }
    });
  }

  bool _validateInputs() {
    var valid = _nameInputController.text.isNotEmpty;
    setState(() {
      _nameInputError = !valid ? "error-input-category-name".localize() : null;
    });
    return valid;
  }

  @override
  void initState() {
    _nameInputController = TextEditingController(text: widget.category?.name);
    _selectedColor = widget.category?.color ?? _colors[0];
    final pos = _colors.indexOf(_selectedColor);
    _colorScrollController = ScrollController(initialScrollOffset: pos * 48.0);
    super.initState();

    // _controller = AnimationController(
    //   duration: const Duration(milliseconds: 400),
    //   vsync: this,
    // );
    //
    // _offset = Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0))
    //     .chain(CurveTween(curve: Curves.ease))
    //     .animate(_controller);
    //
    // Future.delayed(const Duration(milliseconds: 300), () {
    //   _controller.forward();
    // });
  }

  @override
  void dispose() {
    _nameInputController.dispose();
    _colorScrollController.dispose();
    //_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool update = (widget.category?.id ?? 0) > 0;
    final _appBar = AppBar(
      elevation: 0,
      title: Text(
        "${update ? 'label-update-category' : 'label-create-category'}".localize(),
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
        // SizedBox(
        //   width: 70,
        //   child: FlatButton(
        //     padding: const EdgeInsets.all(0),
        //     onPressed: () => _saveCategory(context),
        //     shape: CircleBorder(),
        //     textColor: Colors.white,
        //     child: Text(
        //       "SAVE",
        //     ),
        //   ),
        // ),
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
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(4),
                  // ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        POSTextField(
                          controller: _nameInputController,
                          label: "label-name".localize(),
                          hint: "hint-enter-category-name".localize(),
                          errorText: _nameInputError,
                        ),
                        SizedBox(height: 16),
                        POSTextLabel("label-representation-color".localize()),
                        Divider(),
                        SizedBox(
                          height: 56,
                          child: ListView.separated(
                            padding: const EdgeInsets.symmetric(horizontal: 1),
                            scrollDirection: Axis.horizontal,
                            controller: _colorScrollController,
                            itemBuilder: (context, index) {
                              int color = _colors[index];
                              bool selected = color == _selectedColor;
                              return Container(
                                padding: const EdgeInsets.all(2),
                                decoration: ShapeDecoration(
                                  shape: CircleBorder(
                                    side: BorderSide(
                                      color: selected ? Color(color) : Colors.transparent,
                                    ),
                                  ),
                                ),
                                child: Material(
                                  shape: CircleBorder(),
                                  color: Color(color),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        _selectedColor = color;
                                      });
                                    },
                                    customBorder: CircleBorder(),
                                    child: CircleAvatar(
                                      radius: 24,
                                      backgroundColor: Colors.transparent,
                                      child: selected ? Icon(Icons.check, color: Colors.white, size: 38) : null,
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) => SizedBox(width: 8),
                            itemCount: _colors.length,
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

