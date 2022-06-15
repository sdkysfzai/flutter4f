import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:loginv1/constants/theme.dart';

import '../../controllers/auth_controller.dart';
import '../widgets/avatar.dart';
import '../widgets/form_vertical_spacing.dart';

class HomeUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return GetBuilder<AuthController>(
      init: AuthController(),
      builder: (controller) => controller.firestoreUser.value!.uid == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
            backgroundColor: secClr,
             
              body: Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 120),
                    Avatar(controller.firestoreUser.value!, 70),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FormVerticalSpace(),
                        FormVerticalSpace(),
                        Text(
                            'home.uidLabel'.tr +
                                ': ' +
                                controller.firestoreUser.value!.uid,
                            style: TextStyle(fontSize: 16)),
                        FormVerticalSpace(),
                        Text(
                            'home.nameLabel'.tr +
                                ': ' +
                                controller.firestoreUser.value!.name,
                            style: TextStyle(fontSize: 16)),
                        FormVerticalSpace(),
                        Text(
                            'home.emailLabel'.tr +
                                ': ' +
                                controller.firestoreUser.value!.email,
                            style: TextStyle(fontSize: 16)),
                        FormVerticalSpace(),
                        Text(
                            'home.adminUserLabel'.tr +
                                ': ' +
                                controller.admin.value.toString(),
                            style: TextStyle(fontSize: 16)),
                        FormVerticalSpace(),
                        Text(
                            'home.genderLabel'.tr +
                                ': ' +
                                controller.firestoreUser.value!.sex.tr,
                            style: TextStyle(fontSize: 16)),
                            FormVerticalSpace(),
                         Text(
                            'home.ageLabel'.tr +
                                ': ' +
                                controller.firestoreUser.value!.age,
                            style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}