import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drive_ease_admin/view/providers/firebase_auth_provider.dart';
import 'package:drive_ease_admin/viewmodels/car_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';

class FireStoreProvider extends ChangeNotifier {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addCarDetailsToFirestore({
    required BuildContext context,
    required String carName,
    required int rentalAmount,
    required int quantity,
    required String gearType,
    required int seats,
    required String category,
  }) async {
    try {
      final userId =
          Provider.of<FirebaseAuthProvider>(context, listen: true).adminId;
      final carProvider = Provider.of<CarProvider>(context, listen: false);
      final String carId = DateTime.now().millisecondsSinceEpoch.toString();
      String carImage = await uploadImageToStorage(
          context: context,
          userId: carId,
          fileName: carProvider.selectedImage8!,
          fileType: 'carImage');
      final carData = {
        'carId': carId,
        'carName': carName,
        'rentalAmount': rentalAmount,
        'quantity': quantity,
        'gearType': gearType,
        'seats': seats,
        'category': category,
        'carImage': carImage
        // Add other fields if needed
      };
      final carCollection =
          _firestore.collection('admin').doc(userId).collection('cars');
      await carCollection.doc(carId).set(carData);
      log('Car details added to Firestore');
    } catch (e) {
      log('Error adding car details to Firestore: $e');
      // Handle the error as needed
    }
  }

  Future<String> uploadImageToStorage(
      {required BuildContext context,
      required String userId,
      required Uint8List fileName,
      required String fileType}) async {
    String folderName = "kycData/$userId";
    String pathName =
        "$folderName/${DateTime.now().millisecondsSinceEpoch.toString()}.$fileType";

    Reference ref = _storage.ref().child(pathName);
    UploadTask task = ref.putData(fileName);
    TaskSnapshot snap = await task;

    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}
