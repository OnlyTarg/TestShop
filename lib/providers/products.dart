import 'package:flutter/material.dart';
import 'package:test_shop/data/products_dammy.dart';
import 'package:test_shop/providers/product.dart';


class Products with ChangeNotifier {
  final _items = ProductDummy.loadProducts;
  var showFavoritesOnly = false;

  List <Product> get items {
   /* if (showFavoritesOnly){
      return _items.where((element) => element.isFavorite).toList();
    }*/
    return _items;
  }

  List<Product>  get favoriteItems {
    return _items.where((element) => element.isFavorite == true).toList();
    /* if (showFavoritesOnly){
      return _items.where((element) => element.isFavorite).toList();
    }*/
  }

 /* void showFavoriteOnly(){
    showFavoritesOnly = true;
    notifyListeners();
  }

  void showAll(){
    showFavoritesOnly = false;
    notifyListeners();
  }*/

  Product findById(String id) {
    return _items.firstWhere((element) => element.id== id);

  }

  void addProduct() {
    // _items.add(value);
    notifyListeners();
  }
}
