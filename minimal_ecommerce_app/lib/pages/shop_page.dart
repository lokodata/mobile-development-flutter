import 'package:flutter/material.dart';
import 'package:minimal_ecommerce_app/component/my_drawer.dart';
import 'package:minimal_ecommerce_app/component/my_product_tile.dart';
import 'package:minimal_ecommerce_app/models/shop.dart';
import 'package:provider/provider.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  Widget build(BuildContext context) {
    // access products in shop
    final products = context.watch<Shop>().shop;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Shop Page"),
        actions: [
          // go to cart button
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/cart_page'),
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
      drawer: const MyDrawer(),
      body: ListView(
        children: [
          const SizedBox(height: 25),

          // shop subtitle
          Center(
            child: Text("Pick from a selected list of premium products",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                )),
          ),

          // product list
          SizedBox(
            height: 550,
            child: ListView.builder(
              itemCount: products.length,
              padding: const EdgeInsets.all(15),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                // get each individual product from shop
                final product = products[index];

                // return as a product tile UI
                return MyProductTile(product: product);
              },
            ),
          ),
        ],
      ),
    );
  }
}
