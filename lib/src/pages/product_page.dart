import 'package:flutter/material.dart';
import 'package:formvalidation/src/models/product.dart';
import 'package:formvalidation/src/providers/products_provider.dart';
import 'package:formvalidation/src/utils/utils.dart' as utils;

class ProductPage extends StatefulWidget {
  
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final formKey = GlobalKey<FormState>();

  ProducModel product = new ProducModel();

  final productProvider = new ProductProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: (){},
            ),
            IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: (){},
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15.0),
        child: Container(
          child: Form(
            key: formKey,
            child: Column(children: <Widget>[
              _createName(),
              _createPrice(),
              _createStock(),
              SizedBox(height: 20.0, width: 20.0),
              _createButton(),
            ],
            )
          ),
        ),
      ),
    );
  }

  Widget _createName(){
    return TextFormField(
      initialValue: product.title,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Product'
      ),
      onSaved: (value) => product.title = value,
      validator: (value){
        if(value.length<3){
          return 'Ingrese el nombre del producto';
        }else{
          return null;
        }
      },
    );
  }

  Widget _createPrice(){
  return TextFormField(
    initialValue: product.value.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Price'
      ),
      onSaved: (value) => product.value = double.parse(value),
      validator: (value) {
        if(utils.isNumeric(value)){
          return null;
        }else{
          return 'Solo numeros';
        }
      }
    );
  }
  Widget _createStock(){

    //Creamos el switch
    return SwitchListTile(
      value: product.stock,
      title: Text('In Stock'),
      activeColor: Colors.deepPurple,
      onChanged: (value) => setState((){
        product.stock = value;
        print(product.stock);
        }), 
      );
  }

  Widget _createButton(){
    return RaisedButton.icon(
      label: Text('Save'),
      icon: Icon(Icons.save),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Colors.deepPurple,
      textColor: Colors.white,
      onPressed: _submit,
    );
  }

  void _submit(){

    if(!formKey.currentState.validate()) return;

    //Dispara el save de todos los textfields que esten en el form
    formKey.currentState.save();

    print('OK');
    print('title: ${product.title}');
    print('value: ${product.value}');
    print('value: ${product.stock}');
    productProvider.createProduct(product);
    
    
  }


}