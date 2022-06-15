import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:core';
import 'package:get/get.dart';
import 'package:loginv1/ui/reglog/reset_password.dart';
import 'package:loginv1/ui/reglog/signup_page.dart';
import 'package:loginv1/ui/widgets/button.dart';
import 'package:loginv1/ui/widgets/form_icon.dart';
import 'package:loginv1/ui/widgets/form_vertical_spacing.dart';
import 'package:loginv1/ui/widgets/logo_graphic_header.dart';
import '../../constants/theme.dart';
import '../../controllers/auth_controller.dart';
import '../../helpers/validator.dart';
import '../widgets/label_button.dart';


class SignInUI extends StatelessWidget {
  final AuthController authController = AuthController.to;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
                  Container(
            width: w,
            height: h*0.3,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "lib/img/loginimg.png"
                ),
                fit: BoxFit.cover,
              )
        
            ),
          ),
       Form(
        key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[ 
                  Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            width: w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hello",
                  style: TextStyle(
                    fontSize: 70,
                    fontWeight: FontWeight.bold,
                     foreground: Paint()..shader = linearGradient,
                  ),
                ),
                Text(
                  "Sign into your account",
                  
                  style: TextStyle(
                      fontSize: 20,
                    
                      foreground: Paint()..shader = linearGradient,
                  ),
                ),
                SizedBox(height: 50,),
                  FormInputFieldWithIcon(
                    controller: authController.emailController,
                    iconPrefix: Icons.email,
                    labelText: 'auth.emailFormField'.tr,
                    validator: Validator().email,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) => null,
                    onSaved: (value) =>
                        authController.emailController.text = value!,
                  ),
                  FormVerticalSpace(),
                  FormInputFieldWithIcon(
                    controller: authController.passwordController,
                    iconPrefix: Icons.lock,
                    labelText: 'auth.passwordFormField'.tr,
                    validator: Validator().password,
                    obscureText: true,
                    onChanged: (value) => null,
                    onSaved: (value) =>
                        authController.passwordController.text = value!,
                    maxLines: 1,
                  ),
                  FormVerticalSpace(),
                  MyButton(
                      label: 'auth.signInButton'.tr,
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          authController.signInWithEmailAndPassword(context);
                        }
                      }),
                  FormVerticalSpace(),
                  LabelButton(
                    labelText: 'auth.resetPasswordLabelButton'.tr,
                    onPressed: () => Get.to(ResetPasswordUI()),
                  ),
                  LabelButton(
                    labelText: 'auth.signUpLabelButton'.tr,
                    onPressed: () => Get.to(SignUpUI()),
                  ),
                ],
              ),
            ),
                ],
          ),
        ),
          ),
       ),
        ],
      ),
      );
  
  
  }
}
