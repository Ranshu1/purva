import 'package:flutter/material.dart';

class Order extends StatelessWidget {
  const Order({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "OrderScreen",
        style: TextStyle(
          color: Colors.red,
          fontSize: 45,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
