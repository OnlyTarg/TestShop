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
  final _imageUrlControler = TextEditingController();
  GlobalKey<FormState> _form1 = GlobalKey<FormState>();
  bool _isInit = true;
  bool _isLoading = false;
  Map<String, String> _editedProduct = {
    'id': '',
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };

  final _imageUrlFocusNode = FocusNode();
  Map<String, String> _savedProduct = {
    'id': '',
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);

    super.initState();
  }

  @override
  void didChangeDependencies() {
    var products = Provider.of<Products>(context);

    print(_isInit.toString());
    if (_isInit) {
      String productId = ModalRoute.of(context).settings.arguments as String;
      var product;
      if ((product = products.findById(productId)) != null) {
        _editedProduct = {
          'id': product.id.toString(),
          'title': product.title,
          'description': product.description,
          'price': product.price.toString(),
          // 'imageUrl': ''product.imageUrl,''
        };
        print(product.id);

        _imageUrlControler.text = product.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void saveForm() {


    var products = Provider.of<Products>(context);

    if (_form1.currentState.validate()) {
      _form1.currentState.save();
      setState(() {
        _isLoading = true;
      });
      var product = Product(
          imageUrl: _savedProduct['imageUrl'],
          price: _savedProduct['price'] != ""
              ? double.parse(_savedProduct['price'])
              : 0.0,
          id: _editedProduct['id'],
          title: _savedProduct['title'],
          description: _savedProduct['description']);

      products.addProduct(product).then((value) {
        setState(() {
          _isLoading = false;
        });

        Navigator.of(context).pop();
      });
    }
    ;
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlControler.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit product'),
        actions: [
          FlatButton(
            child: Icon(Icons.save),
            onPressed: () {
              saveForm();

              /*print(product.id);
              print(product.title);
              print(product.price);
              print(product.imageUrl);
              print(product.description);*/
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Form(
                autovalidate: false,
                key: _form1,
                child: ListView(
                  children: [
                    TextFormField(
                        initialValue: _editedProduct['title'],
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter title';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Title',
                        ),
                        onSaved: (value) {
                          _savedProduct['title'] = value;
                        },
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          return FocusScope.of(context)
                              .requestFocus(_priceFocusNode);
                        }),
                    TextFormField(
                        initialValue: _editedProduct['price'],
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter title';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Price',
                        ),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        focusNode: _priceFocusNode,
                        onSaved: (value) {
                          value != null ? _savedProduct['price'] = value : '0';
                        },
                        onFieldSubmitted: (_) {
                          return FocusScope.of(context)
                              .requestFocus(_descriptionFocusNode);
                        }),
                    TextFormField(
                      initialValue: _editedProduct['description'],
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter title';
                        }

                        return null;
                      },
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
                          child: _imageUrlControler.text.isEmpty
                              ? Text(DateTime.now().toString())
                              : FittedBox(
                                  fit: BoxFit.cover,
                                  child: Image.network(_imageUrlControler.text),
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                            //initialValue: _editedProduct['imageUrl'],
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter title';
                              }
                              if (!value.startsWith('http') ||
                                  !value.startsWith('https')) {
                                return 'Please enter valid Url';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _savedProduct['imageUrl'] = value;
                            },
                            decoration: InputDecoration(labelText: 'Image URL'),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            //controller: _imageUrlControler,
                            controller: _imageUrlControler,
                            focusNode: _imageUrlFocusNode,
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
