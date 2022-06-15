import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loginv1/constants/theme.dart';
import 'package:loginv1/ui/reglog/updateprofile.dart';

import '../../constants/globals.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/language_controller.dart';
import '../widgets/dropdown_picker.dart';


class Settings extends StatefulWidget {
  const Settings({ Key? key }) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
    backgroundColor: secClr,
    body:Container(
      
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 12,
            ),
            _signOut(),
             
            _updateP(),
            SizedBox(
              height: 12,
              
            ),
           languageListTile(context),
             SizedBox(
              height: 12,
              
            ),
          ],
        ),
      ),

    ),
 
    );
  }
  languageListTile(BuildContext context) {
     double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Container(
       width: w*0.8,
    height: h*0.07,
       decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      image: DecorationImage(
      image: AssetImage(
        "lib/img/loginbtn.png"
      ),
      fit: BoxFit.cover,
      ),
    
    ),
      child: GetBuilder<LanguageController>(
        builder: (controller) => ListTile(
          title: Padding(
            padding: const EdgeInsets.fromLTRB(20,  5,  0,  0),
            child: Text('settings.language'.tr,
            style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),),
          ),
          trailing: DropdownPicker(
            menuOptions: Globals.languageOptions,
            selectedOption: controller.currentLanguage,
            onChanged: (value) async {
              await controller.updateLanguage(value!);
              Get.forceAppUpdate();
            },
          ),
        ),
      ),
    );
  }
   _signOut(){
     double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
     return GestureDetector(
      onTap: () {
              AuthController.to.logout();
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(0, h*1/9, 0, h*1/27),
    width: w*0.30,
    height: h*0.07,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      image: DecorationImage(
      image: AssetImage(
        "lib/img/loginbtn.png"
      ),
      fit: BoxFit.cover,
      ),
    
    ),
    child:Center(
      child:   Text(
                    "Sign out",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
    ),
    
          ),
    );
  }
    _updateP(){
     double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
     return GestureDetector(
      onTap: () async {
              Get.to(UpdateProfileUI());
      },
      child: Container(

                margin: EdgeInsets.fromLTRB(0, 0, 0, h*1/27),

    width: w*0.50,
    height: h*0.07,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      image: DecorationImage(
      image: AssetImage(
        "lib/img/loginbtn.png"
      ),
      fit: BoxFit.cover,
      ),
    
    ),
    child:Center(
      child:   Text(
                    "Update Profile",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
    ),
    
          ),
    );
  }
}



