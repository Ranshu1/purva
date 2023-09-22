import 'package:flutter/material.dart';
import 'package:purva/home_screen.dart';
import 'package:purva/profile.dart';
import 'package:purva/wishlist.dart';

import 'cart.dart';
import 'order.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  static const IconData shopping_cart =
      IconData(0xe59c, fontFamily: 'MaterialIcons');
  int pageIndex = 0;

  final pages = [
    HomeScreen(),
    const Whishlist(),
    const Cart(),
    const Order(),
    Profile(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = HomeScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        child: const Icon(shopping_cart),
        onPressed: () {
          setState(() {
            currentScreen = Cart();
            pageIndex = 2;
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 5,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = HomeScreen();
                        pageIndex = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home_outlined,
                          color: pageIndex == 0 ? Colors.red : Colors.grey,
                        ),
                        Text(
                          'Home',
                          style: TextStyle(
                              color: pageIndex == 0 ? Colors.red : Colors.grey),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = Whishlist();
                        pageIndex = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.favorite_outline,
                          color: pageIndex == 1 ? Colors.red : Colors.grey,
                        ),
                        Text(
                          'Whishlist',
                          style: TextStyle(
                              color: pageIndex == 1 ? Colors.red : Colors.grey),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = Order();
                        pageIndex = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.store,
                          color: pageIndex == 3 ? Colors.red : Colors.grey,
                        ),
                        Text(
                          'Order',
                          style: TextStyle(
                              color: pageIndex == 3 ? Colors.red : Colors.grey),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = Profile();
                        pageIndex = 4;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person_2_outlined,
                          color: pageIndex == 4 ? Colors.red : Colors.grey,
                        ),
                        Text(
                          'Profile',
                          style: TextStyle(
                              color: pageIndex == 4 ? Colors.red : Colors.grey),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
