import 'package:flutter/material.dart';
import 'package:loginv1/constants/theme.dart';
/*
DropdownPicker(
                menuOptions: list of dropdown options in key value pairs,
                selectedOption: menu option string value,
                onChanged: (value) => print('changed'),
              ),
*/

class DropdownPicker extends StatelessWidget {
  DropdownPicker(
      {required this.menuOptions,
      required this.selectedOption,
      required this.onChanged});

  final List<dynamic> menuOptions;
  final String selectedOption;
  final void Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
      child: DropdownButton<String>(
          borderRadius: BorderRadius.circular(30),
          dropdownColor: primaryClr.withOpacity(0.3),
          style:  TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
          items: menuOptions
              .map((data) => DropdownMenuItem<String>(
                    child: Text(
                      data.value,
                    ),
                    value: data.key,
                  ))
              .toList(),
          value: selectedOption,
          onChanged: onChanged),
    );
  }
}
