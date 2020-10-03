import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/products.dart';
import 'package:provider/provider.dart';
import '../providers/product.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit_product-screen';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final imageUrlControler = TextEditingController();
  GlobalKey<FormState> _form1 = GlobalKey<FormState>();

  final imageUrlFocusNode = FocusNode();
  Map<String, String> _savedProduct = {
    'id': '',
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };

  @override
  void initState() {
    imageUrlFocusNode.addListener(_updateImageUrl);

    super.initState();
  }

  void _updateImageUrl() {
    if (!imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void saveForm() {
    _form1.currentState.save();
  }

  @override
  void dispose() {
    imageUrlFocusNode.removeListener(_updateImageUrl);

    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    imageUrlControler.dispose();
    imageUrlFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var products = Provider.of<Products>(context);
    //product.addProduct(_savedProduct);
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit product'),
        actions: [
          FlatButton(
            child: Icon(Icons.save),
            onPressed: () {
              saveForm();
              var product = Product(
                  imageUrl: _savedProduct['imageUrl'],
                  price: double.parse(_savedProduct['price']),
                  id: _savedProduct['id'],
                  title: _savedProduct['title'],
                  description: _savedProduct['description']);

              products.addProduct(product);
              print(product.id);
              print(product.title);
              print(product.price);
              print(product.imageUrl);
              print(product.description);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _form1,
          child: ListView(
            children: [
              TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Title',
                  ),
                  onSaved: (value) {
                    _savedProduct['title'] = value;
                  },
                  onEditingComplete: () {
                    print('editing complite');
                  },
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    return FocusScope.of(context).requestFocus(_priceFocusNode);
                  }),
              TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Price',
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _priceFocusNode,
                  onSaved: (value) {
                    _savedProduct['price'] = value;
                  },
                  onFieldSubmitted: (_) {
                    return FocusScope.of(context)
                        .requestFocus(_descriptionFocusNode);
                  }

                  //focusNode: _priceFocusNode,
                  ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionFocusNode,
                onSaved: (value) {
                  _savedProduct['description'] = value;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(top: 8, right: 10),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey)),
                    child: imageUrlControler.text.isEmpty
                        ? Text(DateTime.now().toString())
                        : FittedBox(
                            fit: BoxFit.cover,
                            child: Image.network(imageUrlControler.text),
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      onSaved: (value) {
                        _savedProduct['imageUrl'] = value;
                      },
                      decoration: InputDecoration(labelText: 'Image URL'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: imageUrlControler,
                      focusNode: imageUrlFocusNode,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
