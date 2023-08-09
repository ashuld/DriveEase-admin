import 'dart:developer';

import 'package:drive_ease_admin/view/core/colors.dart';
import 'package:drive_ease_admin/view/providers/connectivity_provider.dart';
import 'package:drive_ease_admin/view/providers/firebase_auth_provider.dart';
import 'package:drive_ease_admin/view/screens/home_screen.dart';
import 'package:drive_ease_admin/view/screens/login_screen.dart';
import 'package:drive_ease_admin/view/widgets/network_error.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<FirebaseAuthProvider>(context, listen: false);
    return Consumer<ConnectivityProvider>(
        builder: (context, connectivity, child) {
      if (!connectivity.isDeviceConnected) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark.copyWith(
              statusBarColor: AppColors.primaryColor,
              statusBarIconBrightness: Brightness.light),
          child: SafeArea(
            child: Scaffold(
              body: Center(
                child: networkError(),
              ),
            ),
          ),
        );
      } else {
        return StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, authSnapshot) {
            if (authSnapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            } else {
              bool isLoggedIn = authSnapshot.hasData;
              if (!isLoggedIn) {
                return const ScreenLogin();
              } else {
                return FutureBuilder(
                  future: auth.getCurrentAdminId(),
                  builder: (context, idSnapshot) {
                    if (idSnapshot.connectionState == ConnectionState.waiting) {
                      return const Scaffold(
                        body: Center(child: CircularProgressIndicator()),
                      );
                    } else {
                      log(Provider.of<FirebaseAuthProvider>(context,
                                  listen: true)
                              .adminId ??
                          'not found');
                      return const ScreenHome();
                    }
                  },
                );
              }
            }
          },
        );
      }
    });
  }
}
