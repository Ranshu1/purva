import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:purva/Product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, String>> item = [
    {'imageUrl': "assets/images/1.jpeg", 'text': "Power Tools Kit"},
    {'imageUrl': "assets/images/2.jpeg", 'text': "Timing pully"},
    {'imageUrl': "assets/images/3.jpeg", 'text': "Nut Bolt"},
    {'imageUrl': "assets/images/4.jpeg", 'text': "Timing bel"}
  ];

  final List<Product> products = [
    Product(
        imageUrl: 'assets/images/6.jpeg',
        actualPrice: "950",
        discountPrice: "840",
        name: "Drill Machine",
        percentage: "12"),
    Product(
        imageUrl: 'assets/images/5.jpeg',
        actualPrice: "1550",
        discountPrice: "1470",
        name: "Drill Machine Tool Kit",
        percentage: "5"),
    Product(
        imageUrl: 'assets/images/7.jpeg',
        actualPrice: "300",
        discountPrice: "380",
        name: "Plas",
        percentage: "8"),
    // Add more products as needed.
  ];

  @override
  Widget build(BuildContext context) {
    var hei = MediaQuery.of(context).size.height;
    var wid = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: const[
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.search,
              color: Colors.red,
            ),
          )
        ],
        title: const Text(
          "purva",
          style: TextStyle(
              fontSize: 18, color: Colors.red, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:const  EdgeInsets.only(left: 15, right: 15),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: SizedBox(
                  height: 160,
                  width: double.infinity,
                  child: AnotherCarousel(
                    images: const [
                      NetworkImage(
                          "https://img.freepik.com/premium-photo/male-hand-touching-service-concept_220873-7591.jpg"),
                      NetworkImage(
                          "https://media.istockphoto.com/id/857357236/photo/the-hard-work-that-goes-into-running-a-cafe.jpg?s=612x612&w=0&k=20&c=gqsTgjboYHeliG006ywyBvAwhs2Sb2oBWrVIOFGCkOE="),
                      NetworkImage(
                          "https://media.istockphoto.com/id/840678292/photo/group-of-business-people-holding-a-jigsaw-puzzle-pieces.jpg?s=612x612&w=0&k=20&c=q-C1uSzmu6agrAWNxsxEjM6o4mZuR4kwZ5QQ0KlWnt8=")
                    ],
                    dotSize: 0,
                    indicatorBgPadding: 0,
                  ),
                ),
              ),
            ),
            const Padding(
              padding: const EdgeInsets.only(left: 15, top: 15),
              child: Text(
                "Categories",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ),
           const  SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              child: Container(
                padding:const  EdgeInsets.only(left: 10, right: 10),
                height: hei * 0.25,
                child: ListView.builder(
                  itemExtent: 100,
                  scrollDirection: Axis.horizontal,
                  itemCount: item
                      .length, // Replace with the length of your image list.
                  itemBuilder: (BuildContext context, int index) {
                    // Return a widget for each item in the list.
                    return buildImageWithText(item[index], context);
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius:const  BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2), // Shadow color
                      spreadRadius: 5, // Spread radius
                      blurRadius: 15, // Blur radius
                      offset: const Offset(0, 3),
                    )
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  const Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text(
                      "Top Picks",
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: hei * 0.65,
                    child: GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: wid * 0.75 / (hei * 0.6),
                      ),
                      itemCount: products.length,
                      itemBuilder: (BuildContext context, int index) {
                        final product = products[index];
                        return buildProductItem(product, context);
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget buildProductItem(Product product, BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius:const  BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0),
            ),
            child: Image.asset(
              product.imageUrl,
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.2,
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              product.name,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 8),
            child: SizedBox(
              width: 150,
              child: Wrap(
                spacing: 4,
                children: [
                  Text(
                    '₹${product.actualPrice} ',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      decoration: TextDecoration.lineThrough,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    '₹${product.discountPrice}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Text(
                      '${product.percentage}% off',
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildImageWithText(
      Map<String, String> imageInfo, BuildContext context) {
    return Column(
      children: [
        Image.asset(
          imageInfo['imageUrl']!,
          width: 150,
          height: MediaQuery.of(context).size.height * 0.2,
        ),
        Text(imageInfo['text']!)
      ],
    );
  }
}
