import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penny_chats/ApiService/Apiservice.dart';
import 'package:penny_chats/controllers/colors/colors.dart';

import '../appdrawer.dart';

class ManageTestimonial extends StatefulWidget {
  ManageTestimonial({Key? key}) : super(key: key);

  @override
  _ManageTestimonialState createState() => _ManageTestimonialState();
}

class _ManageTestimonialState extends State<ManageTestimonial> {
  TextEditingController textController = TextEditingController();
  String myTestimonial = "null";
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

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
          title: Text("Add Testimonial"),
        ),
        body: Center(
          child: Form(
            key: _formKey,
            child: Container(
              height: 300,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Card(
                  color: Get.isDarkMode ? Colors.white10 :Colors.white70,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color:Get.isDarkMode ? Colors.black : Colors.white,
                          child: TextFormField(
                            controller: textController,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                                //  isDense: true,
                              hintText: "write here...",
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                // focusedBorder: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                  borderSide: BorderSide(color: Colors.transparent)),
                            ),
                            style: TextStyle(
                                color: Get.isDarkMode ? Colors.white : AppColors.LOGIN_PAGE_INPUTBOX_INPUTTEXT,
                                fontFamily: 'Gotham',
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                            maxLines: 20,
                            minLines: 9,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 50,
                          width: 200,
                          child: FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              color: AppColors.LOGIN_PAGE_LOGINBOX,
                              onPressed: () async {
                                if (textController.text.toString() == null ||
                                    textController.text.toString().isEmpty ||
                                    textController.text.toString() == '') {

                                  ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                                    content: new Text(
                                      'Testimonial should not be blanked.',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    backgroundColor: Colors.red,
                                  ));
                                } else {
                                  print("not null --------> " +
                                      textController.text.toString());
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  var data = await Apiservice().postTestimonial(
                                      textController.text.toString());


                                  textController.clear();
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                                    content: new Text(
                                      data["response"].toString(),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    backgroundColor: Colors.green,
                                  ));
                                }
                              },
                              child: _isLoading ? CupertinoActivityIndicator(
                                  animating: true, radius: 13,color: Colors.white,) : Text(
                                'Add Testimonial',
                                style: TextStyle(
                                    color: AppColors.white,
                                    fontFamily: 'Gotham',
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
    );
  }
}
