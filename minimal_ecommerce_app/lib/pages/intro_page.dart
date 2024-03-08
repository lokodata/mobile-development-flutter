import 'package:flutter/material.dart';
import 'package:minimal_ecommerce_app/component/my_button.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          // logo
          Icon(
            Icons.shopping_bag,
            size: 72,
            color: Theme.of(context).colorScheme.inversePrimary,
          ),

          const SizedBox(height: 25),

          // title
          const Text(
            "Minimal Ecommerce App",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),

          const SizedBox(height: 18),

          // subtitle
          Text(
            "Premium Quality Products",
            style: TextStyle(
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),

          const SizedBox(height: 25),

          // my button
          MyButton(
              onTap: () => Navigator.pushNamed(context, '/shop_page'),
              child: const Icon(Icons.arrow_forward))
        ]),
      ),
    );
  }
}
