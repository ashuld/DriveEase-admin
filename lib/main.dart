import 'package:drive_ease_admin/firebase_options.dart';
import 'package:drive_ease_admin/view/providers/firebase_auth_provider.dart';
import 'package:drive_ease_admin/view/core/colors.dart';
import 'package:drive_ease_admin/view/providers/connectivity_provider.dart';
import 'package:drive_ease_admin/view/providers/firebase_firestore_provider.dart';
import 'package:drive_ease_admin/view/providers/utils_provider.dart';
import 'package:drive_ease_admin/viewmodels/auth_wrapper.dart';
import 'package:drive_ease_admin/viewmodels/car_provider.dart';
import 'package:drive_ease_admin/viewmodels/car_list_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => FireStoreProvider()),
    ChangeNotifierProvider(create: (context) => CarProvider()),
    ChangeNotifierProvider(create: (context) => CarListProvider()),
    ChangeNotifierProvider(create: (context) => FirebaseAuthProvider()),
    ChangeNotifierProvider(create: (context) => ConnectivityProvider()),
    ChangeNotifierProvider(create: (context) => UtilsProvider())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DriveEase-Admin',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            centerTitle: true,
            iconTheme: IconThemeData(color: AppColors.primaryColor, size: 30)),
        fontFamily: GoogleFonts.urbanist().fontFamily,
        dialogBackgroundColor: AppColors.primaryColor,
        scaffoldBackgroundColor: AppColors.primaryColor,
        useMaterial3: true,
      ),
      home: ResponsiveSizer(builder: (BuildContext context,
          Orientation orientation, ScreenType screenType) {
        return const AuthWrapper();
      }),
    );
  }
}
