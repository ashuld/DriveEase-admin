import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class CarProvider extends ChangeNotifier {
  String? _selectedImage;
  String _selectedGearType = 'Automatic';
  int _selectedSeats = 4;
  String _selectedCategory = 'Mini';
  Uint8List? selectedImage8;

  String? get selectedImage => _selectedImage;
  String get selectedGearType => _selectedGearType;
  int get selectedSeats => _selectedSeats;
  String get selectedCategory => _selectedCategory;

  Future<void> pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      _selectedImage = pickedImage.path;
      selectedImage8 = await pickedImage.readAsBytes();
      notifyListeners();
    }
  }

  void updateSelectedGearType(String gearType) {
    _selectedGearType = gearType;
    notifyListeners();
  }

  void updateSelectedSeats(int seats) {
    _selectedSeats = seats;
    notifyListeners();
  }

  void updateSelectedCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void resetAll() {
    _selectedImage = null;
    selectedImage8 = null;
    _selectedCategory = 'Mini';
    _selectedGearType = 'Automatic';
    _selectedSeats = 4;
  }
}
