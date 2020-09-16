import 'package:flutter/material.dart';
import 'file:///C:/Users/onlyt/AndroidStudioProjects/test_shop/lib/providers/product.dart';
import 'package:test_shop/widgets/products_grid.dart';

class ProductOverViewScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
      ),
      body: ProductsGrid(),
    );
  }
}


