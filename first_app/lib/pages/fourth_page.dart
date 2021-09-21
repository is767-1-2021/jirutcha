import 'package:flutter/material.dart';

class FourthPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final List<String> entries = <String>['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N'];
    final List<int> colorCodes = <int>[600, 500, 100];

    return Scaffold(
      appBar: AppBar(
        title: Text('Listview Example'),
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(8.0),
        itemCount: entries.length,
        itemBuilder: (context, index) {
          return ProductTile(
            item: ProductItem(
              name: 'Product ${entries[index]}',
              price: '฿25',
              colorShade: colorCodes[index % 3],
            ),
          );
        },
        separatorBuilder: (context, index) => Divider(),
      ),
    );
  }
}

class ProductItem {
  final String name;
  final String price;
  final int colorShade;

  const ProductItem(
    {Key? key, required this.name, 
    required this.price, required this.colorShade});
}

class ProductTile extends StatelessWidget {
  final ProductItem item;

  const ProductTile({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, 
          MaterialPageRoute(
            builder: (context) => ProductDetail(item: item),
          ),
        );
      },
      child: Container(
        height: 100,
        color: Colors.amber[item.colorShade],
        child: Center(
          child: Text('${item.name}'),
        ),
      ),
    );
  }
}

class ProductDetail extends StatelessWidget {
  final ProductItem item;

  const ProductDetail({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Detail'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Product Name: ${item.name}'),
          Text('Price: ${item.price}'),
        ],
      ),
    );
  }

}