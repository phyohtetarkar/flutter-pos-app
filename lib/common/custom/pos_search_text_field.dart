import 'package:flutter/material.dart';

class POSSearchTextField extends StatefulWidget {
  final String hint;
  final ValueChanged<String> onChange;
  final Color color;

  const POSSearchTextField({
    Key key,
    this.hint,
    this.onChange,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  _POSSearchTextFieldState createState() => _POSSearchTextFieldState();
}

class _POSSearchTextFieldState extends State<POSSearchTextField> {
  FocusNode _focusNode;

  @override
  void initState() {
    _focusNode = FocusNode();
    super.initState();
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: _focusNode,
      onChanged: widget.onChange,
      autocorrect: false,
      smartQuotesType: SmartQuotesType.disabled,
      style: TextStyle(
        fontSize: 16,
        color: widget.color,
      ),
      decoration: InputDecoration.collapsed(
        hintStyle: TextStyle(
          fontSize: 16,
          color: widget.color.withOpacity(0.7),
        ),
        hintText: widget.hint,
      ),
    );
  }
}