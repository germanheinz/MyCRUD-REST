import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/provider.dart';
import 'package:formvalidation/src/models/product.dart';
import 'package:formvalidation/src/providers/products_provider.dart';

class HomePage extends StatelessWidget {

  final productProvider = new ProductProvider();

  @override
  Widget build(BuildContext context) {

    final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home')
      ),
      body: _getListProducts(),
      floatingActionButton: _createButton(context),
    );
  }
  _createButton(BuildContext context){
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: ()=>Navigator.pushNamed(context, 'product'),
    );
  }
  Widget _getListProducts(){
    return FutureBuilder(
      future: productProvider.getProducts(),
      builder: (BuildContext context, AsyncSnapshot<List<ProducModel>> snapshot) {
        if(snapshot.hasData){
          return Container();
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}