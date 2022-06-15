import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:loginv1/constants/theme.dart';
import 'package:loginv1/ui/widgets/button.dart';
import 'package:loginv1/ui/widgets/form_icon.dart';
import 'package:loginv1/ui/widgets/form_vertical_spacing.dart';
import 'package:loginv1/ui/widgets/label_button.dart';
import 'package:loginv1/ui/widgets/logo_graphic_header.dart';
import 'package:loginv1/ui/widgets/primary_button.dart';
import '/models/modele.dart';
import '/helpers/helpers.dart';
import '/controllers/controllers.dart';
import 'auth.dart';



class UpdateProfileUI extends StatelessWidget {
  final AuthController authController = AuthController.to;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    //print('user.name: ' + user?.value?.name);
    authController.nameController.text =
        authController.firestoreUser.value!.name;
    authController.emailController.text =
        authController.firestoreUser.value!.email;
          double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: 
      Column(
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
          ),Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                width: w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
      
                    
                    SizedBox(height: h/4),
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
                    MyButton(
                        label: 'auth.updateUser'.tr,
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            SystemChannels.textInput
                                .invokeMethod('TextInput.hide');
                            UserModel _updatedUser = UserModel(
                                sex: authController.sexController.text,
                                age: authController.ageController.text,
                                uid: authController.firestoreUser.value!.uid,
                                name: authController.nameController.text,
                                email: authController.emailController.text,
                                photoUrl:
                                    authController.firestoreUser.value!.photoUrl);
                            _updateUserConfirm(context, _updatedUser,
                                authController.firestoreUser.value!.email);
                          }
                        }),
                    FormVerticalSpace(),
                    LabelButton(
                      labelText: 'auth.resetPasswordLabelButton'.tr,
                      onPressed: () => Get.to(ResetPasswordUI()),
                    ),
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
      ),
        ],
      ),
    );
  }

  Future<void> _updateUserConfirm(
      BuildContext context, UserModel updatedUser, String oldEmail) async {
    final AuthController authController = AuthController.to;
    final TextEditingController _password = new TextEditingController();
    return Get.dialog(
      AlertDialog(
        backgroundColor: secClr,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0))),
        title: Text(
          'auth.enterPassword'.tr,
          style: TextStyle(
            foreground: Paint()..shader = linearGradient,
          ),
        ),
        content: FormInputFieldWithIcon(
          controller: _password,
          iconPrefix: Icons.lock,
          labelText: 'auth.passwordFormField'.tr,
          validator: (value) {
            String pattern = r'^.{6,}$';
            RegExp regex = RegExp(pattern);
            if (!regex.hasMatch(value!))
              return 'validator.password'.tr;
            else
              return null;
          },
          obscureText: true,
          onChanged: (value) => null,
          onSaved: (value) => _password.text = value!,
          maxLines: 1,
        ),
        actions: <Widget>[
          new LabelButton(
            labelText: 'auth.cancel'.tr,
            onPressed: () {
              Get.back();
            },
          ),
          new LabelButton(
           labelText: 'auth.submit'.tr,
            onPressed: () async {
              Get.back();
              await authController.updateUser(
                  context, updatedUser, oldEmail, _password.text);
            },
          )
        ],
      ),
    );
  }
}
