import 'dart:io';

import 'package:flutter/material.dart';
import 'package:formvalidation/src/models/product.dart';
import 'package:formvalidation/src/providers/products_provider.dart';
import 'package:formvalidation/src/utils/utils.dart' as utils;
import 'package:image_picker/image_picker.dart';

class ProductPage extends StatefulWidget {
  
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final formKey     = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  ProducModel product = new ProducModel();

  final productProvider = new ProductProvider();

  bool _saving = false;

  File photo;

  @override
  Widget build(BuildContext context) {

    // Recibo los argumentos de homePage para update de producto y valido si vino o no  
    final ProducModel productFromHome = ModalRoute.of(context).settings.arguments;
    if(productFromHome != null){
      product = productFromHome;
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: _selectPhoto,
            ),
            IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: _takePicture,
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15.0),
        child: Container(
          child: Form(
            key: formKey,
            child: Column(children: <Widget>[
              _showImage(),
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
      onPressed: (_saving) ? null : _submit,
    );
  }

  void _submit() async {

    if(!formKey.currentState.validate()) return;

    //Dispara el save de todos los textfields que esten en el form
    formKey.currentState.save();

    setState(() { _saving = true; });

    if(photo != null){
      product.photoUrl = await productProvider.uploadImage(photo);
    }
    
    print('OK');
    print('title: ${product.title}');
    print('value: ${product.value}');
    print('value: ${product.stock}');

    if(product.id == null){
      productProvider.createProduct(product);
    }else{
      productProvider.updateProduct(product);
    }
    setState(() { _saving = false; });
    showSnackBar('Saved!');
    Navigator.pop(context);
    
  }

  void showSnackBar(String message){
    final snackBar = SnackBar(
      content : Text(message),
      duration: Duration(milliseconds: 1500),
    );

    scaffoldKey.currentState.showSnackBar(snackBar);
  }

  Widget _showImage(){
    if(product.photoUrl != null){
      return Container();
    }else{
      return Image(
        image: AssetImage(photo?.path ?? 'assets/no-image.png'),
        height: 300.0,
        fit: BoxFit.cover,
      );
    }
  }

  _selectPhoto() async {
    _imageProccesor(ImageSource.gallery);
  }

  _takePicture() async {
   _imageProccesor(ImageSource.camera);
  }

  _imageProccesor(ImageSource origin) async {
    photo = await ImagePicker.pickImage(
      source: origin
    );

    if(photo != null){
      //TODO celan
    setState(() {
      photo = photo;
    });
    }
  }

 
}