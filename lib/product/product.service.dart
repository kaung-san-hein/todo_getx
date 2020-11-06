import 'dart:async';

import 'package:todos_getx/product/models/image.model.dart';

import './models/product.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductService {
  CollectionReference productsRef = Firestore.instance.collection("products");

  Stream<List<Product>> findAll() {
    return productsRef.getDocuments().then((value) {
      return value.documents.map((e) => Product.fromSnapshot(e)).toList();
    }).asStream();
  }

  Future<Product> findOne(String id) async {
    DocumentSnapshot result = await productsRef.document(id).get();
    return Product.fromSnapshot(result);
  }

  Future<Product> addOne({
    String userId,
    String username,
    String name,
    String desc,
    double price,
    int quantity,
  }) async {
    DocumentReference result = await productsRef.add({
      "user_id": userId,
      "username": username,
      "name": name,
      "desc": desc,
      "price": price,
      "quantity": quantity,
      "created_at": DateTime.now().toUtc().toString(),
    });

    return Product(
      id: result.documentID,
      name: name,
      desc: desc,
      userId: userId,
      username: username,
      price: price,
      quantity: quantity,
    );
  }

  Future<void> updateOne(Product product) async {
    await productsRef.document(product.id).updateData(product.toJson());
  }

  Future<void> deleteOne(String id) async {
    await productsRef.document(id).delete();
  }

  Future<void> addGallery(String productId, List<ImageModel> images) async {
    await productsRef.document(productId).updateData({
      "gallery": images.map((e) => e.toJson()).toList(),
    });
  }
}
