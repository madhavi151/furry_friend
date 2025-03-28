// ignore_for_file: avoid_unnecessary_containers, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:furry_friend/Models/order-model.dart';
import 'package:furry_friend/Models/review-model.dart';
import 'package:furry_friend/Utils/app-constant.dart';

class AddReviewScreen extends StatefulWidget {
  final OrderModel orderModel;
  const AddReviewScreen({super.key, required this.orderModel});

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  TextEditingController feedbackController = TextEditingController();
  double productRating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: const Text("Add Review", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Rate & Review",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.grey[800]),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      widget.orderModel.productImages[0],
                      height: 60,
                      width: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget.orderModel.productName,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              const Text(
                "Your Rating:",
               // style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.grey[700]),
              ),
              const SizedBox(height: 10),
              Center(
                child: RatingBar.builder(
                  initialRating: productRating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star_rounded,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    productRating = rating;
                    setState(() {});
                  },
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "Your Feedback:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: feedbackController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: "Share your experience with the product...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.grey[400]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: AppConstant.appMainColor),
                  ),
                  contentPadding: const EdgeInsets.all(15),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    EasyLoading.show(status: "Submitting Review...");
                    String feedback = feedbackController.text.trim();
                    User? user = FirebaseAuth.instance.currentUser;

                    if (productRating == 0) {
                      EasyLoading.showError("Please add a rating.");
                      return;
                    }

                    ReviewModel reviewModel = ReviewModel(
                      customerName: widget.orderModel.customerName,
                      customerPhone: widget.orderModel.customerPhone,
                      customerDeviceToken: widget.orderModel.customerDeviceToken,
                      customerId: widget.orderModel.customerId,
                      feedback: feedback,
                      rating: productRating.toString(),
                      createdAt: DateTime.now(),
                    );

                    try {
                      await FirebaseFirestore.instance
                          .collection('products')
                          .doc(widget.orderModel.productId)
                          .collection('review')
                          .doc(user!.uid)
                          .set(reviewModel.toMap());
                      EasyLoading.showSuccess("Review submitted successfully!");
                      Navigator.pop(context); // Go back to the previous screen
                    } catch (e) {
                      EasyLoading.showError("Failed to submit review. Please try again.");
                      print("Error submitting review: $e");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppConstant.appMainColor,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text(
                    "Submit Review",
                    style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}