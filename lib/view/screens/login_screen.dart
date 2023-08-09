import 'package:drive_ease_admin/view/providers/firebase_auth_provider.dart';
import 'package:drive_ease_admin/view/core/colors.dart';
import 'package:drive_ease_admin/view/providers/connectivity_provider.dart';
import 'package:drive_ease_admin/view/providers/utils_provider.dart';
import 'package:drive_ease_admin/view/widgets/network_error.dart';
import 'package:drive_ease_admin/view/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:regexpattern/regexpattern.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ScreenLogin extends StatelessWidget {
  const ScreenLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController mailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: AppColors.primaryColor,
        statusBarIconBrightness: Brightness.light,
      ),
      child: SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
                child: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 5.w, top: 9.h),
                child: Text("Log In To Control\nDriveEase",
                    style: textStyle(size: 30, thickness: FontWeight.bold)),
              ),
              SizedBox(
                height: 9.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: mailController,
                  style: textStyle(color: AppColors.hintStyle, size: 18),
                  decoration: InputDecoration(
                      hintText: 'Enter your Email',
                      hintStyle: textStyle(color: AppColors.hintStyle),
                      filled: true,
                      fillColor: AppColors.formFieldFilled,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              const BorderSide(color: AppColors.enabled)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              const BorderSide(color: AppColors.focused))),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Consumer<UtilsProvider>(builder: (BuildContext context,
                    UtilsProvider passwordVisibility, Widget? child) {
                  return TextFormField(
                    inputFormatters: [LengthLimitingTextInputFormatter(6)],
                    controller: passwordController,
                    style: textStyle(color: AppColors.hintStyle, size: 18),
                    obscureText: passwordVisibility.isObscured,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () =>
                                passwordVisibility.changePasswordVisibility(),
                            icon: Icon(
                              passwordVisibility.isObscured
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: AppColors.secondaryColor,
                            )),
                        hintText: 'Enter your Password',
                        hintStyle: textStyle(color: AppColors.hintStyle),
                        filled: true,
                        fillColor: AppColors.formFieldFilled,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                const BorderSide(color: AppColors.enabled)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                const BorderSide(color: AppColors.focused))),
                  );
                }),
              ),
              SizedBox(
                height: 9.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      if (mailController.text.isEmpty &&
                          passwordController.text.isEmpty) {
                        showSnackBar(
                            context: context, message: 'Enter mail & password');
                      } else if (mailController.text.isEmpty) {
                        showSnackBar(
                            context: context, message: 'Enter your email');
                      } else if (passwordController.text.isEmpty) {
                        showSnackBar(
                            context: context, message: 'enter your password');
                      } else {
                        final connectivity = Provider.of<ConnectivityProvider>(
                            context,
                            listen: false);
                        if (!connectivity.isDeviceConnected) {
                          networkDialog(context);
                        } else {
                          String email = mailController.text.trim();
                          String password = passwordController.text.trim();
                          bool isValid = email.isEmail();
                          if (!isValid) {
                            showSnackBar(
                                context: context,
                                message: 'Enter Valid Email Address');
                            return;
                          }
                          final authProvider =
                              Provider.of<FirebaseAuthProvider>(context,
                                  listen: false);
                          authProvider.signIn(
                              email: email,
                              password: password,
                              context: context);
                        }
                      }
                    },
                    child: Container(
                      width: 60.w,
                      height: 6.2.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        border: Border.all(color: AppColors.secondaryColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Log In',
                            style: textStyle(
                                size: 25,
                                color: AppColors.secondaryColor,
                                thickness: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ))),
      ),
    );
  }
}
