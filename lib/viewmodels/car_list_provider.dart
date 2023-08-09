import 'package:drive_ease_admin/model/data_models/car_model.dart';
import 'package:flutter/material.dart';

class CarListProvider with ChangeNotifier {
  List<Car> _cars = [];

  List<Car> get cars => _cars;

  void updateCarList(List<Car> newCarList) {
    _cars = newCarList;
    notifyListeners();
  }
}
