import 'package:flutter/material.dart';

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Cart Screen",
        style: TextStyle(
          color: Colors.red,
          fontSize: 45,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
