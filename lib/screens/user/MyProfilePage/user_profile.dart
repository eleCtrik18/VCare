// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:v_care/configs/colors.dart';
// import 'package:v_care/screens/user/login_screen.dart';

// import '../../../providers/user_provider.dart';
// import 'package:v_care/models/user.dart' as model;

// class EditProfilePage extends StatefulWidget {
//   @override
//   _EditProfilePageState createState() => _EditProfilePageState();
// }

// class _EditProfilePageState extends State<EditProfilePage> {
//   bool showPassword = false;
//   String username = "";
//   String email = "";
//   String photoUrl = "";
//   String bio = "";
//   @override
//   void initState() {
//     super.initState();
//     getdetails();
//     // addData();
//   }

//   void getdetails() async {
//     DocumentSnapshot snap = await FirebaseFirestore.instance
//         .collection('users')
//         .doc(FirebaseAuth.instance.currentUser!.uid)
//         .get();
//     print(snap.data());

//     if (snap.data() != null) {
//       setState(() {
//         username = (snap.data() as Map<String, dynamic>)['username'];
//         photoUrl = (snap.data() as Map<String, dynamic>)['photoUrl'];
//         bio = (snap.data() as Map<String, dynamic>)['bio'];
//         email = (snap.data() as Map<String, dynamic>)['email'];
//       });
//     }
//   }

//   // addData() async {
//   //   UserProvider _userProvider =
//   //       Provider.of<UserProvider>(context, listen: false);
//   //   await _userProvider.refreshUser();
//   // }

//   // addData() async {
//   //   UserProvider _userProvider =
//   //       Provider.of<UserProvider>(context, listen: false);
//   //   await _userProvider.refreshUser();
//   //   print('Running AdData');
//   //   print(_userProvider.getUser);
//   // }

//   @override
//   Widget build(BuildContext context) {
//     // model.User? user = Provider.of<UserProvider>(context).getUser;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'User Profile',
//           style: TextStyle(
//               fontSize: 25, color: blueColor, fontWeight: FontWeight.w500),
//         ),
//         centerTitle: true,
//         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(
//             Icons.arrow_back,
//             color: blueColor,
//           ),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//         actions: [
//           // IconButton(
//           //   icon: const Icon(
//           //     Icons.settings,
//           //     color: blueColor,
//           //   ),
//           //   onPressed: () {
//           //     // Navigator.of(context).push(MaterialPageRoute(
//           //     //     builder: (BuildContext context) => SettingsPage()));
//           //   },
//           // ),
//         ],
//       ),
//       body: Container(
//         padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
//         child: GestureDetector(
//           onTap: () {
//             FocusScope.of(context).unfocus();
//           },
//           child: ListView(
//             children: [
//               const SizedBox(
//                 height: 15,
//               ),
//               Center(
//                 child: Stack(
//                   children: [
//                     Container(
//                       width: 130,
//                       height: 130,
//                       decoration: BoxDecoration(
//                           border: Border.all(
//                               width: 4,
//                               color: Theme.of(context).scaffoldBackgroundColor),
//                           boxShadow: [
//                             BoxShadow(
//                                 spreadRadius: 2,
//                                 blurRadius: 10,
//                                 color: Colors.black.withOpacity(0.1),
//                                 offset: const Offset(0, 10))
//                           ],
//                           shape: BoxShape.circle,
//                           image: DecorationImage(
//                               fit: BoxFit.cover,
//                               image: NetworkImage(photoUrl))),
//                     ),
//                     // Positioned(
//                     //     bottom: 0,
//                     //     right: 0,
//                     //     child: Container(
//                     //       height: 40,
//                     //       width: 40,
//                     //       decoration: BoxDecoration(
//                     //         shape: BoxShape.circle,
//                     //         border: Border.all(
//                     //           width: 4,
//                     //           color: Theme.of(context).scaffoldBackgroundColor,
//                     //         ),
//                     //         color: blueColor,
//                     //       ),
//                     //       child: Icon(
//                     //         Icons.edit,
//                     //         color: Colors.white,
//                     //       ),
//                     //     )),
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 height: 35,
//               ),
//               buildTextField(username, email, bio),
//               const SizedBox(
//                 height: 35,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   RaisedButton(
//                     onPressed: () {
//                       FirebaseAuth.instance.signOut();
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => LoginScreen()));
//                     },
//                     color: blueColor,
//                     padding: const EdgeInsets.symmetric(horizontal: 50),
//                     elevation: 2,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20)),
//                     child: const Text(
//                       "LOG OUT",
//                       style: const TextStyle(
//                           fontSize: 14,
//                           letterSpacing: 2.2,
//                           color: Colors.white),
//                     ),
//                   )
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildTextField(String myname, String myemail, String mybio) {
//     var h = MediaQuery.of(context).size.height;
//     return Container(
//       height: h / 2.5,
//       // width: size.width,
//       margin: const EdgeInsets.only(top: 10),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(5),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Container(
//           //   margin: EdgeInsets.only(left: 20),
//           //   height: 90,
//           //   width: 30,
//           //   child: Image.asset(img),
//           // ),
//           Container(
//             margin: const EdgeInsets.only(left: 20, top: 10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Container(
//                     margin: const EdgeInsets.only(top: 10),
//                     child: Row(
//                       children: [
//                         const Text(
//                           'Name: ', //Subtitle

//                           style: TextStyle(
//                             color: Color.fromARGB(255, 0, 0, 0),
//                             fontFamily: 'Roboto',
//                             fontSize: 25,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Text(
//                           myname, //Subtitle

//                           style: const TextStyle(
//                             color: Color.fromARGB(255, 0, 0, 0),
//                             fontFamily: 'Roboto',
//                             fontSize: 15,
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                       ],
//                     )),
//                 Container(
//                   margin: const EdgeInsets.only(top: 10),
//                   child: Row(
//                     children: [
//                       const Text(
//                         'Email: ', //Subtitle

//                         style: TextStyle(
//                           color: Color.fromARGB(255, 0, 0, 0),
//                           fontFamily: 'Roboto',
//                           fontSize: 25,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(
//                         myemail, //Subtitle

//                         style: const TextStyle(
//                           color: Color.fromARGB(255, 0, 0, 0),
//                           fontFamily: 'Roboto',
//                           fontSize: 15,
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       width: 1,
//                       color: Color.fromARGB(255, 0, 0, 0),
//                     ),
//                     borderRadius: BorderRadius.all(Radius.circular(5)),
//                   ),
//                   margin: const EdgeInsets.only(top: 10),
//                   child: Row(
//                     children: [
//                       const Text(
//                         'Bio: ', //Subtitle

//                         style: TextStyle(
//                           color: Color.fromARGB(255, 0, 0, 0),
//                           fontFamily: 'Roboto',
//                           fontSize: 25,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(
//                         mybio, //Subtitle

//                         style: const TextStyle(
//                           color: Color.fromARGB(255, 0, 0, 0),
//                           fontFamily: 'Roboto',
//                           fontSize: 20,
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

import 'package:v_care/screens/user/MyProfilePage/user_profile_body.dart';

import '../../../configs/colors.dart';

class ProfileScreen extends StatelessWidget {
  // static String routeName = "/profile";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('User Profile',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16.0)),
        centerTitle: true,
        elevation: 0,
      ),
      body: Body(),
      // bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
    );
  }
}
