
import 'dart:convert';

import 'package:formvalidation/src/models/product.dart';
import 'package:http/http.dart' as http;

class ProductProvider {

  final String _url = 'https://flutter-db-9837c.firebaseio.com';

  //CREATE NEW PRODUCT
  Future<bool> createProduct(ProducModel product) async {
    final url = '$_url/products.json';
    
    final resp = await http.post(url, body: producModelToJson(product));
    
    final decodedData = json.decode(resp.body);
    
    print(decodedData);
    return true;
  }

  //GET ALL PRODUCTS
  Future<List<ProducModel>> getProducts() async {
    final List<ProducModel> products = new List();
    
    final url = '$_url/products.json';
    
    final resp = await http.get(url);
    
    final Map<String, dynamic> decodedData = json.decode(resp.body);
    
    decodedData.forEach((id, prod){
      
      final productsTemp = ProducModel.fromJson(prod); 
      productsTemp.id = id;
      products.add(productsTemp);
    });

    print(products);
    return products;
  }

  Future<bool> deleteProduct(String id) async {

    final url  = '$_url/products/$id.json';
    final resp = await http.delete(url);
    print(json.decode(resp.body));

    return true;
  } 

}