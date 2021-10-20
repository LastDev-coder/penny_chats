import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:penny_chats/controllers/AppStrings.dart';
import 'package:penny_chats/controllers/Api/Extras/DisclaimerApi.dart';
import 'package:penny_chats/controllers/colors/colors.dart';

import '../appdrawer.dart';

class DisclaimerScreen extends StatefulWidget {
  const DisclaimerScreen({Key? key}) : super(key: key);

  @override
  _DisclaimerScreenState createState() => _DisclaimerScreenState();
}

class _DisclaimerScreenState extends State<DisclaimerScreen> {
  String? _disclaimer;

  @override
  void initState() {
    DisclaimerApi.getDisclaimer(context).then((value) {
      setState(() {
        _disclaimer = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: appdrawer(),
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: true,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    AppColors.REGISTER_PAGE_APPBAR_G1,
                    AppColors.REGISTER_PAGE_APPBAR_G2
                  ])),
        ),
        title: Text("Disclaimer"),
      ),
      body: _disclaimer == null
          ? Center(
          child:
          CupertinoActivityIndicator(animating: true, radius: 15))
          : SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(AppStrings.parseHtmlString(_disclaimer!)),
                  ),
                ),
              ),
            ),
    );
  }
}
