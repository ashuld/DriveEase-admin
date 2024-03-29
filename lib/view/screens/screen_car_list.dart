import 'package:drive_ease_admin/view/screens/screen_car_add.dart';
import 'package:drive_ease_admin/viewmodels/car_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenCarList extends StatelessWidget {
  const ScreenCarList({super.key});

  @override
  Widget build(BuildContext context) {
    // final carStream = FirebaseFirestore.instance.collection('cars').snapshots();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ScreenCarAdd(),
              ));
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        elevation: 0,
        title: const Text('Car Management'),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 10),
        child: Consumer<CarListProvider>(
            builder: (context, carListProvider, child) {
          // Fetch cars if the list is empty
          if (carListProvider.cars.isEmpty) {
            carListProvider.fetchCars();
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
                itemCount: carListProvider.cars.length,
                itemBuilder: (context, index) {
                  final car = carListProvider.cars[index];
                  return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: ListTile(
                          // ignore: unnecessary_null_comparison
                          leading: car.image != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(12.0),
                                  child: Image.network(
                                    car.image,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : const SizedBox.shrink(),
                          title: Text(
                            car.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            car.rentalAmount.toString(),
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          trailing: const Icon(Icons.more_vert),
                        ),
                      ));
                });
          }
        }),
        // child: StreamBuilder(
        //   stream: carStream,
        //   builder: (context, snapshot) {
        //     if (snapshot.hasError) {
        //       return const Center(
        //         child: Text('Connection Error'),
        //       );
        //     }
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return const Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     }
        //     var carDocs = snapshot.data!.docs;
        //     // Sort the carDocs list based on 'rentalAmount'
        //     carDocs.sort((a, b) {
        //       final rentalAmountA = (a.data()
        //           as Map<String, dynamic>)['rentalAmount'] as double?;
        //       final rentalAmountB = (b.data()
        //           as Map<String, dynamic>)['rentalAmount'] as double?;
        //       if (rentalAmountA != null && rentalAmountB != null) {
        //         return rentalAmountA.compareTo(rentalAmountB);
        //       }
        //       // Handle cases where rentalAmount is null
        //       return 0; // You can adjust this to place null values differently in the sorted list
        //     });

        //     return ListView.builder(
        //       itemCount: carDocs.length,
        //       itemBuilder: (context, index) {
        //         final carData =
        //             carDocs[index].data() as Map<String, dynamic>;
        //         final carName = carData['carName'] as String?;
        //         final rentalAmount = carData['rentalAmount'] as double?;
        //         final carImage = carData['carImage'] as String?;
        //         // final carId = carData['carId'];
        //         return Padding(
        //           padding: const EdgeInsets.symmetric(
        //               vertical: 5.0, horizontal: 5.0),
        //           child: Card(
        //             shape: RoundedRectangleBorder(
        //               borderRadius: BorderRadius.circular(12.0),
        //             ),
        //             elevation: 3,
        //             child: ListTile(
        //               leading: carImage != null
        //                   ? ClipRRect(
        //                       borderRadius: BorderRadius.circular(12.0),
        //                       child: Image.network(
        //                         carImage,
        //                         width: 100,
        //                         height: 100,
        //                         fit: BoxFit.cover,
        //                       ),
        //                     )
        //                   : const SizedBox
        //                       .shrink(), // Hide if carImage is null
        //               title: Text(carName ?? 'Car Name Not Available'),
        //               subtitle: Text(rentalAmount != null
        //                   ? 'Rental Amount: ₹$rentalAmount'
        //                   : 'Rental Amount Not Available'),
        //             ),
        //           ),
        //         );
        //       },
        //     );
        //   },
        // ),
      ),
    );
  }
}
