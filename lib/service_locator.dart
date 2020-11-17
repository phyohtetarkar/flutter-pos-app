import 'package:data_source/data_source.dart';
import 'package:latte_pos/receipt/model/receipt_detail_model.dart';
import 'package:latte_pos/receipt/model/receipt_list_model.dart';
import 'package:latte_pos/report/model/overall_report_model.dart';
import 'package:latte_pos/report/model/sale_by_year_model.dart';
import 'package:latte_pos/sale/model/edit_sale_item_model.dart';
import 'package:latte_pos/sale/model/sale_complete_model.dart';
import 'package:latte_pos/sale/model/shopping_cart_model.dart';
import 'package:latte_pos/summary/model/recent_sale_items_model.dart';
import 'package:latte_pos/summary/model/summary_chart_data_model.dart';
import 'package:pos_domain/pos_domain.dart';

import 'common/model/all_category_model.dart';
import 'items/category.dart';
import 'items/discount.dart';
import 'items/product.dart';
import 'items/tax.dart';
import 'sale/model/sale_products_model.dart';

abstract class ServiceLocator {
  AllCategoryModel get allCategoryModel;

  CategoryListModel get categoryListModel;

  CategoryEditModel get categoryEditModel;

  DiscountListModel get discountListModel;

  DiscountEditModel get discountEditModel;

  TaxListModel get taxListModel;

  TaxEditModel get taxEditModel;

  ProductListModel get productListModel;

  ProductEditModel get productEditModel;

  ProductDiscountsModel get productDiscountsModel;

  ProductTaxesModel get productTaxesModel;

  ProductVariantsModel get productVariantsModel;

  ProductCategoryModel get productCategoryModel;

  SaleProductsModel get saleModel;

  ShoppingCartModel get shoppingCartModel;

  EditSaleItemModel get editSaleItemModel;

  SaleCompleteModel get saleCompleteModel;

  ReceiptListModel get receiptListModel;

  ReceiptDetailModel get receiptDetailModel;

  RecentSaleItemsModel get recentSaleItemsModel;

  SummaryChartDataModel get summaryChartDataModel;

  OverallReportModel get overallReportModel;

  SaleByYearModel get saleByYearModel;

  void close();
}

class DefaultServiceLocator extends ServiceLocator {
  final POSDatabase _db;

  DefaultServiceLocator(this._db);

  @override
  AllCategoryModel get allCategoryModel {
    final categoryRepo = CategoryRepoImpl(_db.categoryDao);
    return AllCategoryModel(
      GetAllCategoryUseCaseImpl(categoryRepo),
    );
  }

  @override
  CategoryListModel get categoryListModel {
    final categoryRepo = CategoryRepoImpl(_db.categoryDao);
    return CategoryListModel(
      GetAllCategoryWithProductCountUseCaseImpl(categoryRepo),
      DeleteCategoryUseCaseImpl(categoryRepo),
    );
  }

  @override
  CategoryEditModel get categoryEditModel {
    final categoryRepo = CategoryRepoImpl(_db.categoryDao);
    return CategoryEditModel(
      DeleteCategoryUseCaseImpl(categoryRepo),
      SaveCategoryUseCaseImpl(categoryRepo),
    );
  }

  @override
  DiscountListModel get discountListModel {
    final discountRepo = DiscountRepoImpl(_db.discountDao);
    return DiscountListModel(
      GetAllDiscountUseCaseImpl(discountRepo),
      DeleteDiscountUseCaseImpl(discountRepo),
    );
  }

  @override
  DiscountEditModel get discountEditModel {
    final discountRepo = DiscountRepoImpl(_db.discountDao);
    return DiscountEditModel(
      SaveDiscountUseCaseImpl(discountRepo),
      DeleteDiscountUseCaseImpl(discountRepo),
    );
  }

  @override
  TaxListModel get taxListModel {
    final taxRepo = TaxRepoImpl(_db.taxDao);
    return TaxListModel(
      GetAllTaxUseCaseImpl(taxRepo),
      DeleteTaxUseCaseImpl(taxRepo),
    );
  }

  @override
  TaxEditModel get taxEditModel {
    final taxRepo = TaxRepoImpl(_db.taxDao);
    return TaxEditModel(
      SaveTaxUseCaseImpl(taxRepo),
      DeleteTaxUseCaseImpl(taxRepo),
    );
  }

