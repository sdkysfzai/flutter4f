import 'package:flutter/material.dart';
import 'package:gender_picker/gender_picker.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:get/get.dart';
import 'package:loginv1/constants/theme.dart';
import 'package:loginv1/controllers/auth_controller.dart';

class GenderClass extends StatelessWidget {
 
GenderClass(

  {
      required this.controller,
      this.validator,
      required this.onChanged,
       this.onSaved
      }
      );

  final TextEditingController controller;
  final String? Function(String?)? validator;
  final void Function(String) onChanged;
  final void Function(String?)? onSaved;
  final AuthController authController = AuthController.to;
  @override

  Widget getWidget(bool showOtherGender, bool alignVertical) {
     
    return Container(
      
      margin: EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.center,
      child: GenderPickerWithImage(
        showOtherGender: showOtherGender,
        verticalAlignedText: alignVertical,
        // to show what's selected on app opens, but by default it's Male
        selectedGender: Gender.Others,
        selectedGenderTextStyle: TextStyle(
            color: primaryClr, fontWeight: FontWeight.bold),
        unSelectedGenderTextStyle: TextStyle(
            color: Colors.black, fontWeight: FontWeight.normal),
        onChanged: (Gender? gender) {
          print(gender);
          if (gender == 'Gender.Male'){
            
          }
          authController.sexController.text = gender.toString();
        },
        //Alignment between icons
        equallyAligned: true,
      
        animationDuration: Duration(milliseconds: 300),
        isCircular: true,
        // default : true,
        opacityOfGradient: 0.4,
        padding: const EdgeInsets.all(3),
        size: 40, //default : 40
      ),
    );
  }


  Widget build(BuildContext context) {
    return Column(
              mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[   
            getWidget(false, false),
            Divider(),
          ],
        // controller: controller,
        // onSaved: onSaved,
        // onChanged: onChanged,
        // validator: validator,
    );
  }
}