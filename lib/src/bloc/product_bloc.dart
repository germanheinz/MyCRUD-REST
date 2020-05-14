import 'dart:io';

import 'package:formvalidation/src/models/product.dart';
import 'package:formvalidation/src/providers/products_provider.dart';
import 'package:rxdart/rxdart.dart';

class ProductBloc{
  
  final _productController = new BehaviorSubject<List<ProducModel>>();
  
  final _loadingController = new BehaviorSubject<bool>();

  final _productsProvider = new ProductProvider();


  Stream<List<ProducModel>> get productsStream => _productController;
  Stream<bool> get loading => _loadingController.stream;

  void getProducts() async {
    final products = await _productsProvider.getProducts();
    _productController.sink.add(products);
  }
  void saveProducts(ProducModel product) async {
    _loadingController.sink.add(true);
    final products = await _productsProvider.createProduct(product);
    _loadingController.sink.add(false);
  }
  Future<String> uploadFile(File file) async {
    _loadingController.sink.add(true);
    final photo = await _productsProvider.uploadImage(file);
    _loadingController.sink.add(true);
    return photo;
  }
  void updateProducts(ProducModel product) async {
    _loadingController.sink.add(true);
    final products = await _productsProvider.updateProduct(product);
    _loadingController.sink.add(false);
  }
  void deleteProducts(String id) async {
    _loadingController.sink.add(true);
    final products = await _productsProvider.deleteProduct(id);
    _loadingController.sink.add(false);
  }




  dispose(){
    _productController?.close();
    _loadingController?.close();
  }

}