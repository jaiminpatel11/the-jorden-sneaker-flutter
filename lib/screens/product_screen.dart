import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:the_jorden_sneakers/models/product.dart';
import 'package:the_jorden_sneakers/models/products.dart';
import 'package:the_jorden_sneakers/screens/product_details_screen.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  TextEditingController _searchController = TextEditingController();
  List<Product> _filteredProducts = [];

  @override
  void initState() {
    _filteredProducts = products;
    super.initState();
  }


  //function that filter the products by its name
  void _filterProducts(String query) {
    List<Product> filteredList = products.where((product) {
      return product.name.toLowerCase().contains(query.toLowerCase());
    }).toList();
    setState(() {
      _filteredProducts = filteredList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: 15, right: 15, left: 15, bottom: 10),
            decoration: BoxDecoration(
              color: Color(0xFF674AEF),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop(); // Navigate back
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    Icon(
                      Icons.notifications_active,
                      color: Colors.white,
                      size: 30,
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 3, bottom: 15),
                  child: Column(
                    children: [
                      Center(
                        child: Lottie.asset(
                          "assets/Lottie/hello.json",
                          height: 150,
                          width: 150,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: TextField(
                          controller: _searchController,
                          onChanged: (value) {
                            _filterProducts(value);
                          },
                          decoration: InputDecoration(
                            hintText: 'Search',
                            hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            prefixIcon: Icon(Icons.search, color: Colors.black.withOpacity(0.5)),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          GridView.builder(
            padding: EdgeInsets.all(10),
            //The itemCount is set to the length of _filteredProducts, so it only displays the filtered products.
            itemCount: _filteredProducts.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: (MediaQuery.of(context).size.height - 50 - 25) / (4 * 270),
            ),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: (){

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailsScreen(product: _filteredProducts[index],
                        imageUrl: _filteredProducts[index].imageUrl,
                        name : _filteredProducts[index].name,
                        description: _filteredProducts[index].description,
                        price:_filteredProducts[index].price
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                  decoration: BoxDecoration(
                    color: Color(0XFFF5F5FF),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Center(
                          child: Image.asset(
                            _filteredProducts[index].imageUrl,
                            height: 200,
                            width: 200,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            _filteredProducts[index].name,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: Colors.black.withOpacity(0.6)
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1, // Adjust maxLines as needed
                          ),
                        ),
                        SizedBox(height: 4,),
                        Flexible(
                          child: Text(
                            '\$${_filteredProducts[index].price.toString()}',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.black.withOpacity(0.5)
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1, // Adjust maxLines as needed
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
