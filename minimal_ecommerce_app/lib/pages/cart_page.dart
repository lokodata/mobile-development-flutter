import 'package:flutter/material.dart';
import 'package:minimal_ecommerce_app/component/my_button.dart';
import 'package:minimal_ecommerce_app/component/my_drawer.dart';
import 'package:minimal_ecommerce_app/models/product.dart';
import 'package:minimal_ecommerce_app/models/shop.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  // remove item frm cart method
  void removeItemFromCart(BuildContext context, Product product) {
    // ask user to confirm to remove from cart
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text("Remove this item from your cart?"),
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
              context.read<Shop>().removeFromCart(product);
            },
            child: const Text("Confirm"),
          )
        ],
      ),
    );
  }

  // user pressed pay button
  void payButtonPressed(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const AlertDialog(
        content: Text("User wants to pay! Connect this app to your backend!"),
      ),
    );
  }

  // total price of cart
  double totalPrice(BuildContext context) {
    // get access to the cart
    final cart = context.read<Shop>().cart;

    // get total price
    double total = 0;
    for (var item in cart) {
      total += item.price;
    }

    return total;
  }

  @override
  Widget build(BuildContext context) {
    // get access to the cart
    final cart = context.watch<Shop>().cart;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Cart Page"),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      drawer: const MyDrawer(),
      body: Column(
        children: [
          // cart list
          Expanded(
            child: cart.isEmpty
                ? const Center(
                    child: Text(
                      "Your cart is empty.\nStart shopping!",
                      textAlign: TextAlign.center,
                    ),
                  )
                : ListView.builder(
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      // get individual items in cart
                      final item = cart[index];

                      // return the items as a cart tile UI
                      return ListTile(
                        title: Text(item.name),
                        subtitle: Text(item.price.toStringAsFixed(2)),
                        trailing: IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () => removeItemFromCart(context, item)),
                      );
                    },
                  ),
          ),

          // pay button
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: MyButton(
                onTap: () => payButtonPressed(context),
                child: Text("Pay \$${totalPrice(context)}")),
          )
        ],
      ),
    );
  }
}
