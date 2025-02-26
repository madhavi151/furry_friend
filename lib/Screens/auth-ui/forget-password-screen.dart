// ignore_for_file: file_names, avoid_unnecessary_containers


import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:furry_friend/Controllers/forget-password-controller.dart';

import 'package:furry_friend/Utils/app-constant.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';


class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {

 final ForgetPasswordController forgetPasswordController =
      Get.put(ForgetPasswordController());
  TextEditingController userEmail = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible){
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppConstant.appSecondaryColor,
          title: Text(
            "Forget Password",
            style: TextStyle(color: AppConstant.appTextColor),
            ),
          ),

          body: Container(
            child: Column(
              children:[
                isKeyboardVisible? 
                Text("Welcome to Furry Friend App"):
                Column(
                  children: [
                  Lottie.asset("Assets/images/animation.json"),
                  ],
                ),
////email id ke box ke upar ke space ke liye 
                SizedBox(
                  height: Get.height/1000
                  ),

////EMAIL ID KA BOX KA CODE 
              Container(
  margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
  width: Get.width,
  decoration: BoxDecoration(
    color: Color(0xFFF5F5F5), // Light background for input field
    borderRadius: BorderRadius.circular(15.0),
    boxShadow: [
      BoxShadow(
        blurRadius: 10,
        offset: Offset(0, 5),
      ),
    ],
  ),
  child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
    child: TextFormField(
      controller: userEmail,
      cursorColor: Color(0xFFC78265),  // Matching cursor color
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(color: Color(0xFF2C3E5F), 
      fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        hintText: "Enter your Email",
        hintStyle: TextStyle(color: Colors.grey[600]),
        prefixIcon: Icon(Icons.email, color: Color(0xFFC78265)),
        contentPadding: EdgeInsets.symmetric(vertical: 15.0),
        border: InputBorder.none,
      ),
    ),
  ),
),
            
/////NICHE KE  SIGN IN BUTTON KA CODE 
SizedBox(
                height: Get.height / 20,
              ),
 Material(
                child: Container(
                   width: Get.width / 2,
    height: Get.height / 18,
    decoration: BoxDecoration(
      color: AppConstant.appSecondaryColor,
      borderRadius: BorderRadius.circular(30.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 6.0,
          spreadRadius: 2.0,
          offset: Offset(0, 10),
        ),
      ],
    ),

                  child: TextButton(
                    child: Text(
                      "Forget Password",
                      style: TextStyle( color: AppConstant.appTextColor,
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
            letterSpacing: 1.2,
),
                    ),
                    onPressed: () async {
                      String email = userEmail.text.trim();
                     
                      if (email.isEmpty) {
                        Get.snackbar(
                          "Error",
                          "Please enter all details",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: AppConstant.appSecondaryColor,
                          colorText: AppConstant.appTextColor,
                        );
                      } else {
                        String email = userEmail.text.trim();
                        forgetPasswordController.ForgetPasswordMethod(email);
                       }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}