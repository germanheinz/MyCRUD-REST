
import 'dart:convert';
import 'dart:io';

import 'package:formvalidation/src/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';

class ProductProvider {

  final String _url = 'https://flutter-db-9837c.firebaseio.com';


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
  
  //CREATE NEW PRODUCT
  Future<bool> createProduct(ProducModel product) async {
    final url = '$_url/products.json';
    
    final resp = await http.post(url, body: producModelToJson(product));
    
    final decodedData = json.decode(resp.body);
    
    print(decodedData);
    return true;
  }

  //UPDATE NEW PRODUCT
  Future<bool> updateProduct(ProducModel product) async {
    final url  = '$_url/products/${product.id}.json';
    
    final resp = await http.put(url, body: producModelToJson(product));
    
    final decodedData = json.decode(resp.body);
    
    print(decodedData);
    return true;
  }

  //DELETE PRODUCT
  Future<bool> deleteProduct(String id) async {

    final url  = '$_url/products/$id.json';
    final resp = await http.delete(url);
    print(json.decode(resp.body));

    return true;
  } 

  //UPLOAD FILE -- https://pub.dev/packages/image_picker#-readme-tab-  & mime type
  Future<String> uploadImage(File image) async {
    
    final url = Uri.parse('https://api.cloudinary.com/v1_1/cloudinarygh/image/upload?upload_preset=lj7cpwrc');

    //Como saber el mime type de la imagen
    // https://pub.dev/packages/mime_type#-readme-tab-
    final mimeType = mime(image.path).split('/');
    final imageUploadRequest = http.MultipartRequest(
      'POST',
      url
    );

    final file = await http.MultipartFile.fromPath(
      'file', 
      image.path, 
      contentType: MediaType(mimeType[0], mimeType[1])
    );

    imageUploadRequest.files.add(file);
    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if(resp.statusCode != 200 && resp.statusCode != 201){
      print('Algo salio mal');
      print(resp.body);
      return null;
    }

    final responseData = json.decode(resp.body);
    print(responseData);
    return responseData['secure_url'];

  }

}