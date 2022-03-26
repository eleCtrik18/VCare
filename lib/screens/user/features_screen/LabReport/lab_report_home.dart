import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:v_care/screens/user/features_screen/LabReport/my_reports.dart';
import 'package:v_care/screens/user/features_screen/LabReport/upload_report.dart';

import '../../../../configs/colors.dart';

class LabHome extends StatefulWidget {
  const LabHome({Key? key}) : super(key: key);

  @override
  State<LabHome> createState() => _LabHomeState();
}

class _LabHomeState extends State<LabHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Manage your Reports',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16.0)),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          RaisedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddPostScreen()));
            },
            child: Text('Upload a Lab Report'),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FeedScreen(
                          uid: FirebaseAuth.instance.currentUser!.uid)));
            },
            child: Text('My Lab Reports'),
          ),
        ]),
      ),
    );
  }
}
