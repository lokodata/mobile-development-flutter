import 'package:flutter/material.dart';
import 'package:shoecommerce/models/shoe.dart';

class Cart extends ChangeNotifier {
  // list of shoes for sale
  List<Shoe> shoeShop = [
    Shoe(
      name: '9060',
      price: '150',
      imagePath: 'lib/assets/images/9060-white.png',
      description:
          'The 9060 is a new expression of the refined style and innovation-led design of the classic 99X series.',
    ),
    Shoe(
      name: '9060',
      price: '150',
      imagePath: 'lib/assets/images/9060-black.png',
      description:
          'The 9060 a warped sensibility inspired by the proudly futuristic, visible tech aesthetic of the Y2K era.',
    ),
    Shoe(
      name: '996 Core',
      price: '175',
      imagePath: 'lib/assets/images/996-core-brown.png',
      description:
          '''The 996`s a subtly streamlined exterior design, making for an exceptionally wearable, high-performance shoe.''',
    ),
    Shoe(
      name: '990v6',
      price: '200',
      imagePath: 'lib/assets/images/990v6-grey.png',
      description:
          'The MADE in USA 990v6 embraces this original mandate, with a series of performance-inspired updates.',
    ),
    Shoe(
      name: '574',
      price: '90',
      imagePath: 'lib/assets/images/574-black-matter.png',
      description:
          'The 574 was built to be a reliable shoe that could do a lot of different things.',
    ),
    Shoe(
      name: '550',
      price: '110',
      imagePath: 'lib/assets/images/550-dark-olivine.png',
      description:
          'The 550`s low top, streamlined silhouette offers a clean take on the heavy-duty designs.',
    ),
  ];

  // list of items in user cart
  List<Shoe> userCart = [];

  // get list of shoes for sale
  List<Shoe> getShoeList() {
    return shoeShop;
  }

  // get cart
  List<Shoe> getUserCart() {
    return userCart;
  }

  // add item to cart
  void addItemToCart(Shoe shoe) {
    userCart.add(shoe);
    notifyListeners();
  }

  // remove item from cart
  void removeItemFromCart(Shoe shoe) {
    userCart.remove(shoe);
    notifyListeners();
  }
}
