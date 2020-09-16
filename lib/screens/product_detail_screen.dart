import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'file:///C:/Users/onlyt/AndroidStudioProjects/test_shop/lib/providers/product.dart';
import 'package:test_shop/providers/products.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';

  /* final String id;
  final String title;*/

  /*ProductDetailScreen(this.id, this.title);*/

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final productsList = Provider.of<Products>(context,listen: false);




    final productsData = productsList.findById(productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(productsData.title),
      ),
      //body: ,
    );
  }
}
