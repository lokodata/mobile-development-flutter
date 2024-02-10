import 'package:flutter/material.dart';
import 'package:shoecommerce/pages/home_page.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF8F4),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // logo
            Padding(
              padding: const EdgeInsets.all(35.0),
              child: Image.asset(
                'lib/assets/images/nb-logo.png',
                height: 240,
              ),
            ),

            const SizedBox(height: 30),

            // title
            const Text('We Got Now',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF272727))),

            const SizedBox(height: 24),

            // subtitle
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                '''It is all about comfort, style, and durability. They screamed "Wear me, and you won`t regret it!"''',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xAA272727),
                ),
                textAlign: TextAlign.left,
              ),
            ),

            const SizedBox(height: 30),

            // start now button
            GestureDetector(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomePage())),
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF2D1A),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: const EdgeInsets.all(25),
                  child: const Center(
                    child: Text(
                      'Shop Now',
                      style: TextStyle(
                        color: Color(0xFFFBF8F4),
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
