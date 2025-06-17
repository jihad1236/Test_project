import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:test_project/model/post_model.dart';

class ShareController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final messageController = TextEditingController();

  final departure = ''.obs;
  final arrival = ''.obs;
  final airline = ''.obs;
  final travelClass = ''.obs;
  final rating = 4.obs;
  final travelDate = Rx<DateTime?>(null);
  final RxBool isLoading = false.obs;
  final postModel = Rxn<PostModel>();

  final dummyPosts = <PostModel>[
    PostModel(
      departureAirport: 'JFK',
      arrivalAirport: 'LAX',
      airline: 'Emirates',
      travelClass: 'Economy',
      message: 'Flying from JFK to LAX on Emirates Economy.',
      travelDate: DateTime.now(),
      rating: 4.0,
      imageUrl: 'https://via.placeholder.com/150',
    ),
    PostModel(
      departureAirport: 'LAX',
      arrivalAirport: 'DXB',
      airline: 'Delta',
      travelClass: 'Business',
      message: 'Flying from LAX to DXB on Delta Business.',
      travelDate: DateTime.now(),
      rating: 4.0,
      imageUrl: 'https://via.placeholder.com/150',
    ),
  ];

  List<String> get dropdownAirports =>
      dummyPosts.map((e) => e.departureAirport).toSet().toList();
  List<String> get dropdownArrivals =>
      dummyPosts.map((e) => e.arrivalAirport).toSet().toList();
  List<String> get dropdownAirlines =>
      dummyPosts.map((e) => e.airline).toSet().toList();
  List<String> get dropdownClasses =>
      dummyPosts.map((e) => e.travelClass).toSet().toList();

  void updateRating(int stars) {
    rating.value = stars;
  }

  void pickTravelDate(BuildContext context) async {
    final picked = await showMonthPicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      travelDate.value = picked;
    }
  }

  Future<void> submitPost() async {
    isLoading.value = true;
    if (formKey.currentState!.validate() &&
        departure.value.isNotEmpty &&
        arrival.value.isNotEmpty &&
        airline.value.isNotEmpty &&
        travelClass.value.isNotEmpty &&
        travelDate.value != null &&
        rating.value > 0 &&
        messageController.text.isNotEmpty) {
      final newPost = PostModel(
        departureAirport: departure.value,
        arrivalAirport: arrival.value,
        airline: airline.value,
        travelClass: travelClass.value,
        message: messageController.text.trim(),
        travelDate: travelDate.value!,
        rating: rating.value.toDouble(),
        imageUrl:
            'assets/images/demo_image.jpg', // Replace with actual upload logic
      );

      try {
        await FirebaseFirestore.instance
            .collection('posts')
            .add(newPost.toMap());

        postModel.value = newPost;

        Get.snackbar(
          'Success',
          'Post submitted successfully',
          snackPosition: SnackPosition.BOTTOM,
        );
      } catch (e) {
        Get.snackbar(
          'Error',
          'Failed to upload post: $e',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } else {
      Get.snackbar(
        'Error',
        'Please complete all fields',
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    isLoading.value = false;
  }

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }
}
