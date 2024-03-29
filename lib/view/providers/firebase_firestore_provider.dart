// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drive_ease_admin/view/widgets/widgets.dart';
import 'package:drive_ease_admin/viewmodels/car_list_provider.dart';
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
    required double rentalAmount,
    required int quantity,
    required String gearType,
    required String seats,
    required String category,
  }) async {
    try {
      final carProvider = Provider.of<CarProvider>(context, listen: false);
      final String carId = DateTime.now().millisecondsSinceEpoch.toString();
      String carImage = await uploadImageToStorage(
          context: context,
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
      };
      await _firestore.collection('cars').doc(carId).set(carData);
      Provider.of<CarListProvider>(context, listen: false).fetchCars();
      log('Car details added to Firestore');
      Navigator.pop(context);
    } catch (e) {
      Navigator.pop(context);
      showSnackBar(context: context, message: 'Something went wrong!');
      log('Error adding car details to Firestore: $e');
      // Handle the error as needed
    }
  }

  Future<String> uploadImageToStorage(
      {required BuildContext context,
      required Uint8List fileName,
      required String fileType}) async {
    String folderName = "cars/admin";
    String pathName =
        "$folderName/${DateTime.now().millisecondsSinceEpoch.toString()}.$fileType";

    Reference ref = _storage.ref().child(pathName);
    UploadTask task = ref.putData(fileName);
    TaskSnapshot snap = await task;

    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}
