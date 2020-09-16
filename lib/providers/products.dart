import 'package:flutter/material.dart';
import 'package:test_shop/data/products_dammy.dart';
import 'package:test_shop/providers/product.dart';


class Products with ChangeNotifier {
  final _items = ProductDummy.loadProducts;

  get items {
    return [..._items];
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id== id);

  }

  void addProduct() {
    // _items.add(value);
    notifyListeners();
  }
}
