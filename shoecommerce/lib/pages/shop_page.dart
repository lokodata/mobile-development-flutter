import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoecommerce/components/shoe_tile.dart';
import 'package:shoecommerce/models/cart.dart';
import 'package:shoecommerce/models/shoe.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  // add shoe to cart
  void addShoeToCart(Shoe shoe) {
    Provider.of<Cart>(context, listen: false).addItemToCart(shoe);

    // alert the user, shoe successfullly added
    showDialog(
        context: context,
        builder: (context) => const AlertDialog(
              title: Text('Successfully added!'),
              content: Text('Check your cart'),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, value, child) => Column(
        children: [
          // search bar
          Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.symmetric(horizontal: 25),
            decoration: BoxDecoration(
                color: const Color(0xFF272727),
                borderRadius: BorderRadius.circular(8)),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Search',
                  style: TextStyle(color: Colors.white),
                ),
                Icon(Icons.search, color: Colors.white)
              ],
            ),
          ),

          // message
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 25),
            child: Text(
              'shoes that fit better, perform better.',
              style: TextStyle(color: Color(0xAA272727)),
            ),
          ),

          // hot picks
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Hot Picks 🔥',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                Text(
                  'See All',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blueAccent),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // list of shoes for sale
          Expanded(
            child: ListView.builder(
              itemCount: value.getShoeList().length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                // crate a shoe
                Shoe shoe = value.getShoeList()[index];

                // return the shoe
                return ShoeTile(shoe: shoe, onTap: () => addShoeToCart(shoe));
              },
            ),
          ),

          const Padding(
            padding: EdgeInsets.only(top: 25, left: 25, right: 25),
            child: Divider(
              color: Color(0xFFFBF8F4),
            ),
          ),
        ],
      ),
    );
  }
}
