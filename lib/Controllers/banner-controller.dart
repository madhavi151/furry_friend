// ignore_for_file: camel_case_types, file_names, unnecessary_overrides, unused_local_variable, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class BannerController extends GetxController {
  RxList<String> bannerUrls = RxList<String>([]);

  @override
  void onInit() {
    super.onInit();
    fetchBannersUrls();
  }

  // Fetch banners
  Future<void> fetchBannersUrls() async {
    try {
      QuerySnapshot bannersSnapshot =
          await FirebaseFirestore.instance.collection('banners').get();

      if (bannersSnapshot.docs.isNotEmpty) {
        bannerUrls.assignAll(
          bannersSnapshot.docs.map((doc) {
            if (doc.data() is Map<String, dynamic> && doc['imageurl'] != null) {
              return doc['imageurl'] as String;
            } else {
              print("Invalid document format: ${doc.data()}");
              return ''; // Return empty string to avoid crashes
            }
          }).where((url) => url.isNotEmpty).toList(),
        );

        print("Fetched ${bannerUrls.length} banners.");
      } else {
        print("No banners found in Firestore.");
      }
    } catch (e) {
      print("Error fetching banners: $e");
    }
  }
}
