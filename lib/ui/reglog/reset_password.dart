import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:loginv1/ui/reglog/login_page.dart';
import 'package:loginv1/ui/reglog/welcome_page.dart';
import 'package:loginv1/ui/widgets/button.dart';

import '../../controllers/auth_controller.dart';
import '../../helpers/validator.dart';
import '../widgets/form_icon.dart';
import '../widgets/form_vertical_spacing.dart';
import '../widgets/label_button.dart';
import '../widgets/logo_graphic_header.dart';
import '../widgets/primary_button.dart';

class ResetPasswordUI extends StatelessWidget {
  final AuthController authController = AuthController.to;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
        double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body:Column(
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                 
                  SizedBox(height: h/3),
                  FormInputFieldWithIcon(
                    controller: authController.emailController,
                    iconPrefix: Icons.email,
                    labelText: 'auth.emailFormField'.tr,
                    validator: Validator().email,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) => null,
                    onSaved: (value) =>
                        authController.emailController.text = value as String,
                  ),
                  FormVerticalSpace(),
                  
                  MyButton(
                      label: 'auth.resetPasswordButton'.tr,
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          await authController.sendPasswordResetEmail(context);
                        }
                      }),
                  FormVerticalSpace(),
                  signInLink(context),
                  LabelButton(
                    labelText: 'goBackHome'.tr,
                    onPressed: () => Get.to(SignInUI())
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
        ],
      ),
        
    );
  }

  appBar(BuildContext context) {
    if (authController.emailController.text == '') {
      return null;
    }
    return AppBar(title: Text('auth.resetPasswordTitle'.tr));
  }

  signInLink(BuildContext context) {
    if (authController.emailController.text == '') {
      return LabelButton(
        labelText: 'auth.signInonResetPasswordLabelButton'.tr,
        onPressed: () => Get.offAll(SignInUI()),
      );
    }
    return Container(width: 0, height: 0);
  }
}
