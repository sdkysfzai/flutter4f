import 'package:flutter/material.dart';
import '../../constants/size_config.dart';
import '../../constants/theme.dart';

class MyButton extends StatelessWidget {
  final Function? onTap;
  final String? label;

  MyButton({
    this.onTap,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap as void Function()?,
      child: Container(
        height: 50,
        width: 130,
        decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      image: DecorationImage(
      image: AssetImage(
        "lib/img/loginbtn.png"
      ),
      fit: BoxFit.cover,
      ),
    
    ),
        child: Center(
          child: Text(
            label!,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
