
import 'dart:convert';

import 'package:formvalidation/src/models/product.dart';
import 'package:http/http.dart' as http;

class ProductProvider {

  final String _url = 'https://flutter-db-9837c.firebaseio.com';

  Future<bool> createProduct(ProducModel product) async {
    final url = '$_url/products.json';
    
    final resp = await http.post(url, body: producModelToJson(product));
    
    final decodedData = json.decode(resp.body);
    
    print(decodedData);
    return true;
  }
}