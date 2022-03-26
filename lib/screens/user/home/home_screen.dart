// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'package:v_care/configs/colors.dart';
import 'package:v_care/configs/utils.dart';
import 'package:v_care/screens/user/MyProfilePage/user_profile.dart';
import 'package:v_care/screens/user/features_screen/BMI%20Calculator/bmi_home.dart';
import 'package:v_care/screens/user/features_screen/Covid/covid_home.dart';
import 'package:v_care/screens/user/features_screen/Heart_Rate/heart_home.dart';

import 'package:v_care/screens/user/features_screen/LabReport/lab_report_home.dart';
import 'package:v_care/screens/user/features_screen/SymptomChecker/symptom_check.dart';
import 'package:v_care/screens/user/features_screen/Video%20Meet/meet_home_screen.dart';

import 'package:v_care/screens/user/login_screen.dart';
import 'package:v_care/screens/user/searchDoctor/search_screen.dart';
import 'package:v_care/services/api/healthNews/health_api.dart';
import 'package:v_care/services/api/healthNews/health_model.dart';

import '../../../providers/user_provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  String username = "";
  String email = "";
  String photoUrl = "";
  String bio = "";
  List<NewsApiModel>? newsList;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    getdetails();
    pageController = PageController();
    getNews().then((value) {
      setState(() {
        if (value.isNotEmpty) {
          newsList = value;
          isLoading = false;
        } else {
          print("List is Empty");
        }
      });
    });
    // addData();
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

  // final bmiKey = GlobalKey<NavigatorState>();
  // final symptomKey = GlobalKey<NavigatorState>();
  int _page = 0;
  late PageController pageController; // for tabs animation

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  // void getUsername() async {
  //   DocumentSnapshot snap = await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get();
  //   print('This data: ${snap.data()}');

  //   // setState(() {
  //   //   username = (snap.data() as Map<String, dynamic>)['username'];
  //   // });
  // }

  @override
  Widget build(BuildContext context) {
    // model.User user = Provider.of<UserProvider>(context).getUser;
    return initScreen(context);
  }

  Widget initScreen(context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: blueColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: blueColor,
        centerTitle: true,
        actions: [
          GestureDetector(
            child: Container(
              margin: EdgeInsets.only(right: 10),
              child: IconButton(
                onPressed: () {
                  showSnackBar(context, 'Login as Doctor');
                },
                icon: Icon(
                  Icons.medical_services,
                  color: Colors.white,
                ),
                color: Colors.white,
              ),
            ),
          ),
          GestureDetector(
            child: Container(
              margin: EdgeInsets.only(right: 5),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  photoUrl,
                ),
              ),
            ),
          )
        ],
      ),
      body: PageView(
          controller: pageController,
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: onPageChanged,
          children: [
            // Text('Home'),
            // Text('Symptoms'),
            // Text('BMI Calculator'),
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20, left: 20),
                    child: Text(
                      "Hello $username,",
                      style: TextStyle(
                        color: Color(0xff363636),
                        fontSize: 25,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5, left: 20),
                    child: Text(
                      "Welcome Back",
                      style: TextStyle(
                        color: Color(0xff363636),
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 25, left: 20, right: 20),
                    width: size.width,
                    height: 60,
                    decoration: BoxDecoration(
                      color: blueColor,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x14000000),
                          offset: Offset(0, 10),
                          blurRadius: 15,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Container(
                            margin: EdgeInsets.only(left: 10, right: 10),
                            child: Container(
                              // color: Color(0xff107163),
                              child: Text('Book Doctor Appointment',
                                  style: TextStyle(
                                    color: Color(0xff363636),
                                    fontSize: 20,
                                    fontFamily: 'Roboto',
                                  )),
                            ),
                          ),
                        ),
                        // Expanded(
                        //   flex: 1,
                        //   child: Container(
                        //     decoration: BoxDecoration(
                        //       color: Color(0xff107163),
                        //       borderRadius: BorderRadius.circular(5),
                        //     ),
                        //     child: Center(
                        //       child: Icon(
                        //         Icons.search,
                        //         color: Colors.white,
                        //         size: 25,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  Container(
                    width: size.width,
                    margin: EdgeInsets.only(top: 20, left: 20),
                    child: Stack(
                      fit: StackFit.loose,
                      children: [
                        Container(
                          child: const Text(
                            "What's NEW's?",
                            style: TextStyle(
                              color: Color(0xff363636),
                              fontSize: 20,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 120,
                    margin: EdgeInsets.only(top: 20, left: 20),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Center(
                          child: isLoading
                              ? Container(
                                  height: double.infinity,
                                  width: size.width / 1.2,
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey.shade700,
                                    highlightColor: Colors.grey.shade100,
                                    enabled: true,
                                    child: Column(
                                      children: [
                                        ListTile(
                                          leading: Container(
                                            height: 50,
                                            width: 50,
                                            color: Colors.white,
                                          ),
                                          title: Container(
                                            width: 50,
                                            height: 8.0,
                                            color: Colors.white,
                                          ),
                                          subtitle: Container(
                                            width: 1,
                                            height: 8.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ))
                              : Expanded(
                                  child: Container(
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: newsList!.length,
                                      itemBuilder: (context, index) {
                                        return demoCategories(newsList![index]);
                                      },
                                    ),
                                  ),
                                ),
                        ),
                        // demoCategories(
                        //     "As BA.2 grows in the US, experts look to other countries to predict its impact here",
                        //     "After weeks in free fall, new Covid-19 cases are starting to level off in the US, as the BA.2 subvariant continues its ascent."),
                        // demoCategories("Brain", "15 Doctors"),
                        // demoCategories("Heart", "17 Doctors"),
                        // demoCategories("Bone", "24 Doctors"),
                      ],
                    ),
                  ),
                  Container(
                    width: size.width,
                    margin: EdgeInsets.only(top: 20, left: 20),
                    child: Stack(
                      fit: StackFit.loose,
                      children: [
                        Container(
                          child: Text(
                            'Top Features',
                            style: TextStyle(
                              color: Color(0xff363636),
                              fontSize: 20,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        // GestureDetector(
                        //   onTap: () {},
                        //   child: Container(
                        //     margin: EdgeInsets.only(right: 20, top: 1),
                        //     child: Align(
                        //       alignment: Alignment.centerRight,
                        //       child: Text(
                        //         'See all',
                        //         style: TextStyle(
                        //           color: Color(0xff5e5d5d),
                        //           fontSize: 19,
                        //           fontFamily: 'Roboto',
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: ListView(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BMIScreen()));
                            },
                            child: demoTopRatedDr(
                              "assets/home/bmi.png",
                              "BMI Calculator",
                              "BMI is a measure of body fat based on height and weight",
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SymptomChecker()));
                              // navigatorKey.currentState?.pushAndRemoveUntil(
                              //     MaterialPageRoute(
                              //         builder: (context) => BMIScreen()),
                              //     (Route<dynamic> route) => false);
                              print("Symptom Checker");
                            },
                            child: demoTopRatedDr(
                              "assets/home/download.png",
                              "Symptom Checker",
                              "Find a possible diagnosis by choosing a symptom",
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LabHome()));
                            },
                            child: demoTopRatedDr(
                              "assets/home/lab.png",
                              "Manage LabReports",
                              "Manage your lab reports",
                            ),
                          ),
                          demoTopRatedDr(
                            "assets/home/pill.png",
                            "Medicine Reminder",
                            "Get a medicine reminder by uploading your prescription",
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WorldStates()));
                            },
                            child: demoTopRatedDr(
                              "assets/home/covid.png",
                              "Covid Cases",
                              "Measure of Covid cases in the world",
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HeartHomePage()));
                            },
                            child: demoTopRatedDr(
                              "assets/home/lab.png",
                              "Measure Heart Rate",
                              "Manage your lab reports",
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            // ProfileScreen(),
            ProfileScreen(),
          ]),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: mobileBackgroundColor,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: secondaryColor,
            ),
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: secondaryColor,
              ),
              label: '',
              backgroundColor: primaryColor),
          // BottomNavigationBarItem(
          //     icon: Icon(
          //       Icons.add_circle,
          //       color: secondaryColor,
          //     ),
          //     label: '',
          //     backgroundColor: primaryColor),
          // BottomNavigationBarItem(
          //   icon: Icon(
          //     Icons.favorite,
          //     color: secondaryColor,
          //   ),
          //   label: '',
          //   backgroundColor: primaryColor,
          // ),
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()));
              },
              child: Icon(
                Icons.person,
                color: secondaryColor,
              ),
            ),
            label: '',
            backgroundColor: primaryColor,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MeetHomeScreen()));
        },
        child: Icon(Icons.video_call),
        backgroundColor: primaryColor,
      ),
    );
  }

  Widget demoCategories(NewsApiModel model) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: double.infinity,
      width: size.width / 1.2,
      margin: EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        color: Color(0xff107163),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(5),
            child: Text(
              model.title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 2),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Color(0xffd9fffa).withOpacity(0.07),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              model.description,
              style: TextStyle(
                color: Colors.white,
                fontSize: 8,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget demoTopRatedDr(String img, String name, String subtitle) {
    var size = MediaQuery.of(context).size;

    return Container(
      height: 90,
      // width: size.width,
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 20),
            height: 90,
            width: 30,
            child: Image.asset(img),
          ),
          Container(
            margin: EdgeInsets.only(left: 20, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    name, //Name of feature
                    style: TextStyle(
                      color: Color(0xff363636),
                      fontSize: 17,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      Text(
                        subtitle, //Subtitle

                        style: TextStyle(
                          color: Color(0xffababab),
                          fontFamily: 'Roboto',
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
