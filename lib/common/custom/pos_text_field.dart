import 'package:flutter/material.dart';
import 'package:latte_pos/common/custom.dart';
import 'package:latte_pos/main.dart';

class POSTextField extends StatefulWidget {
  final String label;
  final String hint;
  final String errorText;
  final bool secureText;
  final int maxLines;
  final int minLines;
  final TextInputType inputType;
  final TextAlign textAlign;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final bool readOnly;
  final Widget trailing;

  const POSTextField({
    Key key,
    this.hint,
    this.label,
    this.errorText,
    this.secureText = false,
    this.controller,
    this.maxLines = 1,
    this.minLines,
    this.inputType,
    this.textAlign = TextAlign.start,
    this.onChanged,
    this.readOnly = false,
    this.trailing,
  }) : super(key: key);

  @override
  _POSTextFieldState createState() => _POSTextFieldState();
}

class _POSTextFieldState extends State<POSTextField> {
  static const _padding = 12.0;
  static const _cornerRadius = 4.0;

  bool _secureText;

  Widget _secureInput(Widget input) {
    final togglePassword = SizedBox(
      width: 48,
      child: FlatButton(
        padding: EdgeInsets.all(0),
        shape: CircleBorder(),
        child: Icon(
          _secureText ? Icons.visibility_off : Icons.visibility,
          color: Colors.grey,
          size: 20,
        ),
        onPressed: () {
          setState(() {
            _secureText = !_secureText;
          });
        },
      ),
    );
    return _buildInput(
      input: input,
      trailing: togglePassword,
    );
  }

  Widget _buildInput({Widget input, Widget trailing}) {
    return Row(
      children: [
        Expanded(
          child: input,
        ),
        SizedBox(width: trailing != null ? 16 : 0),
        trailing ?? SizedBox.shrink(),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _secureText = widget.secureText;
  }

  @override
  Widget build(BuildContext context) {
    final _input = TextField(
      keyboardType: widget.inputType,
      maxLines: widget.maxLines,
      minLines: widget.minLines ?? 1,
      controller: widget.controller,
      onChanged: widget.onChanged,
      obscureText: _secureText,
      autocorrect: false,
      smartQuotesType: SmartQuotesType.disabled,
      readOnly: widget.readOnly,
      style: TextStyle(
        color: Colors.black,
      ),
      textAlign: widget.textAlign,
      decoration: InputDecoration.collapsed(
        hintStyle: TextStyle(
          fontSize: 14,
        ),
        hintText: widget.hint,
      ),
    );

    final _widgets = <Widget>[
      Container(
        padding: const EdgeInsets.only(left: _padding),
        height: 46,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_cornerRadius),
          border: Border.all(
            width: 1,
            color: widget.errorText != null ? dangerColor : Colors.grey,
          ),
          //color: widget.errorText != null ? dangerColor.withOpacity(0.2) : Colors.grey.withOpacity(0.25),
        ),
        child: widget.secureText ? _secureInput(_input) : _buildInput(input: _input, trailing: widget.trailing),
      ),
      // Divider(
      //   height: 1,
      //   color: Colors.grey,
      // ),
    ];

    if (widget.label != null) {
      final _label = Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: POSTextLabel(widget.label),
      );
      _widgets.insert(0, _label);
    }

    if (widget.errorText != null) {
      final _errorText = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Text(
          widget.errorText,
          style: TextStyle(
            color: dangerColor,
            fontSize: 12.0,
          ),
        ),
      );
      _widgets.add(SizedBox(height: 6));
      _widgets.add(_errorText);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: _widgets,
    );
  }
}
