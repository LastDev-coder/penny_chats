import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penny_chats/ApiService/Apiservice.dart';
import 'package:penny_chats/controllers/colors/colors.dart';

import '../appdrawer.dart';

class contact extends StatefulWidget {
  const contact({Key? key}) : super(key: key);

  @override
  _contactState createState() => _contactState();
}

class _contactState extends State<contact> {
  List<String> _options = ['General', 'Technical Support', 'Advertisement'];
  String _selectedOption = "General";
  final _formKey = GlobalKey<FormState>();
  TextEditingController firstController = TextEditingController();
  TextEditingController lastController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController queryController = TextEditingController();

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
        title: Text("Contact"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("It’s going up for real.",
                    style: TextStyle(
                        color: AppColors.PENNY_TEXT_COLOR,
                        fontFamily: 'Gotham',
                        fontSize: 28,
                        fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.call,
                      size: 35,
                      color: Colors.green,
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Text("Call us :",
                        style: TextStyle(
                            color:Get.isDarkMode ? Colors.white : AppColors.Button_TEXT_COLOR,
                            fontFamily: 'Gotham',
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Contact us",
                    style: TextStyle(
                        color: Get.isDarkMode ? Colors.white : AppColors.Button_TEXT_COLOR,
                        fontFamily: 'Gotham',
                        fontSize: 25,
                        fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, bottom: 10, top: 10, right: 10),
                child: Text("First Name",
                    style: TextStyle(
                        color: Get.isDarkMode ? Colors.white :AppColors.Button_TEXT_COLOR,
                        fontFamily: 'Gotham',
                        fontSize: 15,
                        fontWeight: FontWeight.normal)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  decoration: new BoxDecoration(
                      color: Get.isDarkMode ? Colors.black :AppColors.FORM_CONTAINER,
                      borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(50.0),
                        topRight: const Radius.circular(50.0),
                        bottomLeft: const Radius.circular(50.0),
                        bottomRight: const Radius.circular(50.0),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      controller: firstController,
                      keyboardType: TextInputType.multiline,
                      decoration:
                          new InputDecoration.collapsed(hintText: 'First Name'),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, bottom: 10, top: 10, right: 10),
                child: Text("Last Name",
                    style: TextStyle(
                        color: Get.isDarkMode ? Colors.white :AppColors.Button_TEXT_COLOR,
                        fontFamily: 'Gotham',
                        fontSize: 15,
                        fontWeight: FontWeight.normal)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  decoration: new BoxDecoration(
                      color: Get.isDarkMode ? Colors.black :AppColors.FORM_CONTAINER,
                      borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(50.0),
                        topRight: const Radius.circular(50.0),
                        bottomLeft: const Radius.circular(50.0),
                        bottomRight: const Radius.circular(50.0),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      controller: lastController,
                      keyboardType: TextInputType.multiline,
                      decoration:
                          new InputDecoration.collapsed(hintText: 'Last Name'),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, bottom: 10, top: 10, right: 10),
                child: Text("Email",
                    style: TextStyle(
                        color: Get.isDarkMode ? Colors.white :AppColors.Button_TEXT_COLOR,
                        fontFamily: 'Gotham',
                        fontSize: 15,
                        fontWeight: FontWeight.normal)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  decoration: new BoxDecoration(
                      color: Get.isDarkMode ? Colors.black :AppColors.FORM_CONTAINER,
                      borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(50.0),
                        topRight: const Radius.circular(50.0),
                        bottomLeft: const Radius.circular(50.0),
                        bottomRight: const Radius.circular(50.0),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.multiline,
                      decoration:
                          new InputDecoration.collapsed(hintText: 'Email'),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, bottom: 10, top: 10, right: 10),
                child: Text("Topic",
                    style: TextStyle(
                        color: Get.isDarkMode ? Colors.white :AppColors.Button_TEXT_COLOR,
                        fontFamily: 'Gotham',
                        fontSize: 15,
                        fontWeight: FontWeight.normal)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  width: double.infinity,
                  decoration: new BoxDecoration(
                      color: Get.isDarkMode ? Colors.black :AppColors.FORM_CONTAINER,
                      borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(50.0),
                        topRight: const Radius.circular(50.0),
                        bottomLeft: const Radius.circular(50.0),
                        bottomRight: const Radius.circular(50.0),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        right: 15, left: 15, top: 5, bottom: 5),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        hint: Text("Topic",
                            style: TextStyle(
                                color: AppColors.Button_TEXT_COLOR,
                                fontFamily: 'Gotham',
                                fontSize: 15,
                                fontWeight: FontWeight.normal)),
                        // Not necessary for Option 1
                        value: _selectedOption,
                        onChanged: (value) {
                          setState(() {
                            _selectedOption = value.toString();
                          });
                        },
                        items: _options.map((op) {
                          return DropdownMenuItem(
                            child: new Text(op),
                            value: op,
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, bottom: 10, top: 10, right: 10),
                child: Text("Query",
                    style: TextStyle(
                        color: Get.isDarkMode ? Colors.white :AppColors.Button_TEXT_COLOR,
                        fontFamily: 'Gotham',
                        fontSize: 15,
                        fontWeight: FontWeight.normal)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  decoration: new BoxDecoration(
                      color: Get.isDarkMode ? Colors.black :AppColors.FORM_CONTAINER,
                      borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(5.0),
                        topRight: const Radius.circular(5.0),
                        bottomLeft: const Radius.circular(5.0),
                        bottomRight: const Radius.circular(5.0),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      controller: queryController,
                      maxLines: 10,
                      minLines: 5,
                      keyboardType: TextInputType.multiline,
                      decoration: new InputDecoration.collapsed(
                          hintText: 'Write down your query here...'),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 20, bottom: 20),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      color: AppColors.LOGIN_PAGE_LOGINBOX,
                      onPressed: () async {
                        if (firstController.text.toString() == null ||
                            firstController.text.toString().isEmpty ||
                            firstController.text.toString() == '' ||
                            lastController.text.toString() == null ||
                            lastController.text.toString().isEmpty ||
                            lastController.text.toString() == '' ||
                            emailController.text.toString() == null ||
                            emailController.text.toString().isEmpty ||
                            emailController.text.toString() == '' ||
                            queryController.text.toString() == null ||
                            queryController.text.toString().isEmpty ||
                            queryController.text.toString() == '') {

                          ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                            content: new Text(
                              'All fields should be fill up. Please try again.',
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.red,
                          ));
                        } else {
                          var _data = new Map<String, dynamic>();
                          _data['fname'] = firstController.text.toString();
                          _data['lname'] = lastController.text.toString();
                          _data['email'] = emailController.text.toString();
                          _data['topic'] = _selectedOption;
                          _data['query'] = queryController.text.toString();

                          print(_data);
                          var data = await Apiservice().ContactUs(_data);
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      data['response'].toString(),
                                    style: TextStyle(color: Colors.white),

                                  ),
                                backgroundColor: Colors.green,

                              ));

                          firstController.clear();
                          lastController.clear();
                          emailController.clear();
                          queryController.clear();
                        }
                      },
                      child: Text(
                        'Add Testimonial',
                        style: TextStyle(
                            color: AppColors.white,
                            fontFamily: 'Gotham',
                            fontWeight: FontWeight.bold),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
