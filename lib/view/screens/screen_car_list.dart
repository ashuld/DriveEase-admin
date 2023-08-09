import 'package:drive_ease_admin/view/core/colors.dart';
import 'package:drive_ease_admin/view/screens/screen_car_add.dart';
import 'package:drive_ease_admin/view/widgets/widgets.dart';
import 'package:drive_ease_admin/viewmodels/car_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ScreenCarList extends StatelessWidget {
  const ScreenCarList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
          statusBarIconBrightness: Brightness.light,
          statusBarColor: AppColors.primaryColor),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.primaryColor,
            title: Text(
              'Car Management',
              style: textStyle(size: 30),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ScreenCarAdd(),
                  ));
            },
          ),
          body: Consumer<CarListProvider>(builder: (context, carList, child) {
            return _buildCarList(carList);
          }),
        ),
      ),
    );
  }

  // Function to open Car Adding Page
  Widget _buildCarList(CarListProvider carList) {
    return ListView.builder(
      itemCount: carList.cars.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Card(
            clipBehavior: Clip.hardEdge,
            child: Container(
              color: const Color.fromARGB(255, 239, 239, 239),
              child: ExpansionTile(
                leading: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(9)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(9),
                    child: const Text('imagfe'),
                  ),
                ),
                title: const Text('car.name'),
                subtitle: const Text('Quantity: '),
                children: [
                  ListTile(
                    title: const Text('Description: '),
                    subtitle: const Text('Category: '),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
