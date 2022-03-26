import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:v_care/screens/user/MyProfilePage/user_profile_menu.dart';
import 'package:v_care/screens/user/login_screen.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String username = "";
  String email = "";
  String photoUrl = "";
  String bio = "";
  @override
  void initState() {
    super.initState();
    getdetails();
  }

  void getdetails() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    print(snap.data());

    if (snap.data() != null) {
      setState(() {
        username = (snap.data() as Map<String, dynamic>)['username'];
        photoUrl = (snap.data() as Map<String, dynamic>)['photoUrl'];
        bio = (snap.data() as Map<String, dynamic>)['bio'];
        email = (snap.data() as Map<String, dynamic>)['email'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          SizedBox(
            height: 115,
            width: 115,
            child: Stack(
              fit: StackFit.expand,
              clipBehavior: Clip.none,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(photoUrl),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          ProfileMenu(
            text: username,
            icon: "assets/icons/User.svg",
            press: () => {},
          ),
          ProfileMenu(
            text: email,
            icon: "assets/icons/Mail.svg",
            press: () {},
          ),
          ProfileMenu(
            text: bio,
            icon: "assets/icons/Chat bubble Icon.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () {
              FirebaseAuth.instance.signOut();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
          ),
        ],
      ),
    );
  }
}
