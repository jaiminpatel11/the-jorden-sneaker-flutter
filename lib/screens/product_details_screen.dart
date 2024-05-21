import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_jorden_sneakers/models/CartModel.dart';
import 'package:the_jorden_sneakers/models/product.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:the_jorden_sneakers/screens/checkout_screen.dart';

// the constructor receives these details as named parameters (product, imageUrl, name, description, price).
class ProductDetailsScreen extends StatefulWidget {
  final Product product;
  final String imageUrl;
  final String name;
  final String description;
  final double price;

  const ProductDetailsScreen({
    Key? key,
    required this.product,
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.price,
  }) : super(key: key);

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(
            duration: Duration(milliseconds: 1000), vsync: this);
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Color(0xFF674AEF),
        elevation: 0,
        title: Text(
          "Product Details",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.notifications,
              size: 30,
              color: Color(0xFF674AEF),
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Opacity(
                    opacity: _scaleAnimation.value,
                    child: child,
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.all(5),
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xFFF5F3FF),
                  image: DecorationImage(
                    image: AssetImage(widget.imageUrl),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            Text(
              "${widget.name}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "\$${widget.price}",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withOpacity(0.8),
                  fontSize:18,
              ),
            ),

            SizedBox(height: 10),
            Text(
              "${widget.description}",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black.withOpacity(0.9)

              ),
            ),
            SizedBox(height: 30),
            Center(
              child: Material(
                color: Color(0xFF674AEF),
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  onTap: () {
                    Provider.of<CartModel>(context, listen: false).addToCart(widget.product);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          backgroundColor: Colors.green,
                          content: Center(
                            child: Text('Item added to the cart',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                            ),
                            ),
                          ),
                        duration: Duration(seconds: 2),
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.all(40),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 80,
                    ),
                    child: Text(
                      "Add To Cart",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5
                      ),
                    ),
                  ),

                ),

              ),
            ),
            SizedBox(height: 30),
            Center(
              child: Material(
                color: Color(0xFF674AEF),
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CheckoutScreen(), // Replace CheckoutScreen with your actual checkout screen
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 80,
                    ),
                    child: Text(
                      "Checkout",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.5
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