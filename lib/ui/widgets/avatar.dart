import 'package:flutter/material.dart';


import '../../models/user_models.dart';
import 'logo_graphic_header.dart';

class Avatar extends StatelessWidget {
  Avatar(
    this.user,
    this.radiu,
  );
  final UserModel user;
  double radiu;
  @override
  Widget build(BuildContext context) {
    if (user.photoUrl == '') {
      return LogoGraphicHeader();
    }
    return Hero(
      tag: 'User Avatar Image',
      child: CircleAvatar(
          foregroundColor: Colors.blue,
          backgroundColor: Colors.white,
          radius: radiu,
          child: ClipOval(
            child: Image.network(
              user.photoUrl,
              fit: BoxFit.cover,
              width: 120.0,
              height: 120.0,
            ),
          )),
    );
  }
}