import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loginv1/constants/theme.dart';
import 'package:loginv1/models/modele.dart';
import 'package:slimy_card/slimy_card.dart';

class statsPage extends StatefulWidget {
  const statsPage({Key? key, required this.task}) : super(key: key);
  final Task task;

  @override
  _statsPageState createState() => _statsPageState();
}

class _statsPageState extends State<statsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          elevation: 0.0,
        ),
        body: BottomCardWidget(task: widget.task)
        // body: Container(
        //   padding: EdgeInsetsDirectional.fromSTEB(0, 200, 0, 0),
        //   decoration: BoxDecoration(
        //     gradient: LinearGradient(
        //       colors: [
        //         Color(0xFFFFF3E0),
        //         Color(0xFFFF6E40),
        //       ],
        //       begin: Alignment.topCenter,
        //       end: Alignment.bottomCenter,
        //     ),
        //   ),
        //   child: StreamBuilder(
        //     initialData: false,
        //     stream: slimyCard.stream,
        //     builder: ((BuildContext context, AsyncSnapshot snapshot) {
        //       return ListView(
        //         padding: EdgeInsets.zero,
        //         children: <Widget>[
        //           SizedBox(height: 70),
        //           SlimyCard(
        //             color: secClr,
        //             topCardWidget: topCardWidget((snapshot.data)
        //                 ? 'lib/img/chart.jpeg'
        //                 : 'lib/img/chart.jpeg'),
        //             bottomCardWidget: BottomCardWidget(
        //               task: widget.task,
        //             ),
        //           ),
        //         ],
        //       );
        //     }),
        //   ),
        // ),
        );
  }

  Widget topCardWidget(String imagePath) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(image: AssetImage(imagePath)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                spreadRadius: 1,
              ),
            ],
          ),
        ),
        SizedBox(height: 15),
        Text(
          'Stats',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        SizedBox(height: 15),
        Center(
          child: Text(
            'Flutter is Google’s UI toolkit for building beautiful, natively compiled applications'
            ' for mobile, web, and desktop from a single codebase.',
            style: TextStyle(
                color: Colors.black.withOpacity(0.8),
                fontSize: 12,
                fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

//   Widget bottomCardWidget(Task task) {
//     Future<List<UserModel>> getUserDetailsById(List<String>? ids) async {
//       try {
//         List<UserModel> users = [];
//         for (var id in ids ?? []) {
//           final DocumentSnapshot documentSnapshot = await FirebaseFirestore
//               .instance
//               .collection('users')
//               .doc(id)
//               .get();
//           users.add(UserModel.fromMap(
//               documentSnapshot.data() as Map<String, dynamic>));
//         }
//         return users;
//       } catch (e) {
//         print(e);
//         return [];
//       }
//     }

//     return Column(
//       children: [
//         Text(
//           'https://flutterdevs.com/',
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 12,
//             fontWeight: FontWeight.w500,
//           ),
//           textAlign: TextAlign.center,
//         ),
//         SizedBox(height: 15),
//         Expanded(
//           child: FutureBuilder<List<UserModel>>(
//               future: getUserDetailsById(task.favoriteUsers),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.done) {
//                   print(snapshot.data!.length);
//                   return ListView.builder(
//                     itemCount: snapshot.data!.length,
//                     itemBuilder: (context, index) {
//                       print(snapshot.data![index].name);
//                       return Text(
//                         snapshot.data![index].name,
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500,
//                         ),
//                         textAlign: TextAlign.center,
//                       );
//                     },
//                   );
//                 }
//                 return const CircularProgressIndicator();
//               }),
//         ),
//       ],
//     );
//   }
// }

}

class BottomCardWidget extends StatefulWidget {
  const BottomCardWidget({Key? key, required this.task}) : super(key: key);
  final Task task;

  @override
  State<BottomCardWidget> createState() => _BottomCardWidgetState();
}

class _BottomCardWidgetState extends State<BottomCardWidget> {
  Future<List<UserModel>> getUserDetailsById(List<String>? ids) async {
    try {
      List<UserModel> users = [];
      for (var id in ids ?? []) {
        final DocumentSnapshot documentSnapshot =
            await FirebaseFirestore.instance.collection('users').doc(id).get();
        users.add(
            UserModel.fromMap(documentSnapshot.data() as Map<String, dynamic>));
      }
      return users;
    } catch (e) {
      print(e);
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<UserModel>>(
        future: getUserDetailsById(widget.task.favoriteUsers),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data!.isEmpty)
              return const Center(
                child: Text('No Users'),
              );
            double? averageAge = snapshot.data
                ?.map((u) => double.parse(u.age))
                .reduce((a, b) => a + b / snapshot.data!.length);
            List<UserModel>? noOfMales =
                snapshot.data?.where((u) => u.sex == 'male').toList();
            List<UserModel>? noOfFemales =
                snapshot.data?.where((u) => u.sex == 'female').toList();
            return SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Average Age:    ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        averageAge!.toStringAsFixed(0),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'No of Males:    ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        noOfMales?.length.toString() ?? '0',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'No Of Females:    ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        noOfFemales?.length.toString() ?? '0',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'List Of Users',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Text(
                        snapshot.data![index].name,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      );
                    },
                  ),
                ],
              ),
            );
          }
          return const CircularProgressIndicator();
        });
    // return Column(
    //   children: [
    //     Text(
    //       'https://flutterdevs.com/',
    //       style: TextStyle(
    //         color: Colors.black,
    //         fontSize: 12,
    //         fontWeight: FontWeight.w500,
    //       ),
    //       textAlign: TextAlign.center,
    //     ),

    //   ],
    // );
  }
}
