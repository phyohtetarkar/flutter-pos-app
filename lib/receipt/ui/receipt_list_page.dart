import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:latte_pos/common/custom.dart';
import 'package:latte_pos/main.dart';
import 'package:latte_pos/receipt/model/receipt_list_model.dart';
import 'package:latte_pos/receipt/ui/receipt_detail_page.dart';
import 'package:latte_pos/service_locator.dart';
import 'package:provider/provider.dart';
import 'package:latte_pos/common/extensions.dart';

class ReceiptListPage extends StatefulWidget {

  @override
  _ReceiptListPageState createState() => _ReceiptListPageState();
}

class _ReceiptListPageState extends State<ReceiptListPage> {
  final _dateFormat = DateFormat("MMMM dd, yyyy hh:mm a", "en_US");

  ScrollController _scrollController = ScrollController();

  void _navigateToDetail(int saleId) {
    final serviceLocator = Provider.of<ServiceLocator>(context, listen: false);
    final route = createRoute(ChangeNotifierProvider(
      create: (_) => serviceLocator.receiptDetailModel,
      child: ReceiptDetailPage(saleId: saleId),
    ));

    Navigator.of(context).push(route);
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        context.read<ReceiptListModel>().loadMore();
      }
    });
    context.read<ReceiptListModel>().find();
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
      title: Text(
        "label-receipts".localize(),
      ),
      actions: [
      ],
    );
    return Scaffold(
      backgroundColor: bgColor,
      appBar: _appBar,
      body: Consumer<ReceiptListModel>(
        builder: (context, model, child) {
          return ListView.separated(
            controller: _scrollController,
            itemCount: model.receipts.length,
            itemBuilder: (context, index) {
              final s = model.receipts[index];
              return Material(
                color: Colors.white,
                child: ListTile(
                  onTap: () => _navigateToDetail(s.id),
                  title: Text(
                    "${10000 + s.id}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    "${_dateFormat.format(s.issueAt)}",
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${s.totalPrice.formatCurrency()}"),
                      SizedBox(height: 4),
                      Text(
                        "${s.totalItem} item${s.totalItem > 1 ? 's' : ''}",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
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
