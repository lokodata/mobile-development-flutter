import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoecommerce/models/cart.dart';
import 'pages/intro_page.dart';

void main() {
  runApp(const ShoeCommerce());
}

class ShoeCommerce extends StatefulWidget {
  const ShoeCommerce({super.key});

  @override
  State<ShoeCommerce> createState() => _ShoeCommerceState();
}

class _ShoeCommerceState extends State<ShoeCommerce> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Cart(),
      builder: (context, child) => MaterialApp(
        theme: ThemeData(
          dividerTheme: const DividerThemeData(color: Colors.transparent),
        ),
        debugShowCheckedModeBanner: false,
        home: const IntroPage(),
      ),
    );
  }
}
