import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/provider.dart';
import 'package:formvalidation/src/models/product.dart';
class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final productsBloc = Provider.productBloc(context);
    productsBloc.getProducts();
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Home')
      ),
      body: _getListProducts(productsBloc),
      floatingActionButton: _createButton(context),
    );
  }
  
  _createButton(BuildContext context){
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: ()=>Navigator.pushNamed(context, 'product'),
    );
  }
  
  Widget _getListProducts(ProductBloc productBloc){
    return StreamBuilder(
      stream: productBloc.productsStream, 
      builder: (BuildContext context, AsyncSnapshot<List<ProducModel>> snapshot){
         if(snapshot.hasData){
      // Creo variable para que sea mas visible 
          final products = snapshot.data;
          
          return ListView.builder(
            itemCount: products.length,
            itemBuilder:(context, i) => _createItem(context,productBloc, products[i])
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
  
  Widget _createItem(BuildContext context,ProductBloc productBloc, ProducModel product){
    //Envuelvo el ListTile en un Dismissible y genero un key unico
    return Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
        ),
        onDismissed: (directions){
          //DELETE ITEM
          productBloc.deleteProducts(product.id);
        },
        child: Card(
          child: Column(
            children: <Widget>[
              (product.photoUrl == null) ? Image(image: AssetImage('assets/no-image.png')) 
              : FadeInImage(
                image: NetworkImage(product.photoUrl),
                placeholder: AssetImage('assets/loading.gif'),
                height: 300.0,
                width: double.infinity,
                fit: BoxFit.cover
                ), 
                ListTile(
                  title: Text('${product.title} - ${product.value}'),
                  subtitle: Text(product.id),
                  onTap: () => Navigator.pushNamed(context, 'product', arguments: product),
                ),
            ],
          ),
        )
    );
  }

  
}