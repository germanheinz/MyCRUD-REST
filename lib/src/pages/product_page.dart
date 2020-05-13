import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({Key key}) : super(key: key);

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
            child: Column(children: <Widget>[
              _createName(),
              _createPrice(),
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
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Product'
      ),
    );
  }

  Widget _createPrice(){
  return TextFormField(
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Price'
      ),
    );
  }
  Widget _createButton(){
    return RaisedButton.icon(
      label: Text('Save'),
      icon: Icon(Icons.save),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Colors.deepPurple,
      textColor: Colors.white,
      onPressed: (){},
    );
  }
}