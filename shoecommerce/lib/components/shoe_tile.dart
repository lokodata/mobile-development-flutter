import 'package:flutter/material.dart';
import 'package:shoecommerce/models/shoe.dart';

// ignore: must_be_immutable
class ShoeTile extends StatelessWidget {
  Shoe shoe;
  void Function() onTap;
  ShoeTile({super.key, required this.shoe, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 25),
      width: 310,
      decoration: BoxDecoration(
        color: const Color(0xFFF1F1F1),
        borderRadius: BorderRadius.circular(20),
      ),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        // shoe picture
        ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(shoe.imagePath)),

        // description
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(shoe.description,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color(0xAA272727),
              )),
        ),

        // price + detail
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // show name
                  Text(
                    shoe.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  // price
                  Text(
                    '\$${shoe.price}',
                    style: const TextStyle(color: Color(0xAA272727)),
                  ),
                ],
              ),

              // plus button
              GestureDetector(
                onTap: () => onTap(),
                child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                        color: Color(0xFF272727),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    child: const Icon(Icons.add, color: Colors.white)),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
