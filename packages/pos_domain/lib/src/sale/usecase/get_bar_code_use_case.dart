import 'package:pos_domain/pos_domain.dart';

abstract class GetBarCodeUseCase {
  Future<ProductBarCodeDTO> getBarCode(String code);
}

class GetBarCodeUseCaseImpl implements GetBarCodeUseCase {

  final ProductRepo _repo;

  GetBarCodeUseCaseImpl(this._repo);

  @override
  Future<ProductBarCodeDTO> getBarCode(String code) {
    return _repo.getBarcodeByCode(code);
  }

}