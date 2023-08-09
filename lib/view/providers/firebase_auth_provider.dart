// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drive_ease_admin/view/screens/home_screen.dart';
import 'package:drive_ease_admin/view/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

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
      Navigator.pop(context);
      log('sign in succes');
      if (admin.user == null) {
        showSnackBar(context: context, message: 'Admin-Data Not Found');
      } else {
        await getCurrentAdminId();
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

  Future<void> getCurrentAdminId() async {
    final user = _auth.currentUser;
    if (user != null) {
      final userDoc = await _fireStore.collection('admin').doc(user.uid).get();
      // _adminId = user.uid;
      notifyListeners();
      if (userDoc.exists) {
        _adminId = user.uid;
        notifyListeners(); // Return the adminId
      }
    }
  }
}
