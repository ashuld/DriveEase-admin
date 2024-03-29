// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:drive_ease_admin/view/screens/home_screen.dart';
import 'package:drive_ease_admin/view/screens/login_screen.dart';
import 'package:drive_ease_admin/view/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? _adminId;

  String? get adminId => _adminId;

  Future<void> signIn(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      loadingDialog(context);
      UserCredential admin = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (admin.user == null) {
        showSnackBar(context: context, message: 'Admin-Data Not Found');
      } else {
        log(admin.user!.uid);
        log('sign in success');
        Navigator.pop(context);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const ScreenHome(),
            ));
        // await fetchDataFromFireStore(userId: admin.user!.uid);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Navigator.pop(context);
        log(e.code);
        showSnackBar(context: context, message: 'No User Found');
      } else if (e.code == 'wrong-password') {
        Navigator.pop(context);
        log(e.code);
        showSnackBar(context: context, message: 'Enter Correct password');
      }
    } catch (e) {
      Navigator.pop(context);
      showSnackBar(
          context: context,
          message: 'Something Happened! Please Try Again After few Minutes');
      log(e.toString());
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      loadingDialog(context);
      await _auth.signOut();
      Navigator.pop(context);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const ScreenLogin(),
          ));
      log("Sign Out Successful");
    } catch (e) {
      log("Error during sign out: $e");
    }
  }
}
