import 'package:cloud_firestore/cloud_firestore.dart';

class Car {
  final String carId;
  final String name;
  final String gearType;
  final String seats;
  final double rentalAmount;
  final int quantity;
  final String image;
  final String category;

  Car({
    required this.carId,
    required this.name,
    required this.rentalAmount,
    required this.quantity,
    required this.category,
    required this.gearType,
    required this.image,
    required this.seats,
  });

  factory Car.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return Car(
      carId: doc.id,
      name: data['carName'] ?? '', // Handle null or missing data
      rentalAmount:
          (data['rentalAmount'] ?? 0).toDouble(), // Handle null or missing data
      quantity: data['quantity'] ?? 0, // Handle null or missing data
      gearType: data['gearType'] ?? '', // Handle null or missing data
      seats: data['seats'] ?? '', // Handle null or missing data
      category: data['category'] ?? '', // Handle null or missing data
      image: data['carImage'] ?? '', // Handle null or missing data
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'carId': carId,
      'carName': name,
      'rentalAmount': rentalAmount,
      'quantity': quantity,
      'category': category,
      'gearType': gearType,
      'carImage': image,
      'seats': seats,
    };
  }
}
