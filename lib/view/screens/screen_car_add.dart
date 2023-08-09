import 'dart:developer';
import 'dart:io';

import 'package:drive_ease_admin/view/core/colors.dart';
import 'package:drive_ease_admin/view/core/const_widgets.dart';
import 'package:drive_ease_admin/view/widgets/widgets.dart';
import 'package:drive_ease_admin/viewmodels/car_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ScreenCarAdd extends StatelessWidget {
  const ScreenCarAdd({super.key});

  @override
  Widget build(BuildContext context) {
    final carProvider = Provider.of<CarProvider>(context, listen: false);
    final TextEditingController nameController = TextEditingController();
    final TextEditingController rentalAmountController =
        TextEditingController();
    final TextEditingController quantityController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        title: const Text('Add Cars'),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 1.h,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    child: Column(
                      children: [
                        imageSelection(carProvider),
                        ConstWidgets.sizeH20,
                        nameField(nameController),
                        ConstWidgets.sizeH20,
                        rentalField(rentalAmountController),
                        ConstWidgets.sizeH20,
                        quantityField(quantityController),
                        ConstWidgets.sizeH20,
                        gearType(),
                        ConstWidgets.sizeH20,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            seats(),
                            category(),
                          ],
                        ),
                        ConstWidgets.sizeH20,
                        InkWell(
                          onTap: () async {
                            //function to check whether the image is selected or not
                            if (carProvider.selectedImage == null) {
                              showSnackBar(
                                  context: context,
                                  message: 'Please select an image');
                              return;
                            }
                            if (nameController.text.trim().isEmpty) {
                              showSnackBar(
                                  context: context,
                                  message: 'Please Input car name');
                              return;
                            }
                            if (rentalAmountController.text.trim().isEmpty) {
                              showSnackBar(
                                  context: context,
                                  message: 'Please Input rental amount');
                              return;
                            }
                            if (quantityController.text.trim().isEmpty) {
                              showSnackBar(
                                  context: context,
                                  message: 'Please Input No. of Cars');
                              return;
                            }
                            final carName = nameController.text.trim();
                            double? rentalAmount;
                            int? quantity;
                            String? errorMsg;
                            try {
                              rentalAmount = double.tryParse(
                                  rentalAmountController.text.trim());
                              if (rentalAmount == null) {
                                throw const FormatException('null');
                              } else if (rentalAmount < 200) {
                                throw const FormatException('not 200');
                              }
                            } catch (e) {
                              if (e is FormatException &&
                                  e.message == 'not 200') {
                                errorMsg = 'Amount should not be less than 200';
                              } else if (e is FormatException &&
                                  e.message == 'null') {
                                errorMsg = 'Invalid amount';
                              }
                            }
                            try {
                              quantity =
                                  int.tryParse(quantityController.text.trim());
                              if (quantity == null) {
                                throw const FormatException('null');
                              } else if (quantity < 1 || quantity > 10) {
                                throw const FormatException('range error');
                              }
                            } catch (e) {
                              if (e is FormatException &&
                                  e.message == 'range error') {
                                errorMsg =
                                    'Minimum no of cars that can be added is 1 and maximum is 10';
                              } else if (e is FormatException &&
                                  e.message == 'null') {
                                errorMsg = 'Invaild No. of cars';
                              }
                            }
                            if (errorMsg != null) {
                              showSnackBar(context: context, message: errorMsg);
                            } else {
                              log('validation completed');
                              log(rentalAmount.toString());
                            }
                          },
                          child: Container(
                            width: 50.w,
                            height: 6.2.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              border:
                                  Border.all(color: AppColors.secondaryColor),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Submit',
                                  style: textStyle(
                                    size: 25,
                                    color: AppColors.secondaryColor,
                                    thickness: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column category() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Category',
          style: textStyle(
            color: AppColors.hintStyle,
            size: 16,
          ),
        ),
        const SizedBox(height: 5),
        Consumer<CarProvider>(
          builder: (context, carProvider, child) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              height: 50,
              width: 105,
              decoration: BoxDecoration(
                  color: AppColors.formFieldFilled,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.enabled)),
              child: DropdownButton<String>(
                iconEnabledColor: AppColors.hintStyle,
                borderRadius: BorderRadius.circular(8),
                dropdownColor: AppColors.formFieldFilled,
                value: carProvider.selectedCategory,
                onChanged: (value) {
                  carProvider.updateSelectedCategory(value!);
                },
                items: ['Mini', 'Sedan', 'Premium', 'Electric']
                    .map(
                      (category) => DropdownMenuItem<String>(
                        value: category,
                        child: Text(category,
                            style: textStyle(color: AppColors.secondaryColor)),
                      ),
                    )
                    .toList(),
              ),
            );
          },
        ),
      ],
    );
  }

  Column seats() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Seats',
          style: textStyle(
            color: AppColors.hintStyle,
            size: 16,
          ),
        ),
        const SizedBox(height: 5),
        Consumer<CarProvider>(
          builder: (context, carProvider, child) {
            final seatItems = List.generate(9, (index) => index + 1)
                .where((value) => value >= 4)
                .map((value) => DropdownMenuItem<int>(
                      value: value,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              value.toString(),
                              style: textStyle(color: AppColors.secondaryColor),
                            ),
                            const SizedBox(width: 28),
                          ],
                        ),
                      ),
                    ))
                .toList();
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              height: 50,
              width: 100,
              decoration: BoxDecoration(
                  color: AppColors.formFieldFilled,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.enabled)),
              child: DropdownButton<int>(
                borderRadius: BorderRadius.circular(8),
                iconEnabledColor: AppColors.hintStyle,
                dropdownColor: AppColors.formFieldFilled,
                value: carProvider.selectedSeats,
                onChanged: (value) {
                  carProvider.updateSelectedSeats(value!);
                },
                items: seatItems,
              ),
            );
          },
        ),
      ],
    );
  }

  Column gearType() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gear Type',
          style: textStyle(
            color: AppColors.hintStyle,
            size: 16,
          ),
        ),
        const SizedBox(height: 5),
        Consumer<CarProvider>(
          builder: (context, carProvider, child) {
            return Row(
              children: [
                Radio<String>(
                  value: 'Automatic',
                  groupValue: carProvider.selectedGearType,
                  onChanged: (value) {
                    carProvider.updateSelectedGearType(value!);
                  },
                ),
                Text(
                  'Automatic',
                  style: textStyle(color: AppColors.secondaryColor),
                ),
                Radio<String>(
                  value: 'Manual',
                  groupValue: carProvider.selectedGearType,
                  onChanged: (value) {
                    carProvider.updateSelectedGearType(value!);
                  },
                ),
                Text(
                  'Manual',
                  style: textStyle(color: AppColors.secondaryColor),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  TextFormField quantityField(TextEditingController quantityController) {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: quantityController,
      style: textStyle(color: AppColors.hintStyle, size: 18),
      decoration: InputDecoration(
        hintText: 'No. of Cars',
        hintStyle: textStyle(color: AppColors.hintStyle),
        filled: true,
        fillColor: AppColors.formFieldFilled,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.enabled),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.focused),
        ),
      ),
    );
  }

  TextFormField rentalField(TextEditingController rentalAmountController) {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: rentalAmountController,
      style: textStyle(color: AppColors.hintStyle, size: 18),
      decoration: InputDecoration(
        hintText: 'Rental Amount in Rs.',
        hintStyle: textStyle(color: AppColors.hintStyle),
        filled: true,
        fillColor: AppColors.formFieldFilled,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.enabled),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.focused),
        ),
      ),
    );
  }

  TextFormField nameField(TextEditingController nameController) {
    return TextFormField(
      keyboardType: TextInputType.name,
      controller: nameController,
      style: textStyle(color: AppColors.hintStyle, size: 18),
      decoration: InputDecoration(
        hintText: 'Car Name',
        hintStyle: textStyle(color: AppColors.hintStyle),
        filled: true,
        fillColor: AppColors.formFieldFilled,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.enabled),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.focused),
        ),
      ),
    );
  }

  Padding imageSelection(CarProvider carProvider) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () => carProvider.pickImage(),
        child: Consumer<CarProvider>(builder: (context, provider, child) {
          return Container(
            height: 20.h,
            width: 60.w,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.enabled),
              borderRadius: BorderRadius.circular(8),
            ),
            child: carProvider.selectedImage != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      File(carProvider.selectedImage!),
                      fit: BoxFit.cover,
                    ),
                  )
                : const Icon(
                    Icons.add_a_photo,
                    color: AppColors.hintStyle,
                  ),
          );
        }),
      ),
    );
  }
}
