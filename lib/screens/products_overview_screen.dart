import 'package:flutter/material.dart';
import 'package:test_shop/models/products.dart';
import 'package:test_shop/widgets/product_item.dart';

class ProductOverViewScreen extends StatelessWidget {
  final List<Products> loadProducts;

  ProductOverViewScreen(this.loadProducts);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
      ),
      body: GridView.builder(
          padding: EdgeInsets.all(10),
          itemCount: loadProducts.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10),
          itemBuilder: (ctx, i) => ProductItem(loadProducts[i].id,
              loadProducts[i].title, loadProducts[i].imageUrl)),
    );
  }
}
