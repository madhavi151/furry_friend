// ignore: file_names

// ignore_for_file: avoid_unnecessary_containers, file_names, duplicate_ignore, unused_field

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:furry_friend/Controllers/notification-controller';
import 'package:furry_friend/Screens/user-panel/all-categories-screen.dart';
import 'package:furry_friend/Screens/user-panel/all-flash-sale-products.dart';
import 'package:furry_friend/Screens/user-panel/all-products-screen.dart';
import 'package:furry_friend/Screens/user-panel/cart-screen.dart';
import 'package:furry_friend/Services/get-service-key.dart';
import 'package:furry_friend/Services/notification-service.dart';
import 'package:furry_friend/Utils/app-constant.dart';
import 'package:furry_friend/Widgets/all-products-widgets.dart';
import 'package:furry_friend/Widgets/banner-widget.dart';
import 'package:furry_friend/Widgets/category-widget.dart';
import 'package:furry_friend/Widgets/custom-drawer-widget.dart';
import 'package:furry_friend/Widgets/flash-sale-widget.dart';
import 'package:furry_friend/Widgets/heading-widget.dart';
import 'package:get/get.dart';


class MainScreen extends StatefulWidget {
  
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
    NotificationService notificationService = NotificationService();
  final GetServerKey _getServerKey = GetServerKey();

  final NotificationController notificationController =
      Get.put(NotificationController());

  @override
  void initState() {
    super.initState();
    notificationService.requestNotificationPermission();
    notificationService.getDeviceToken();
    notificationService.firebaseInit(context);
    notificationService.setupInteractMessage(context);
    // getServiceToken();
  }
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

        