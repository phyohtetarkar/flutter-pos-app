import 'package:flutter/material.dart';
import 'package:latte_pos/main.dart';
import 'package:latte_pos/common/extensions.dart';

class POSConfirmDialog extends StatelessWidget {
  final String message;
  final String okButtonText;
  final Color okTextColor;

  const POSConfirmDialog({
    Key key,
    @required this.message,
    this.okButtonText = "OK",
    this.okTextColor = primaryColor,
  }) : super(key: key);

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
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
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
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text(
                        "label-cancel".localize().toUpperCase(),
                      ),
                    ),
                  ),
                  VerticalDivider(width: 1),
                  Expanded(
                    child: FlatButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text(
                        okButtonText.toUpperCase(),
                        style: TextStyle(
                          color: okTextColor,
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
