

// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:furry_friend/Models/order-model.dart';
import 'package:furry_friend/Screens/user-panel/main-screen.dart';
import 'package:furry_friend/Services/generate-order-id-service.dart';
import 'package:furry_friend/Utils/app-constant.dart';
import 'package:get/get.dart';

void placeOrder(
  {
    required BuildContext context,
    required String customerName,
    required String customerPhone,
    required String customerAddress,
    required String customerDeviceToken

    
    }) async{
      final user = FirebaseAuth.instance.currentUser;
       EasyLoading.show(status: "Please Wait..");
  if (user != null) {
        try{
          QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('cart')
          .doc(user.uid)
          .collection('cartOrders')
          .get();

          List<QueryDocumentSnapshot> documents = querySnapshot.docs;

           for (var doc in documents) {
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>;

         String orderId = generateOrderId();

     
        OrderModel cartModel = OrderModel(
          productId: data['productId'],
          categoryId: data['categoryId'],
          productName: data['productName'],
          categoryName: data['categoryName'],
          salePrice: data['salePrice'],
          fullPrice: data['fullPrice'],
          productImages: data['productImages'],
          deliveryTime: data['deliveryTime'],
          isSale: data['isSale'],
          productDescription: data['productDescription'],
          createdAt: DateTime.now(),
          updatedAt: data['updatedAt'],
          productQuantity: data['productQuantity'],
          productTotalPrice: double.parse(data['productTotalPrice'].toString()),
          customerId: user.uid,
          status: false,
          customerName: customerName,
          customerPhone: customerPhone,
          customerAddress: customerAddress,
          customerDeviceToken: customerDeviceToken,
        );
 for (var x = 0; x < documents.length; x++) {
          await FirebaseFirestore.instance
              .collection('orders')
              .doc(user.uid)
              .set(
            {
              'uId': user.uid,
              'customerName': customerName,
              'customerPhone': customerPhone,
              'customerAddress': customerAddress,
              'customerDeviceToken': customerDeviceToken,
              'orderStatus': false,
              'createdAt': DateTime.now()
            },
          );

          // upload orders
          await FirebaseFirestore.instance
              .collection('orders')
              .doc(user.uid)
              .collection('confirmOrders')
              .doc(orderId)
              .set(cartModel.toMap());

              //delete cart products 
             await FirebaseFirestore.instance
              .collection('cart')
              .doc(user.uid)
              .collection('cartOrders')
              .doc(cartModel.productId.toString())
              .delete()
              .then((value) {
            print('Delete cart Products $cartModel.productId.toString()');
          });
        }
           }
           print("Order Confirmed");
           Get.snackbar(
            "Woohoo! Your order is in", 
            "thanks for shopping with us!",
            backgroundColor: AppConstant.appMainColor,
            colorText: Colors.white,
            duration: Duration(seconds: 5),

            );
             EasyLoading.dismiss();
      Get.offAll(() => MainScreen());
    } catch (e) {
          print("error $e");

        }
      }
    }