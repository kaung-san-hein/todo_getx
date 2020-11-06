import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:todos_getx/product/product.controller.dart';
import 'package:todos_getx/product/widgets/signal_product.dart';
import 'package:todos_getx/widgets/add_drawer.dart';

class ProductListPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final ProductController productController =
      Get.put<ProductController>(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text("Snap Sell"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => scaffoldKey.currentState.openDrawer(),
          icon: Icon(
            Icons.menu,
          ),
        ),
      ),
      body: Obx(
        () {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: StaggeredGridView.countBuilder(
              crossAxisCount: 4,
              itemCount: productController.productList.length,
              itemBuilder: (context, index) => SingleProduct(
                product: productController.productList[index],
              ),
              staggeredTileBuilder: (index) =>
                  StaggeredTile.count(2, index == 2 ? 2 : 3),
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
            ),
          );
        },
      ),
    );
  }
}
