import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import '../../../../configs/colors.dart';

class SymptomChecker extends StatefulWidget {
  const SymptomChecker({Key? key}) : super(key: key);

  @override
  State<SymptomChecker> createState() => _SymptomCheckerState();
}

class _SymptomCheckerState extends State<SymptomChecker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 45),
        child: WebviewScaffold(
          url: 'https://symptomate.com/diagnosis/0',
        ),
      ),
    );
  }
}
