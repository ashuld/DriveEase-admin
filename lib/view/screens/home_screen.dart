import 'dart:developer';

import 'package:drive_ease_admin/view/core/colors.dart';
import 'package:drive_ease_admin/view/screens/screen_booking_history.dart';
import 'package:drive_ease_admin/view/screens/screen_car_list.dart';
import 'package:drive_ease_admin/view/screens/screen_driver_list.dart';
import 'package:drive_ease_admin/view/screens/screen_location_list.dart';
import 'package:drive_ease_admin/view/widgets/home_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: AppColors.primaryColor,
          statusBarIconBrightness: Brightness.light),
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  heading(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          HomeGestureButton(
                            image: 'assets/icons/icons8-car-96.png',
                            option: 'Car \nManagement',
                            onTapCallback: () {
                              log('button 1');
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ScreenCarList(),
                                  ));
                            },
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          HomeGestureButton(
                            image: 'assets/icons/icons8-driving-96.png',
                            option: 'Driver \nManagement',
                            onTapCallback: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ScreenDriverLIst(),
                                  ));
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          HomeGestureButton(
                              image: 'assets/icons/icons8-order-history-96.png',
                              option: 'Booking \nHistory',
                              onTapCallback: () {
                                log('button 3');
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ScreenBookingHistory(),
                                    ));
                              }),
                          const SizedBox(
                            width: 2,
                          ),
                          HomeGestureButton(
                              image:
                                  'assets/icons/icons8-map-marker-96 (1).png',
                              option: 'Pickup \nLocation',
                              onTapCallback: () {
                                log('button 4');
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ScreenLocationList(),
                                    ));
                              }),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding heading() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Text(
        'DashBoard',
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: [
            Shadow(
              color: Colors.grey.shade800, // Shadow color
              offset: const Offset(0, 4), // Offset in X and Y direction
              blurRadius: 6, // Spread of the shadow
            ),
          ],
        ),
      ),
    );
  }
}
