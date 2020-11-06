import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todos_getx/product/models/category.model.dart';
import 'package:todos_getx/product/models/product.model.dart';
import 'package:todos_getx/product/product.service.dart';

class ProductController extends GetxController {
  static ProductController to = Get.find();
  TextEditingController productName;
  TextEditingController productPrice;
  TextEditingController productDesc;
  TextEditingController productQty;
  Category productCategory;

  bool isLoadingDetails = false;
  bool errorLoadingDetails = false;
  bool successLoadingDetails = false;
  Product activeProduct;

  RxList<Product> productList = <Product>[].obs;
  RxList<Product> userProductsList = <Product>[].obs;
  ProductService productService;

  ProductController() {
    productService = ProductService();
  }

  @override
  void onReady() {
    productName = TextEditingController();
    productPrice = TextEditingController();
    productDesc = TextEditingController();
    productQty = TextEditingController();
    productList.bindStream(loadProducts());
    super.onReady();
  }

  Stream<List<Product>> loadProducts() {
    return productService.findAll();
  }

  Future<void> loadDetails(String productId) async {
    try {
      isLoadingDetails = true;
      errorLoadingDetails = false;
      await productService.findOne(productId);

      isLoadingDetails = false;
      successLoadingDetails = true;
    } catch (e) {
      isLoadingDetails = false;
      successLoadingDetails = false;
      errorLoadingDetails = true;
      print(e);
    }
  }

  @override
  void onClose() {
    productName?.dispose();
    productPrice?.dispose();
    productDesc?.dispose();
    productQty?.dispose();
    super.onClose();
  }
}
