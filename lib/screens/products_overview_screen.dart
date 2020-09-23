import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_shop/providers/cart.dart';
import 'package:test_shop/screens/cart_screen.dart';
import 'package:test_shop/widgets/badge.dart';

import 'package:test_shop/widgets/products_grid.dart';

enum FilterOption {
  FAVORITE,
  ALL,
}

class ProductOverViewScreen extends StatefulWidget {
  @override
  _ProductOverViewScreenState createState() => _ProductOverViewScreenState();
}

class _ProductOverViewScreenState extends State<ProductOverViewScreen> {
  bool _showOnlyFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: [
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);

              },
            ),
          ),
          PopupMenuButton(
            onSelected: (FilterOption selectedValue) {
              setState(() {
                if (selectedValue == FilterOption.FAVORITE) {
                  _showOnlyFavorite = true;
                } else {
                  _showOnlyFavorite = false;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text('Only favorites'),
                value: FilterOption.FAVORITE,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOption.ALL,
              ),
            ],
          ),
        ],
      ),
      body: ProductsGrid(_showOnlyFavorite),
    );
  }
}
