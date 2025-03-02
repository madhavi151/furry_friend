// ignore: file_names

// ignore_for_file: avoid_unnecessary_containers, file_names, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:furry_friend/Screens/user-panel/all-categories-screen.dart';
import 'package:furry_friend/Screens/user-panel/all-flash-sale-products.dart';
import 'package:furry_friend/Screens/user-panel/all-products-screen.dart';
import 'package:furry_friend/Utils/app-constant.dart';
import 'package:furry_friend/Widgets/all-products-widgets.dart';
import 'package:furry_friend/Widgets/banner-widget.dart';
import 'package:furry_friend/Widgets/category-widget.dart';
import 'package:furry_friend/Widgets/custom-drawer-widget.dart';
import 'package:furry_friend/Widgets/flash-sale-widget.dart';
import 'package:furry_friend/Widgets/heading-widget.dart';
import 'package:get/get.dart';


class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppConstant.appTextColor),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppConstant.appSecondaryColor,
          statusBarBrightness: Brightness.light),
          backgroundColor: AppConstant.appMainColor,
          title: Text(
            AppConstant.appMainName,
            style: TextStyle(color: AppConstant.appTextColor),
          ),
          centerTitle: true,
          
      ),
      drawer: DrawerWidget( ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: Get.height/ 90.0,
              ),
              //banners
              BannerWidget(),
              //heading
              HeadingWidget(
                headingTitle: "Categories",
                headingSubTitle: "According to your pets",
                onTap: () => Get.to (() => AllCategoriesScreen()),
                buttonText: "See More -->",   
              ),

              //categories
              CategoriesWidget(),


              //heading
              
              HeadingWidget(
                headingTitle: "Flash For Sale",
                headingSubTitle: "According to your pets",
               onTap: () => Get.to (() => AllFlashSaleProductScreen()),
                buttonText: "See More -->",   
              ),

              //flashsale

          FlashSaleWidget(),

               //heading
              
              HeadingWidget(
                headingTitle: "Products ",
                headingSubTitle: "According to your pets",
                onTap: () => Get.to (() => AllProductsScreen()),
                buttonText: "See More -->",   
              ),

              AllProductsWidget(),

             


            ],
          ),
        ),
      ),
    );
  }
}

        