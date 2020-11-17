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

    Navigator.of(context).push(route).then((value) {
      if (value != null && value is bool && value) {
        context.read<ReceiptListModel>().find();
      }
    });
  }

  Future _filterByDate() async {
    final model = context.read<ReceiptListModel>();
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: model.search.date ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      cancelText: "label-cancel".localize(),
      confirmText: "label-ok".localize(),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light().copyWith(
              primary: Theme.of(context).primaryColor,
            ), 
            primaryColor: Theme.of(context).primaryColor,//selection color
            dialogBackgroundColor: Colors.white, //Background color
          ),
          child: child,
        );
      },
    );

    if (picked != null && picked != model.search.date) {
      model.date = picked;
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
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
        IconButton(
          icon: Icon(Icons.today),
          onPressed: _filterByDate,
        ),
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: Container(
          height: 56,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                color: Colors.grey[400],
                width: 0.7,
              ),
            ),
          ),
          child: Consumer<ReceiptListModel>(
            builder: (context, model, child) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Builder(
                      builder: (context) {
                        final date = model.search.date;
                        final format = DateFormat("MMM dd, yyyy");
                        if (date != null) {
                          return RawChip(
                            label: Text(
                              format.format(date),
                            ),
                            onDeleted: () {
                              model.date = null;
                            },
                          );
                        }
                        return Text(
                          "label-all-receipts".localize(),
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        );
                      },
                    ),
                    Spacer(),
                    Text(
                      model.totalAmount.formatCurrency(),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600],
                        fontFamily: "Roboto",
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
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
                    s.code,
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
                      //SizedBox(height: 4),
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
            separatorBuilder: (context, index) =>
                Divider(height: 1, color: Colors.transparent),
          );
        },
      ),
    );
  }
}
