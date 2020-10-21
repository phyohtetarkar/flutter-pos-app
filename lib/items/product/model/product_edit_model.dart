import 'dart:io';

import 'package:data_source/data_source.dart';
import 'package:flutter/material.dart';
import 'package:latte_pos/main.dart';
import 'package:pos_domain/pos_domain.dart';
import 'package:path_provider/path_provider.dart';

class ProductEditModel extends ChangeNotifier {
  ProductEditModel(
    this._saveUseCase,
    this._deleteUseCase,
    this._byIdUseCase,
    this._database,
  );

  final POSDatabase _database;
  final SaveProductUseCase _saveUseCase;
  final DeleteProductUseCase _deleteUseCase;
  final GetProductByIdUseCase _byIdUseCase;

  ProductEditDTO editDTO;

  Future<ProductDetailDTO> getProduct(int id) {
    return id > 0 ? _byIdUseCase.getProduct(id) : Future.value(null);
  }

  void setEditDTO(ProductEditDTO dto) {
    editDTO = dto;
    notifyListeners();
  }

  void updateAvailable(bool available) {
    editDTO?.available = available;
    notifyListeners();
  }

  Future save({
    List<VariantDTO> variants,
    List<DiscountDTO> discounts,
    List<TaxDTO> taxes,
  }) {
    return _database.transaction(() async {
      String old = editDTO.image;
      String newImage;
      if (editDTO.imageFile != null) {
        final path = editDTO.imageFile.path;
        final extension = path.substring(path.lastIndexOf('.'));
        newImage = "${DateTime.now().toIso8601String()}$extension";
      }

      editDTO.image = newImage;

      await _saveUseCase.save(
        editDTO,
        variants: variants,
        discounts: discounts.map((e) => e.id).toList(),
        taxes: taxes.map((e) => e.id).toList(),
      );

      await _saveImage(editDTO.imageFile, name: newImage, old: old);
    });
  }

  Future delete(int id, {String image}) {
    return _database.transaction(() async {
      await _deleteUseCase.delete(id);
      if (image != null) {
        final doc = await getApplicationDocumentsDirectory();
        final dir = Directory("${doc.path}/$imageRoot");
        final file = File("${dir.path}/$image");
        final exist = await file.exists();
        if (exist) {
          file.delete();
        }
      }
    });
  }

  Future _saveImage(File original, {String name, String old}) async {
    final doc = await getApplicationDocumentsDirectory();
    final dir = Directory("${doc.path}/$imageRoot");
    final exist = await dir.exists();
    if (!exist) {
      await dir.create(recursive: true);
    }

    if (original == null && old != null) {
      await File("${dir.path}/$old").delete();
    } else if (original != null){
      await original.copy("${dir.path}/$name");
    }
  }


}
