import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  // 🔰 PostModel-based dummy list
  final List<PostModel> dummyPosts = [
    PostModel(
      id: '1',
      departureAirport: 'JFK',
      arrivalAirport: 'LAX',
      airline: 'Emirates',
      travelClass: 'Economy',
      message: 'Flying from JFK to LAX on Emirates Economy.',
      travelDate: DateTime.now(),
      rating: 4.0,
      imageUrl: [
        'https://via.placeholder.com/150',
        'https://via.placeholder.com/150',
      ],
    ),
    PostModel(
      id: '2',
      departureAirport: 'LAX',
      arrivalAirport: 'DXB',
      airline: 'Delta',
      travelClass: 'Business',
      message: 'Flying from LAX to DXB on Delta Business.',
      travelDate: DateTime.now(),
      rating: 4.0,
      imageUrl: [
        'https://via.placeholder.com/150',
        'https://via.placeholder.com/150',
      ],
    ),
  ];

  final List<Map<String, dynamic>> allFlightPosts = [
    {
      "id": "POST12345",
      "passenger": "Rifat Hossain",
      "departureAirport": {
        "cityCountry": "Dhaka, Bangladesh",
        "airportName": "Hazrat Shahjalal International Airport",
        "iata": "DAC",
      },
      "arrivalAirport": {
        "cityCountry": "Chittagong, Bangladesh",
        "airportName": "Shah Amanat International Airport",
        "iata": "CGP",
      },
      "airline": {
        "name": "Biman Bangladesh Airlines",
        "iata": "BG",
        "country": "Bangladesh",
      },
      "travelClass": "Business",
      "seat": "3A",
      "travelDate": "2025-07-21T09:30:00.000Z",
      "rating": 4.7,
      "message": "Had a smooth business class flight from Dhaka to Chittagong!",
      "imageUrl": [
        "https://via.placeholder.com/600x400?text=Cabin+View",
        "https://via.placeholder.com/600x400?text=Meal+Service",
        "https://via.placeholder.com/600x400?text=Window+View",
      ],
      "likes": ["uid_123", "uid_456"],
      "comments": ["Excellent trip!", "Nice airline service."],
      "replays": [
        {
          "uid": "uid_123",
          "comment": "Thanks for sharing!",
          "timestamp": "2025-07-22T12:00:00Z",
        },
      ],
    },
    {
      "id": "POST12346",
      "passenger": "Ayesha Siddique",
      "departureAirport": {
        "cityCountry": "Sylhet, Bangladesh",
        "airportName": "Osmani International Airport",
        "iata": "ZYL",
      },
      "arrivalAirport": {
        "cityCountry": "Cox's Bazar, Bangladesh",
        "airportName": "Cox's Bazar Airport",
        "iata": "CXB",
      },
      "airline": {
        "name": "Air Bangladesh",
        "iata": "B9",
        "country": "Bangladesh",
      },
      "travelClass": "Economy",
      "seat": "10C",
      "travelDate": "2025-08-10T16:00:00.000Z",
      "rating": 4.2,
      "message": "Vacation trip to Cox's Bazar. Nice experience!",
      "imageUrl": [
        "https://via.placeholder.com/600x400?text=Boarding",
        "https://via.placeholder.com/600x400?text=Flight+Interior",
        "https://via.placeholder.com/600x400?text=Beach+View",
      ],
      "likes": ["uid_789"],
      "comments": ["Looks beautiful!", "Enjoy your trip!"],
      "replays": [],
    },
    {
      "id": "POST12347",
      "passenger": "Tanvir Rahman",
      "departureAirport": {
        "cityCountry": "Jessore, Bangladesh",
        "airportName": "Jessore Airport",
        "iata": "JSR",
      },
      "arrivalAirport": {
        "cityCountry": "Rajshahi, Bangladesh",
        "airportName": "Shah Mokhdum Airport",
        "iata": "RJH",
      },
      "airline": {
        "name": "United Airways",
        "iata": "4H",
        "country": "Bangladesh",
      },
      "travelClass": "First Class",
      "seat": "1A",
      "travelDate": "2025-09-01T11:45:00.000Z",
      "rating": 4.9,
      "message": "Premium service all the way from Jessore to Rajshahi!",
      "imageUrl": [
        "https://via.placeholder.com/600x400?text=First+Class+Seat",
        "https://via.placeholder.com/600x400?text=Airport+Lounge",
        "https://via.placeholder.com/600x400?text=Landing",
      ],
      "likes": ["uid_111", "uid_222", "uid_333"],
      "comments": ["Luxury!", "So clean!", "Top notch"],
      "replays": [
        {
          "uid": "uid_222",
          "comment": "Agreed!",
          "timestamp": "2025-09-02T08:15:00Z",
        },
      ],
    },
  ];

  // ✅ DROPDOWN OPTIONS (from dummyPosts)
  List<String> get dropdownDepartureAirportsFromModel =>
      dummyPosts.map((e) => e.departureAirport).toSet().toList();

  List<String> get dropdownArrivalAirportsFromModel =>
      dummyPosts.map((e) => e.arrivalAirport).toSet().toList();

  List<String> get dropdownAirlinesFromModel =>
      dummyPosts.map((e) => e.airline).toSet().toList();

  List<String> get dropdownClassesFromModel =>
      dummyPosts.map((e) => e.travelClass).toSet().toList();

  // ✅ DROPDOWN OPTIONS (from flightPost-style map)
  List<String> get dropdownDepartureAirportsFromMap =>
      allFlightPosts
          .map((e) {
            final dep = e['departureAirport'];
            return "${dep['cityCountry']} (${dep['iata']})";
          })
          .toSet()
          .toList();

  List<String> get dropdownArrivalAirportsFromMap =>
      allFlightPosts
          .map((e) {
            final arr = e['arrivalAirport'];
            return "${arr['cityCountry']} (${arr['iata']})";
          })
          .toSet()
          .toList();

  List<String> get dropdownAirlinesFromMap =>
      allFlightPosts
          .map((e) {
            final airline = e['airline'];
            return "${airline['name']} (${airline['iata']})";
          })
          .toSet()
          .toList();

  List<String> get dropdownClassesFromMap =>
      allFlightPosts.map((e) => e['travelClass'].toString()).toSet().toList();

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
      try {
        final user = FirebaseAuth.instance.currentUser;

        if (user == null) {
          Get.snackbar('Error', 'User not logged in');
          isLoading.value = false;
          return;
        }

        final postData =
            PostModel(
              id: DateTime.now().millisecondsSinceEpoch.toString(), // unique ID
              departureAirport: departure.value,
              arrivalAirport: arrival.value,
              airline: airline.value,
              travelClass: travelClass.value,
              message: messageController.text.trim(),
              travelDate: travelDate.value!,
              rating: rating.value.toDouble(),
              imageUrl: [
                'assets/images/demo_image.jpg',
                'assets/images/demo_image.jpg',
                'assets/images/demo_image.jpg',
              ],
            ).toMap();

        final userDoc = FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid);

        await userDoc.update({
          'posts': FieldValue.arrayUnion([postData]),
        });

        postModel.value = PostModel.fromMap(postData);

        Get.snackbar(
          'Success',
          'Post added to your profile',
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
