import 'package:flutter/material.dart';

class Product {
  final String title;
  final String desciption;
  Product(this.title, this.desciption);
}

void main(List<String> args) {
  runApp(MaterialApp(
    title: "导航的数据传递和接受",
    home: ProductList(
        products: List.generate(
            20, (index) => Product("ZHT 商品 $index", "商品详情：编号$index"))),
  ));
}

class ProductList extends StatelessWidget {
  final List<Product> products;
  ProductList({Key key, @required this.products}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("商品列表"),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(products[index].title),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ProductDetail(product: products[index]),
                  ));
            },
          );
        },
        itemCount: products.length,
      ),
    );
  }
}

class ProductDetail extends StatelessWidget {
  final Product product;
  const ProductDetail({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(product.title),
      ),
      body: Container(
        child: new Center(
          child: new Text(product.desciption),
        ),
      ),
    );
  }
}
