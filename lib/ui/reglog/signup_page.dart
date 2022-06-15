import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:get/get.dart';
import 'package:loginv1/constants/theme.dart';
import 'package:loginv1/ui/widgets/button.dart';
import 'package:loginv1/ui/widgets/gender.dart';
import 'package:gender_picker/gender_picker.dart';
import '../../controllers/auth_controller.dart';
import '../../helpers/validator.dart';
import '../widgets/form_icon.dart';
import '../widgets/form_vertical_spacing.dart';
import '../widgets/label_button.dart';
import '../widgets/logo_graphic_header.dart';
import '../widgets/primary_button.dart';
import 'login_page.dart';

class SignUpUI extends StatelessWidget {
  final AuthController authController = AuthController.to;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
        double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
                
                
                children: <Widget>[
                   Container(
            width: w,
            height: h*0.3,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "lib/img/loginimg.png"
                ),
                fit: BoxFit.cover
              )
            ),
          ),

          Form(
        key: _formKey,
          child: Center(    
            child: SingleChildScrollView(
              child: Container(
                 margin: const EdgeInsets.only(left: 20, right: 20),
            width: w,
              child:Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [ 
                  SizedBox(height: 48.0),
                  FormInputFieldWithIcon(
                    controller: authController.nameController,
                    iconPrefix: Icons.person,
                    labelText: 'auth.nameFormField'.tr,
                    validator: Validator().name,
                    onChanged: (value) => null,
                    onSaved: (value) =>
                        authController.nameController.text = value!,
                    
                  ),
                  FormVerticalSpace(),
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
                    controller: authController.ageController,
                    iconPrefix: Icons.drive_file_rename_outline_outlined,
                    labelText: 'auth.ageFormField'.tr,
                    validator: Validator().age,
                    keyboardType: TextInputType.number,
                     inputFormatters: [
        LengthLimitingTextInputFormatter(2),
      ],
                    onChanged: (value) => null,
                    onSaved: (value) =>
                        authController.ageController.text = value!,
                  ),
                  FormVerticalSpace(),
                  //     FormInputFieldWithIcon(
                  //   controller: authController.sexController,
                  //   iconPrefix: Icons.family_restroom,
                  //   labelText: 'auth.sexFormField'.tr,
                  //   onChanged: (value) => null,
                  //   onSaved: (value) =>
                  //       authController.sexController.text = value!,
                  // ),
      
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
                   GenderClass(
                     
                     onChanged: (value) => null,
                    controller: authController.sexController,

                   ),
                  FormVerticalSpace(),
                  MyButton(
                      label: 'auth.signUpButton'.tr,
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          SystemChannels.textInput.invokeMethod(
                              'TextInput.hide'); //to hide the keyboard - if any
                          authController.registerWithEmailAndPassword(context);
                        }
                      }),
                  FormVerticalSpace(),
                  LabelButton(
                    labelText: 'auth.signInLabelButton'.tr,
                    onPressed: () => Get.to(SignInUI()),
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
}
