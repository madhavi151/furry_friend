// ignore_for_file: file_names, must_be_immutable, avoid_unnecessary_containers, prefer_interpolation_to_compose_strings, dead_code

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furry_friend/Models/product-model.dart';
import 'package:furry_friend/Screens/user-panel/cart-screen.dart';
import 'package:furry_friend/Utils/app-constant.dart';
import 'package:get/get.dart';

import '../../Models/cart-model.dart';

class ProductsDetailScreen extends StatefulWidget {
  ProductModel productModel;

  ProductsDetailScreen({super.key, required this.productModel});

  @override
  State<ProductsDetailScreen> createState() => _ProductsDetailScreenState();
}

class _ProductsDetailScreenState extends State<ProductsDetailScreen> {
  int _currentIndex = 0;
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: Text("Product Details"),
        actions: [
           GestureDetector(
              onTap:  () => Get.to (() => CartScreen()),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.shopping_cart_sharp,),
              ),
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Get.height / 60),

            // Carousel Slider
            CarouselSlider(
              items: widget.productModel.productImages
                  .map((imageUrl) => _buildProductImage(imageUrl))
                  .toList(),
              options: CarouselOptions(
                scrollDirection: Axis.horizontal,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.easeInOut,
                aspectRatio: 2.3,
                viewportFraction: 0.9,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
            ),
            SizedBox(height: 10),
            _buildIndicator(),

            // Product Details Card
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Card(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailRow("Product Name:", widget.productModel.productName, isProductName: true),
                      _buildDetailRow("Category:", widget.productModel.categoryName),

                      widget.productModel.isSale == true && widget.productModel.salePrice.isNotEmpty
                          ? _buildPriceRow("Sale Price:", widget.productModel.salePrice)
                          : _buildPriceRow("Full Price:", widget.productModel.fullPrice),

                      SizedBox(height: 10),

                      // Full Description Box
                      Text(
                        "Description:",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(height: 5),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          widget.productModel.productDescription,
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Action Buttons
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildActionButton("Add to Cart", Icons.shopping_cart, AppConstant.appSecondaryColor, () async {
                    if (user != null) {
                      await checkProductExistence(uId: user!.uid);
                    } else {
                      // Handle the case where the user is not logged in (e.g., show a login prompt)
                      print("User not logged in");
                    }
                  }),
                  _buildActionButton("WhatsApp", Icons.chat_sharp, Colors.green, () {
                    // Implement WhatsApp functionality here
                    print("WhatsApp button pressed");
                  }),
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Builds the image slider items
  Widget _buildProductImage(String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        width: Get.width - 10,
        placeholder: (context, url) => Center(child: CupertinoActivityIndicator()),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }

  // Indicator for carousel slider
  Widget _buildIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widget.productModel.productImages.asMap().entries.map((entry) {
        return Container(
          width: 8.0,
          height: 8.0,
          margin: EdgeInsets.symmetric(horizontal: 4.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentIndex == entry.key ? Colors.blue : Colors.grey,
          ),
        );
      }).toList(),
    );
  }

  // Helper widget for product details row
  Widget _buildDetailRow(String title, String value, {bool isProductName = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(fontSize: 16),
            softWrap: true,
            overflow: TextOverflow.visible,
          ),
        ],
      ),
    );
  }

  // New helper widget for styling price
  Widget _buildPriceRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Text(
            "₹$value",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: title == "Sale Price:" ? Colors.red : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget for action buttons
  Widget _buildActionButton(String text, IconData icon, Color color, VoidCallback onPressed) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: ElevatedButton.icon(
          onPressed: onPressed,
          icon: Icon(icon, color: Colors.white),
          label: Text(text, style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding: EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }

  // checkl prooduct exist or not
 Future<void> checkProductExistence({
  required String uId,
  int quantityIncrement = 1,
}) async {
  final DocumentReference documentReference = FirebaseFirestore.instance
      .collection('cart')
      .doc(uId)
      .collection('cartOrders')
      .doc(widget.productModel.productid.toString());

  DocumentSnapshot snapshot = await documentReference.get();
if (snapshot.exists) {
      int currentQuantity = snapshot['productQuantity'];
      int updatedQuantity = currentQuantity + quantityIncrement;
      double totalPrice = double.parse(widget.productModel.isSale
              ? widget.productModel.salePrice
              : widget.productModel.fullPrice) *
          updatedQuantity;

      await documentReference.update({
        'productQuantity': updatedQuantity,
        'productTotalPrice': totalPrice
      });

      print("product exists");
  } else {
    await FirebaseFirestore.instance.collection('cart').doc(uId).set(
      {
        'uId': uId,
        'createdAt': DateTime.now(),
      },
      SetOptions(merge: true), // Prevents overwriting existing data
    );

    CartModel cartModel = CartModel(
      productId: widget.productModel.productid,
      categoryId: widget.productModel.categoryId,
      productName: widget.productModel.productName,
      categoryName: widget.productModel.categoryName,
      salePrice: widget.productModel.salePrice,
      fullPrice: widget.productModel.fullPrice,
      productImages: widget.productModel.productImages,
      deliveryTime: widget.productModel.deliveryTime,
      isSale: widget.productModel.isSale,
      productDescription: widget.productModel.productDescription,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      productQuantity: 1,
        productTotalPrice: double.parse(widget.productModel.isSale
            ? widget.productModel.salePrice
            : widget.productModel.fullPrice),
      );
    await documentReference.set(cartModel.toMap());
    print("Product added to cart.");
  }
}
}