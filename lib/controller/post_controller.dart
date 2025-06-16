import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_project/model/post_model.dart';

class ShareController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final messageController = TextEditingController();

  final departure = RxnString();
  final arrival = RxnString();
  final airline = RxnString();
  final travelClass = RxnString();
  final rating = 4.obs;
  final travelDate = Rx<DateTime?>(null);

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

  PostModel? get postModel =>
      departure.value != null &&
              arrival.value != null &&
              airline.value != null &&
              travelClass.value != null &&
              travelDate.value != null &&
              messageController.text.isNotEmpty
          ? PostModel(
            departureAirport: departure.value!,
            arrivalAirport: arrival.value!,
            airline: airline.value!,
            travelClass: travelClass.value!,
            message: messageController.text,
            travelDate: travelDate.value!,
            rating: rating.value.toDouble(),
            imageUrl: 'https://via.placeholder.com/150',
          )
          : null;

  void updateRating(int newRating) => rating.value = newRating;

  Future<void> pickTravelDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) travelDate.value = picked;
  }

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }
}
