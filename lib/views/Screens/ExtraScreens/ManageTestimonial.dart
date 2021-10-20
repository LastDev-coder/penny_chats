import 'package:flutter/material.dart';
import 'package:penny_chats/controllers/colors/colors.dart';

import '../appdrawer.dart';

class ManageTestimonial extends StatefulWidget {
  ManageTestimonial({Key? key}) : super(key: key);

  @override
  _ManageTestimonialState createState() => _ManageTestimonialState();
}

class _ManageTestimonialState extends State<ManageTestimonial> {
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
          child: Container(
            height: 300,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Card(
                color: Colors.white70,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: Colors.white,
                        child: TextFormField(
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                              //  isDense: true,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: InputBorder.none),
                          style: TextStyle(
                              color: AppColors.LOGIN_PAGE_INPUTBOX_INPUTTEXT,
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
                            onPressed: () {},
                            child: Text(
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
        ));
  }
}
