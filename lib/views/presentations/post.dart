import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:test_project/controller/post_controller.dart';
import 'package:test_project/views/widgets/dropdown.dart';
import 'package:test_project/views/widgets/upload_box.dart';

class ShareWidget extends StatelessWidget {
  const ShareWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ShareController());
    final isSmall = MediaQuery.of(context).size.width <= 991;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: controller.formKey,
            child: Container(
              constraints: const BoxConstraints(maxWidth: 540),
              padding: EdgeInsets.symmetric(
                horizontal: isSmall ? 20 : 48,
                vertical: 48,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x14000000),
                    offset: Offset(0, 12),
                    blurRadius: 16,
                  ),
                  BoxShadow(
                    color: Color(0x14000000),
                    offset: Offset(0, 4),
                    blurRadius: 56,
                  ),
                ],
              ),
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Share',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 28),
                    upload_box(isSmall: isSmall),
                    const SizedBox(height: 28),
                    // 🔽 Departure Airport Dropdown
                    dropdown(
                      label: 'Departure Airport',
                      items: controller.dropdownDepartureAirportsFromMap,
                      onChanged:
                          (val) => controller.departure.value = val ?? '',
                    ),

                    // 🔽 Arrival Airport Dropdown
                    dropdown(
                      label: 'Arrival Airport',
                      items: controller.dropdownArrivalAirportsFromMap,
                      onChanged: (val) => controller.arrival.value = val ?? '',
                    ),

                    // 🔽 Airline Dropdown
                    dropdown(
                      label: 'Airline',
                      items: controller.dropdownAirlinesFromMap,
                      onChanged: (val) => controller.airline.value = val ?? '',
                    ),

                    // 🔽 Travel Class Dropdown
                    dropdown(
                      label: 'Travel Class',
                      items: controller.dropdownClassesFromMap,
                      onChanged:
                          (val) => controller.travelClass.value = val ?? '',
                    ),

                    const SizedBox(height: 18),
                    TextFormField(
                      controller: controller.messageController,
                      maxLines: 6,
                      decoration: InputDecoration(
                        hintText: 'Write your message',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                color: Color(0xFFE8E8EA),
                                width: 1,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 18,
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                            onPressed: () => controller.pickTravelDate(context),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  controller.travelDate.value == null
                                      ? 'Travel Date'
                                      : DateFormat(
                                        'MMMM yyyy',
                                      ).format(controller.travelDate.value!),
                                  style: const TextStyle(
                                    color: Color(0xFFA5A3A9),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Container(
                                  width: 45,
                                  height: 46,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE4E4E4),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: const Icon(
                                    Icons.calendar_today,
                                    size: 22,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Rating',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Wrap(
                                spacing: 4,
                                children: List.generate(
                                  5,
                                  (index) => GestureDetector(
                                    onTap:
                                        () =>
                                            controller.updateRating(index + 1),
                                    child: Icon(
                                      Icons.star,
                                      size: 22,
                                      color:
                                          index < controller.rating.value
                                              ? Colors.amber
                                              : Colors.grey[300],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Obx(
                      () =>
                          controller.isLoading.value
                              ? const Center(child: CircularProgressIndicator())
                              : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF232323),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: isSmall ? 20 : 34,
                                    vertical: 13,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                onPressed: () async {
                                  await controller.submitPost();
                                  if (controller.postModel.value != null) {
                                    Navigator.pop(
                                      context,
                                      controller.postModel.value,
                                    );
                                  }
                                },
                                child: const Text(
                                  'Submit',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
