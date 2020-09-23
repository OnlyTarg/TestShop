import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_shop/providers/product.dart';

import '../providers/products.dart';
import './product_item.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavs;


  ProductsGrid(this.showFavs);

  @override
  Widget build(BuildContext context) {
    final List<Product> products = showFavs ? Provider.of<Products>(context).favoriteItems : Provider.of<Products>(context).items;

    //final List <Product> products = productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,

      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        // builder: (c) => products[i],
        value: products[i],
        child: ProductItem(
          // products[i].id,
          // products[i].title,
          // products[i].imageUrl,
        ),
      ),

      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
