import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './product.dart';

class Products with ChangeNotifier {
  bool isInit = false;
  List<Product> _items = [];

  /*
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];*/

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere(
      (prod) => prod.id == id,
      orElse: () => null,
    );
  }

  Future<void> addProduct(Product product) {
    const url = 'https://badguys.firebaseio.com/products.json';
    return http
        .post(url,
            body: json.encode({
              'title': product.title,
              'description': product.description,
              'price': product.price,
              'isfavorite': product.isFavorite,
              'imageUrl': product.imageUrl,
            }))
        .then((result) {
      if (product.id != '') {
        Product editedProduct = findById(product.id);
        _items.remove(editedProduct);
        _items.add(product);
        notifyListeners();
      } else {
        var newProduct = Product(
          id: json.decode(result.body)['name'],
          description: product.description,
          title: product.title,
          imageUrl: product.imageUrl,
          price: product.price,
          isFavorite: product.isFavorite,
        );
        _items.add(newProduct);
        notifyListeners();
      }
    }).then((value) => null);
  }

  void removeProduct(Product product) {
    _items.remove(product);
    notifyListeners();
  }

  Future<void> fetchAndSetProducts() async {
    const url = 'https://badguys.firebaseio.com/products.json';

    try {
      final response = await http.get(url);
      Map extractedData = json.decode(response.body) as Map<String, Object>;
      extractedData.forEach((key, value) {
        _items.add(Product(
          id: key,
          title: value['title'],
          price: 25,
          //double.parse(value['price']),
          imageUrl: value['imageUrl'],
          description: value["description"],
        ));
      });

      print(_items[1].title);
      print(_items[1].description);
      print(_items[1].price);
      print(_items[1].imageUrl);
      print(_items[1].id);

      notifyListeners();
      //final  extractedData = json.decode(response.body) as Map<>
    } catch (e) {
      throw e;
    }
  }
}
