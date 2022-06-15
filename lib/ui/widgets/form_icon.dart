import 'package:flutter/material.dart';
import 'package:loginv1/constants/theme.dart';
import 'gender.dart';
/*
FormInputFieldWithIcon(
                controller: _email,
                iconPrefix: Icons.link,
                labelText: 'Post URL',
                validator: Validator.notEmpty,
                keyboardType: TextInputType.multiline,
                minLines: 3,
                onChanged: (value) => print('changed'),
                onSaved: (value) => print('implement me'),
              ),
*/

class FormInputFieldWithIcon extends StatelessWidget {
  FormInputFieldWithIcon(
      {required this.controller,
      required this.iconPrefix,
      required this.labelText,
      this.validator,
      this.keyboardType = TextInputType.text,
      this.obscureText = false,
      this.minLines = 1,
      this.maxLines,
      this.backC,
      this. inputFormatters,
      required this.onChanged,
      required this.onSaved});
     

  final TextEditingController controller;
  final IconData iconPrefix;
  final String labelText;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool obscureText;
  final int minLines;
  final int? maxLines;
  final dynamic inputFormatters;
  final void Function(String) onChanged;
  final void Function(String?)? onSaved;
  final Color? backC;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: primaryClr,
              
  decoration: InputDecoration(
      filled: true,
      
        prefixIcon: Icon(iconPrefix, color: primaryClr),
        labelText: labelText,
        labelStyle: new TextStyle(color: primaryClr,),
        
  enabledBorder: UnderlineInputBorder(   
    borderRadius: BorderRadius.circular(30),   
    borderSide: BorderSide(color: primaryClr),   
  ),  
  focusedBorder: UnderlineInputBorder(
    borderRadius: BorderRadius.circular(30),   
    borderSide: BorderSide(color: primaryClr),
  ),
  border: UnderlineInputBorder(
    borderRadius: BorderRadius.circular(30),   
    borderSide: BorderSide(color: primaryClr),
  ),


      ),
      
      controller: controller,
      onSaved: onSaved,
      onChanged: onChanged,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      obscureText: obscureText,
      maxLines: maxLines,
      minLines: minLines,
      validator: validator,
      
    );
  }

}

 