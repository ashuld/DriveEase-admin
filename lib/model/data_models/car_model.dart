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

  factory Car.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Car(
      carId: doc.id,
      name: data['name'],
      rentalAmount: data['rentalAmount'],
      quantity: data['quantity'],
      category: data['category'],
      gearType: data['gearType'],
      image: data['image'],
      seats: data['seats'],
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
