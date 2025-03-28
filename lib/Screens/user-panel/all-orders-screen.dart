// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furry_friend/Models/order-model.dart';
import 'package:furry_friend/Screens/user-panel/add-review-screen.dart';
import 'package:furry_friend/Utils/app-constant.dart';
import 'package:furry_friend/controllers/cart-price-controller.dart';
import 'package:get/get.dart';



class AllOrderScreen extends StatefulWidget {
  const AllOrderScreen({super.key});

  @override
  State<AllOrderScreen> createState() => _AllOrderScreenState();
}

class _AllOrderScreenState extends State<AllOrderScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  final ProductPriceController priceController = Get.put(ProductPriceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: const Text('Your All Orders',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: user == null
          ? const Center(child: Text("Please log in to view your orders."))
          : StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('orders')
                  .doc(user!.uid)
                  .collection('confirmOrders')
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text("Error loading orders."));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CupertinoActivityIndicator());
                }
                if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text("You haven't placed any orders yet!"));
                }

                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final productData = snapshot.data!.docs[index];
                      OrderModel orderModel = OrderModel(
                        productId: productData['productId'],
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
                        productQuantity: productData['productQuantity'],
                        productTotalPrice: double.parse(
                            productData['productTotalPrice'].toString()),
                        customerId: productData['customerId'],
                        status: productData['status'],
                        customerName: productData['customerName'],
                        customerPhone: productData['customerPhone'],
                        customerAddress: productData['customerAddress'],
                        customerDeviceToken: productData['customerDeviceToken'],
                      );
                      return _buildCartItem(orderModel);
                    },
                  ),
                );
              },
            ),
    );
  }

  Widget _buildCartItem(OrderModel orderModel) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                orderModel.productImages[0],
                height: 70,
                width: 70,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(orderModel.productName,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  Text(
                    "₹${orderModel.productTotalPrice.toStringAsFixed(2)}",
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.green),
                  ),
                  orderModel.status == false
                      ? const Text(
                          "Pending..",
                          style: TextStyle(color: Colors.orange), // Changed color for better visibility of pending status
                        )
                      : const Text(
                          "Delivered",
                          style: TextStyle(color: Colors.green), // Changed color to green for delivered status
                        ),
                ],
              ),
            ),
            orderModel.status == true
                ? ElevatedButton(
                    onPressed: () => Get.to(
                      () => AddReviewScreen(
                        orderModel: orderModel,
                      ),
                    ),
                    child: const Text("Review"),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}