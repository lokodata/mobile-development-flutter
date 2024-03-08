import 'package:flutter/material.dart';
import 'package:minimal_ecommerce_app/models/product.dart';
import 'package:minimal_ecommerce_app/models/shop.dart';
import 'package:provider/provider.dart';

class MyProductTile extends StatelessWidget {
  final Product product;

  const MyProductTile({
    super.key,
    required this.product,
  });

  // add to cart button pressed
  void addToCart(BuildContext context) {
    // ask user to confirm to add cart
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text("Add this item to you cart?"),
        actions: [
          // cancel button
          MaterialButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),

          // confirm button
          MaterialButton(
            onPressed: () {
              // pop the dialog
              Navigator.pop(context);

              // add product to cart
              context.read<Shop>().addToCart(product);
            },
            child: const Text("Confirm"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(25),
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // product_image
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(25),
                    width: double.infinity,
                    child: Image.asset(product.imagePath)),
              ),

              const SizedBox(height: 25),

              // product_name
              Text(
                product.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),

              const SizedBox(height: 10),

              // product_description
              Text(
                product.description,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ],
          ),

          const SizedBox(height: 25),

          // product_price + add to cart button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("\$${product.price.toStringAsFixed(2)}"),

              // add to cart button
              Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(12)),
                child: IconButton(
                  onPressed: () => addToCart(context),
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
