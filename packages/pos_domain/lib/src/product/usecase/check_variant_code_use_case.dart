import 'package:pos_domain/pos_domain.dart';

abstract class CheckBarCodeUseCase {
  Future<bool> checkVariantCodeDuplicate(String code, {int variantId});
}

class CheckBarCodeUseCaseImpl implements CheckBarCodeUseCase {

  final ProductRepo _repo;

  CheckBarCodeUseCaseImpl(this._repo);

  @override
  Future<bool> checkVariantCodeDuplicate(String code, {int variantId}) {
    return _repo.getBarcodeByCode(code).then((value) {
      if (value == null) {
        return false;
      }

      return value.variantId == null || value.variantId != variantId;
    });
  }

}