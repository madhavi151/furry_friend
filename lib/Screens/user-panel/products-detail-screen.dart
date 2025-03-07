// ignore_for_file: file_names, must_be_immutable, avoid_unnecessary_containers, prefer_interpolation_to_compose_strings

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furry_friend/Models/product-model.dart';
import 'package:furry_friend/Utils/app-constant.dart';
import 'package:get/get.dart';

class ProductsDetailScreen extends StatefulWidget {
  ProductModel productModel;

  ProductsDetailScreen({super.key, required this.productModel});

  @override
  State<ProductsDetailScreen> createState() => _ProductsDetailScreenState();
}

class _ProductsDetailScreenState extends State<ProductsDetailScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: Text("Product Details"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Get.height / 60),
            
            // Carousel Slider (Remains unchanged as per request)
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
                      _buildPriceRow("Price:", widget.productModel.fullPrice),
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
                  _buildActionButton("Add to Cart", Icons.shopping_cart, AppConstant.appSecondaryColor),
                  _buildActionButton("WhatsApp", Icons.chat_sharp, Colors.green),
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
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget for action buttons
  Widget _buildActionButton(String text, IconData icon, Color color) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: ElevatedButton.icon(
          onPressed: () {},
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
}
