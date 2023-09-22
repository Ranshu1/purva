import 'package:flutter/material.dart';

class Whishlist extends StatelessWidget {
  const Whishlist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "WhishList Screen",
        style: TextStyle(
          color: Colors.red,
          fontSize: 45,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}