import 'package:flutter/material.dart';
import 'package:shoecommerce/components/bottom_nav_bar.dart';
import 'package:shoecommerce/pages/cart_page.dart';
import 'package:shoecommerce/pages/shop_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // this selected index is to control the bottom nav bar
  int _selectedIndex = 0;

  // update selected index method when user taps on bottom bar
  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // pages to display
  final List<Widget> _pages = <Widget>[
    // shop page
    const ShopPage(),

    // cart page
    const CartPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF8F4),
      bottomNavigationBar: MyBottomNavBar(
        onTabChange: (index) => navigateBottomBar(index),
      ),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFBF8F4),
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Padding(
              padding: EdgeInsets.only(left: 12),
              child: Icon(Icons.menu, color: Color(0xFF272727)),
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      drawer: const Drawer(
        backgroundColor: Color(0xFFFBF8F4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                // logo
                DrawerHeader(
                    decoration: BoxDecoration(),
                    child: Image(
                      image: AssetImage('lib/assets/images/nb-logo.png'),
                      width: 150,
                    )),

                Padding(
                    padding: EdgeInsets.all(25.0),
                    child: Divider(
                      color: Color(
                        0xFF272727,
                      ),
                    )),

                // other pages
                Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: ListTile(
                    leading: Icon(Icons.home, color: Color(0xFF272727)),
                    title: Text('Home',
                        style: TextStyle(color: Color(0xFF272727))),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: ListTile(
                    leading: Icon(Icons.info, color: Color(0xFF272727)),
                    title: Text('About',
                        style: TextStyle(color: Color(0xFF272727))),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 25, bottom: 25),
              child: ListTile(
                leading: Icon(Icons.logout, color: Color(0xFF272727)),
                title:
                    Text('Logout', style: TextStyle(color: Color(0xFF272727))),
              ),
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }
}
