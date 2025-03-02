// ignore_for_file: file_names, prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, deprecated_member_use, avoid_print

import 'package:cached_network_image/cached_network_image.dart'; // For caching network images efficiently
import 'package:cloud_firestore/cloud_firestore.dart'; // Firebase Firestore for database queries
import 'package:flutter/cupertino.dart'; // Cupertino widgets
import 'package:flutter/material.dart'; // Material Design widgets
import 'package:furry_friend/Models/product-model.dart'; // Importing product model
import 'package:furry_friend/Utils/app-constant.dart';
import 'package:get/get.dart'; // GetX for state management and utility functions

// Stateless widget to display all products
class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen ({super.key});

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppConstant.appTextColor,
        ),
        backgroundColor: AppConstant.appMainColor,
        title: Text(
          'All Products',
          style: TextStyle(color: AppConstant.appTextColor),
        ),
      ), body: FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('products') // Fetching products collection from Firestore
          .where('isSale', isEqualTo: false) // Filtering products not on sale
          .get(), // Fetching data
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) { // Checking for errors
          return Center(
            child: Text("Error"),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) { // Showing loader while fetching data
          return Container(
            height: Get.height / 5,
            child: Center(
              child: CupertinoActivityIndicator(),
            ),
          );
        }

        if (snapshot.data!.docs.isEmpty) { // Handling empty data case
          return Center(
            child: Text("No products found!"),
          );
        }

        if (snapshot.data != null) { // If data is available
          return GridView.builder(
              itemCount: snapshot.data!.docs.length, // Number of items
              shrinkWrap: true, // Wrap content
              physics: BouncingScrollPhysics(), // Smooth scrolling effect
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Two columns
                mainAxisSpacing: 3, // Vertical spacing
                crossAxisSpacing: 3, // Horizontal spacing
                childAspectRatio: 1.19, // Aspect ratio for items
              ),
               itemBuilder: (context, index) {
                final productData = snapshot.data!.docs[index]; // Getting product data
                ProductModel productModel = ProductModel(
                  productid: productData['productid'],
                  categoryId: productData['categoryId'],
                  productName: productData['productName'],
                  categoryName: productData['categoryName'],
                  salePrice: productData['salePrice'],
                  fullPrice: productData['fullPrice'],
                  productImages: productData['productImages'],
                  deliveryTime: productData['deliveryTime'],
                  isSale: productData['isSale'],
                  productDescription: productData['productDescription'],
                  createdAt: productData['createdAt'],
                  updatedAt: productData['updatedAt'],
                );
                
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                  child: GestureDetector(
                    onTap: () {}, // Placeholder for tapping functionality
                    child: Container(
                      width: Get.width / 2.2, // Setting width
                      height: Get.height / 5, // Setting height
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20), // Rounded corners
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1), // Shadow effect
                            blurRadius: 8,
                            offset: Offset(2, 4),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20), // Clip corners
                        child: Stack(
                          children: [
                            CachedNetworkImage(
                              imageUrl: productModel.productImages[0], // Product image
                              height: Get.height / 6,
                              width: Get.width / 1.3,
                              fit: BoxFit.cover, // Covering container
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error, color: Colors.redAccent), // Error handling
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.4), // Background overlay
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    productModel.productName, // Product name
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.5,
                                      shadows: [Shadow(color: Colors.black, blurRadius: 3)],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.9), // Price container
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 5,
                                      offset: Offset(2, 3),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      "Rs ${productModel.salePrice}", // Sale price
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                      ),
                                    ),
                                    SizedBox(width: 4),
                                    
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
        }
        return Container(); // Fallback empty container
      },
    ),
    );
  }
}
