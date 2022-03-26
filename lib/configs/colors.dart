import 'package:flutter/material.dart';

const mobileBackgroundColor = Colors.white;
const webBackgroundColor = Color.fromRGBO(18, 18, 18, 1);
const mobileSearchColor = Color.fromRGBO(38, 38, 38, 1);
const blueColor = Color.fromARGB(255, 42, 163, 127);
const primaryColor = Colors.black;
const secondaryColor = Colors.grey;
const secondaryBackgroundColor = Colors.black12;
Color kPrimaryColor = Color(0xFF166DE0);
Color kConfirmedColor = Color(0xFFFF1242);
Color kActiveColor = Color(0xFF017BFF);
Color kRecoveredColor = Color(0xFF29A746);
Color kDeathColor = Color(0xFF6D757D);

// LinearGradient kGradientShimmer = LinearGradient(
//   begin: Alignment.centerLeft,
//   end: Alignment.centerRight,
//   List: [
//     Colors.grey[300],
//     Colors.grey[100],
//   ],
// );

RegExp reg = new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
Function mathFunc = (Match match) => '${match[1]}.';
