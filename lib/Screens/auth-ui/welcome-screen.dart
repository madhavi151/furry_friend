// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../Utils/app-constant.dart';


class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
      backgroundColor: AppConstant.appMainColor,
      title: Text(
        "Welcome to Furry Friend",
       style: TextStyle(color: AppConstant.appTextColor),
       ),
    ),
    // ignore: avoid_unnecessary_containers
    body: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            child: Lottie.asset('Assets/images/animation.json') 
          ),
         // ignore: avoid_unnecessary_containers
         Container(
          margin: EdgeInsets.only(top: 20.0),
          child: Text(
            "Happy Shopping",
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
            SizedBox(
              height: Get.height/30 ,
              ),
            Material(
              child: Container(
                width: Get.width/1.2,
                height: Get.height/12,
                decoration:BoxDecoration(
                  color: AppConstant.appSecondaryColor,
                  borderRadius: BorderRadius.circular(20.0),

                ),
              child: TextButton.icon(
                icon: Image.asset(
                  "Assets/images/google-icon.png",
                  width: Get.width/12,
                height: Get.height/12,
                 ),
                label: Text(
                  "Sign in with Google",
                  style: TextStyle(color: AppConstant.appTextColor),
                  ),
                onPressed: () {},
                ),
            ),
            ),
            SizedBox(
              height: Get.height/50 ,
              ),
            Material(
              child: Container(
                width: Get.width/1.2,
                height: Get.height/12,
                decoration:BoxDecoration(
                  color: AppConstant.appSecondaryColor,
                  borderRadius: BorderRadius.circular(20.0),

                ),
              child: TextButton.icon(
                icon: Image.asset(
                  "Assets/images/gmail-icon.png",
                  width: Get.width/12,
                height: Get.height/12,
                 ),
                label: Text(
                  "Sign in with Gmail",
                  style: TextStyle(color: AppConstant.appTextColor),
                  ),
                onPressed: () {},
                ),
            ),
            )   
        ],
      ),
      ),
    );
  }
}