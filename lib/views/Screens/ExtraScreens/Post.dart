import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:penny_chats/ApiService/Apiservice.dart';
import 'package:penny_chats/controllers/colors/colors.dart';

import '../appdrawer.dart';

class MyPost extends StatefulWidget {
  const MyPost({Key? key}) : super(key: key);

  @override
  _MyPostState createState() => _MyPostState();
}

class _MyPostState extends State<MyPost> {

  TextEditingController titleController = TextEditingController();
  TextEditingController despController = TextEditingController();

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
        title: Text("Post"),
      ),
      body:  SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 10, bottom: 10, top: 10, right: 10),
              child: Text("Post Title",
                  style: TextStyle(
                      color: AppColors.Button_TEXT_COLOR,
                      fontFamily: 'Gotham',
                      fontSize: 15,
                      fontWeight: FontWeight.normal)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Container(
                decoration: new BoxDecoration(
                    color: AppColors.FORM_CONTAINER,
                    borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(5.0),
                      topRight: const Radius.circular(5.0),
                      bottomLeft: const Radius.circular(5.0),
                      bottomRight: const Radius.circular(5.0),
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                      controller: titleController,
                    maxLines: 3,
                    minLines: 2,
                    keyboardType: TextInputType.multiline,
                    decoration: new InputDecoration.collapsed(
                        hintText: 'Write down your post title here...',

                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 10, bottom: 10, top: 10, right: 10),
              child: Text("Post Description",
                  style: TextStyle(
                      color: AppColors.Button_TEXT_COLOR,
                      fontFamily: 'Gotham',
                      fontSize: 15,
                      fontWeight: FontWeight.normal)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Container(
                decoration: new BoxDecoration(
                    color: AppColors.FORM_CONTAINER,
                    borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(5.0),
                      topRight: const Radius.circular(5.0),
                      bottomLeft: const Radius.circular(5.0),
                      bottomRight: const Radius.circular(5.0),
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    controller: despController,
                    maxLines: 30,
                    minLines: 20,
                    keyboardType: TextInputType.multiline,
                    decoration: new InputDecoration.collapsed(
                        hintText: 'Write down your post description here...'),
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
                      if(titleController.text.toString() == '' || despController.text.toString() == '' ){
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content:
                                Text('Please fill all the blank fields',
                                  style: TextStyle(color: Colors.white),

                                ),
                              backgroundColor: Colors.red,

                            )

                        );
                      }else{
                        var _data = new Map<String, dynamic>();
                        _data['title'] = titleController.text.toString();
                        _data['content'] = despController.text.toString();
                        var data = await Apiservice().UploadPost(_data);
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    data['response'].toString(),
                                  style: TextStyle(color: Colors.white),

                                ),
                              backgroundColor: Colors.green,

                            ));
                        titleController.clear();
                        despController.clear();

                      }
                    },
                    child: Text(
                      'Add Post',
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
    );
  }
}
