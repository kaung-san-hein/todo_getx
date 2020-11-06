import 'package:flutter/material.dart';
import 'package:todos_getx/product/views/add_product.view.dart';
import 'package:todos_getx/product/views/product_list.view.dart';

class SnapSell extends StatefulWidget {
  @override
  _SnapSellState createState() => _SnapSellState();
}

class _SnapSellState extends State<SnapSell> {
  int _currentIndex = 0;
  final PageController pageController = PageController();

  @override
  void initState() {
    pageController.addListener(() {
      setState(() {
        _currentIndex = pageController.page.toInt();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: <Widget>[
          ProductListPage(),
          AddProductPage(),
          Center(
            child: Container(
              child: Text("Hello 3"),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        backgroundColor: Colors.blue.withOpacity(.1),
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
          pageController.animateToPage(
            value,
            duration: Duration(milliseconds: 400),
            curve: Curves.easeIn,
          );
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            title: Text("Shop"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_a_photo),
            title: Text("Add"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text("Profile"),
          ),
        ],
      ),
    );
  }
}
