// ignore_for_file: avoid_unnecessary_containers, file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:furry_friend/Controllers/sign-in-controller.dart';
import 'package:furry_friend/Screens/auth-ui/forget-password-screen.dart';
import 'package:furry_friend/Screens/user-panel/main-screen.dart';
import 'package:furry_friend/Utils/app-constant.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'sign-up-screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  final SignInController signInController = Get.put(SignInController());
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPassword = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible){
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppConstant.appSecondaryColor,
          title: Text("Sign In"),
          ),

          body: Container(
            child: Column(
              children:[
                isKeyboardVisible? Text("Welcome to Furry Friend App"):
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


////PASSWORD KE BOX KA CODE 
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
    child: Obx(() 
    => TextFormField(
      controller: userPassword,
      obscureText: signInController.isPasswordVisible.value,
      cursorColor: Color(0xFFC78265),  // Matching cursor color
      keyboardType: TextInputType.visiblePassword,
      style: TextStyle(color: Color(0xFF2C3E5F),
       fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        hintText: "Password",
        hintStyle: TextStyle(color: Colors.grey[600]),
        prefixIcon: Icon(Icons.lock, color: Color(0xFFC78265)),
        suffixIcon: GestureDetector(
                            onTap: () {
                              signInController.isPasswordVisible.toggle();
                            },
                            child: signInController.isPasswordVisible.value
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility),
                          ),
        contentPadding: EdgeInsets.symmetric(vertical: 15.0),
        border: InputBorder.none,
      ),
    ),
    )
  ),
),

/////forget password ka text likhne ke liye 
             Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => ForgetPasswordScreen());
                  },
                  child: Text(
                    "Forget Password?",
                    style: TextStyle(
                        color: AppConstant.appSecondaryColor,
                        fontWeight: FontWeight.bold),
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
                      "SIGN IN",
                      style: TextStyle( color: AppConstant.appTextColor,
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
            letterSpacing: 1.2,
),
                    ),
                    onPressed: () async {
                      String email = userEmail.text.trim();
                      String password = userPassword.text.trim();

                      if (email.isEmpty || password.isEmpty) {
                        Get.snackbar(
                          "Error",
                          "Please enter all details",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: AppConstant.appSecondaryColor,
                          colorText: AppConstant.appTextColor,
                        );
                      } else {
                        UserCredential? userCredential = await signInController
                            .signInMethod(email, password);

                        if (userCredential != null) {
                          if (userCredential.user!.emailVerified) {
                          Get.snackbar("Success","Login Successfull",snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppConstant.appSecondaryColor,
        colorText: AppConstant.appTextColor);
        Get.offAll(() => MainScreen());

                          } else {
                            Get.snackbar(
                              "Error",
                              "Please verify your email before login",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: AppConstant.appSecondaryColor,
                              colorText: AppConstant.appTextColor,
                            );
                          }
                        } else {
                          Get.snackbar(
                            "Error",
                            "Please try again",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: AppConstant.appSecondaryColor,
                            colorText: AppConstant.appTextColor,
                          );
                        }
                      }
                    },
                  ),
                ),
              ),
///SIGN IN AUR USKE NICHE LIKHA HUA KE BECH KE SPACING KE LIYE

              SizedBox(
                height: Get.height / 20,
              ),

/////SIGN IN BUTTON KE NICHE VLA LIKHA HUA USKA CODE 

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(color: AppConstant.appTextColor2,
                    fontSize: 20,
),
                  ),
                  GestureDetector(
                    onTap: () => Get.offAll(() => SignUpScreen()),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                            color: AppConstant.appSecondaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                decoration: TextDecoration.underline,
),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}