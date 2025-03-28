// ignore_for_file: file_names, must_be_immutable, avoid_unnecessary_containers, prefer_interpolation_to_compose_strings, dead_code, deprecated_member_use, unnecessary_null_comparison

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart'; // Import the rating bar package
import 'package:furry_friend/Controllers/rating-controller.dart';
import 'package:furry_friend/Models/product-model.dart';
import 'package:furry_friend/Models/review-model.dart';
import 'package:furry_friend/Screens/user-panel/cart-screen.dart';
import 'package:furry_friend/Utils/app-constant.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

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
      CalculateProductRatingController calculateProductRatingController = Get.put(
        CalculateProductRatingController(widget.productModel.productid));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: const Text("Product Details"),
        actions: [
          GestureDetector(
            onTap: () => Get.to(() => CartScreen()),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.shopping_cart_sharp,
              ),
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
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
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
            const SizedBox(height: 10),
            _buildIndicator(),

            // Product Details Card
            Padding(
              padding: const EdgeInsets.all(12.0),
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
                      _buildDetailRow(
                          "Product Name:", widget.productModel.productName,
                          isProductName: true),
                      _buildDetailRow(
                          "Category:", widget.productModel.categoryName),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            child: RatingBar.builder(
                              glow: false,
                              ignoreGestures: true,
                              initialRating: double.parse(
                                  calculateProductRatingController.averageRating
                                      .toString()),
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 20,
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 2.0),
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (value) {},
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(calculateProductRatingController.averageRating
                              .toString()),
                        ],
                      ),
                      const SizedBox(height: 8),
                      widget.productModel.isSale == true &&
                              widget.productModel.salePrice.isNotEmpty
                          ? _buildPriceRow(
                              "Sale Price:", widget.productModel.salePrice)
                          : _buildPriceRow(
                              "Full Price:", widget.productModel.fullPrice),
                      const SizedBox(height: 10),

                      // Full Description Box
                      const Text(
                        "Description:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          widget.productModel.productDescription,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Action Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildActionButton(
                      "Add to Cart", Icons.shopping_cart, AppConstant.appSecondaryColor,
                      () async {
                    if (user != null) {
                      await checkProductExistence(uId: user!.uid);
                    } else {
                      // Handle the case where the user is not logged in (e.g., show a login prompt)
                      print("User not logged in");
                    }
                  }),
                  _buildActionButton("WhatsApp", Icons.chat_sharp, Colors.green, () {
                    sendMessageOnWhatsApp(productModel: widget.productModel);
                    // Implement WhatsApp functionality here
                    print("WhatsApp button pressed");
                  }),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Reviews Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                "Customer Reviews",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance
                  .collection('products')
                  .doc(widget.productModel.productid)
                  .collection('review')
                  .get(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text("Error loading reviews"),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                    height: Get.height / 5,
                    child: const Center(
                      child: CupertinoActivityIndicator(),
                    ),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text("No reviews found for this product yet."),
                  );
                }

                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var data = snapshot.data!.docs[index];
                    ReviewModel reviewModel = ReviewModel(
                      customerName: data['customerName'],
                      customerPhone: data['customerPhone'],
                      customerDeviceToken: data['customerDeviceToken'],
                      customerId: data['customerId'],
                      feedback: data['feedback'],
                      rating: data['rating'],
                      createdAt: data['createdAt'],
                    );
                    return Card(
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text(
                            reviewModel.customerName != null &&
                                    reviewModel.customerName.isNotEmpty
                                ? reviewModel.customerName[0].toUpperCase()
                                : "",
                          ),
                        ),
                        title: Text(reviewModel.customerName),
                        subtitle: Text(reviewModel.feedback),
                        trailing: Text(reviewModel.rating),
                      ),
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 20),
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
        width: Get.width - 20, // Adjusted width for padding
        placeholder: (context, url) =>
            const Center(child: CupertinoActivityIndicator()),
        errorWidget: (context, url, error) => const Icon(Icons.error),
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
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
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
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 16),
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
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
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
  Widget _buildActionButton(
      String text, IconData icon, Color color, VoidCallback onPressed) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: ElevatedButton.icon(
          onPressed: onPressed,
          icon: Icon(icon, color: Colors.white),
          label: Text(text, style: const TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }

  static Future<void> sendMessageOnWhatsApp({
    required ProductModel productModel,
  }) async {
    final number = "+917208443670";
    final message = "Hello Madhavi,\n\nI wanted to know more about this product:\n\n📌 *Product Name:* ${productModel.productName}\n🆔 *Product ID:* ${productModel.productid}\n💰 *Product Price:* ${productModel.fullPrice}\n💰\n\nCould you please share more details? Looking forward to your response!";

    final url = 'https://wa.me/$number?text=${Uri.encodeComponent(message)}';

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
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