  @override
  ProductDiscountsModel get productDiscountsModel {
    return ProductDiscountsModel();
  }

  @override
  ProductEditModel get productEditModel {
    final productRepo = ProductRepoImpl(_db.productDao, _db.categoryDao);
    final variantRepo = VariantRepoImpl(_db.productDao);
    return ProductEditModel(
      SaveProductUseCaseImpl(productRepo, variantRepo),
      DeleteProductUseCaseImpl(productRepo, variantRepo),
      GetProductByIdUseCaseImpl(productRepo),
      _db,
    );
  }

  @override
  ProductListModel get productListModel {
    final productRepo = ProductRepoImpl(_db.productDao, _db.categoryDao);
    final variantRepo = VariantRepoImpl(_db.productDao);
    return ProductListModel(
      GetAllProductWithCategoryUseCaseImpl(productRepo),
      DeleteProductUseCaseImpl(productRepo, variantRepo),
      _db,
    );
  }

  @override
  ProductTaxesModel get productTaxesModel {
    return ProductTaxesModel();
  }

  @override
  ProductVariantsModel get productVariantsModel {
    final repo = ProductRepoImpl(_db.productDao, _db.categoryDao);
    return ProductVariantsModel(
      CheckBarCodeUseCaseImpl(repo),
    );
  }

  @override
  ProductCategoryModel get productCategoryModel => ProductCategoryModel();

  @override
  SaleProductsModel get saleModel {
    final repo = ProductRepoImpl(_db.productDao, _db.categoryDao);
    return SaleProductsModel(
      GetAllProductWithCategoryUseCaseImpl(repo),
    );
  }

  @override
  EditSaleItemModel get editSaleItemModel {
    final productRepo = ProductRepoImpl(_db.productDao, _db.categoryDao);
    final discountRepo = DiscountRepoImpl(_db.discountDao);
    return EditSaleItemModel(
      GetProductByIdUseCaseImpl(productRepo),
      GetAllDiscountUseCaseImpl(discountRepo),
    );
  }

  @override
  ShoppingCartModel get shoppingCartModel {
    final productRepo = ProductRepoImpl(_db.productDao, _db.categoryDao);
    final variantRepo = VariantRepoImpl(_db.productDao);
    final saleRepo = SaleRepoImpl(_db.saleDao);
    return ShoppingCartModel(
      BuildSaleItemUseCaseImpl(productRepo, variantRepo),
      GetBarCodeUseCaseImpl(productRepo),
      CreateSaleUseCaseImpl(saleRepo),
      _db,
    );
  }

  @override
  SaleCompleteModel get saleCompleteModel {
    final saleRepo = SaleRepoImpl(_db.saleDao);
    return SaleCompleteModel(
      GetSaleDetailUseCaseImpl(saleRepo),
    );
  }

  @override
  ReceiptListModel get receiptListModel {
    final saleRepo = SaleRepoImpl(_db.saleDao);
    return ReceiptListModel(
      GetAllSaleUseCaseImpl(saleRepo),
      GetSaleAmountUseCaseImpl(saleRepo),
    );
  }

  @override
  ReceiptDetailModel get receiptDetailModel {
    final saleRepo = SaleRepoImpl(_db.saleDao);
    return ReceiptDetailModel(
      GetSaleDetailUseCaseImpl(saleRepo),
      DeleteSaleUseCaseImpl(saleRepo),
      _db,
    );
  }

  @override
  RecentSaleItemsModel get recentSaleItemsModel {
    final saleRepo = SaleRepoImpl(_db.saleDao);
    return RecentSaleItemsModel(
      GetRecentSaleItemUseCaseImpl(saleRepo),
    );
  }

  @override
  SummaryChartDataModel get summaryChartDataModel {
    final saleRepo = SaleRepoImpl(_db.saleDao);
    return SummaryChartDataModel(
      GetWeeklySalesUseCaseImpl(saleRepo),
    );
  }

  @override
  OverallReportModel get overallReportModel {
    final saleRepo = SaleRepoImpl(_db.saleDao);
    return OverallReportModel(
      GetOverallSaleReportImpl(saleRepo),
    );
  }

  @override
  SaleByYearModel get saleByYearModel {
    final saleRepo = SaleRepoImpl(_db.saleDao);
    return SaleByYearModel(
      GetMonthlySaleUseCaseImpl(saleRepo),
    );
  }

  @override
  void close() {
    _db.close();
  }
}
