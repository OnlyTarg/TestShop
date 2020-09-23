import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_shop/providers/cart.dart';
import 'package:test_shop/providers/products.dart';
import 'package:test_shop/widgets/cart_item.dart' as ci;

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('Корзина'),
        ),
        body: Column(
          children: [
            Card(
              margin: EdgeInsets.all(15),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total', style: TextStyle(fontSize: 20)),
                    Spacer(),
                    Chip(
                      label: Text(
                        '\$${cart.totalAmount}',
                        style: TextStyle(
                            color:
                                Theme.of(context).primaryTextTheme.title.color),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    FlatButton(
                      child: Text('Order Now'),
                      textColor: Theme.of(context).primaryColor,
                      onPressed: () {},
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),

           /* Text(cart.items.values.toList()[0].id)*/
            Expanded(
              child: ListView.builder(
                  itemCount: cart.itemCount,
                  itemBuilder: (ctx, i) => ci.CartItem(
                        cart.items.values.toList()[i].id,
                        cart.items.keys.toList()[i],
                        cart.items.values.toList()[i].price,
                        cart.items.values.toList()[i].quantity,
                        cart.items.values.toList()[i].title,

                      )),
            )
          ],
        ));
  }
}
