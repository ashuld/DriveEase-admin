import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drive_ease_admin/model/data_models/car_model.dart';
import 'package:flutter/material.dart';

class CarListProvider with ChangeNotifier {
  List<Car> _cars = [];

  List<Car> get cars => _cars;

  Future<void> fetchCars() async {
    // Fetch the list of cars from Firestore and convert them to `Car` objects.
    final snapshot = await FirebaseFirestore.instance.collection('cars').get();

    _cars = snapshot.docs.map((doc) => Car.fromFirestore(doc)).toList();

    notifyListeners();
  }
}
