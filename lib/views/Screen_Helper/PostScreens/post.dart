import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penny_chats/controllers/colors/colors.dart';
import 'package:penny_chats/views/Screen_Helper/PostScreens/FavouritePostScreen.dart';
import 'package:penny_chats/views/Screen_Helper/PostScreens/LatestPostScreen.dart';
import 'package:penny_chats/views/Screen_Helper/PostScreens/PopularPostScreen.dart';

import '../../../ApiService/Apiservice.dart';
import '../../Screens/mydashboard.dart';

class Post extends StatefulWidget {
  Post({Key? key}) : super(key: key);

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post>  with SingleTickerProviderStateMixin{


  bool isBottomCollapsed = false;
  final Duration duration = const Duration(milliseconds: 300);
  AnimationController? _controller = null;

  Calculate(String stprice, String edprice) {
    double startprice, totalprice;

    totalprice = double.parse(stprice);
    startprice = double.parse(edprice);

    double result = ((startprice - totalprice) / totalprice) * 100;
    String r = "";

    setState(() {
      r = result.toStringAsFixed(2);
    });

    return r;
  }
  TextEditingController titleController = TextEditingController();
  TextEditingController despController = TextEditingController();

  Future<bool> doPost() async {
    String CalculateResult = '';
    TextEditingController spController = TextEditingController();
    TextEditingController epController = TextEditingController();
    final shouldPop = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Manage a post here'),
          content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 0, right: 0),
                          child: Container(
                            decoration: new BoxDecoration(
                                color: AppColors.INPUT_BOX,
                                borderRadius: new BorderRadius.only(
                                  topLeft: const Radius.circular(5.0),
                                  topRight: const Radius.circular(5.0),
                                  bottomLeft: const Radius.circular(5.0),
                                  bottomRight: const Radius.circular(5.0),
                                )),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: TextFormField(
                                controller: spController,
                                keyboardType: TextInputType.multiline,
                                style: TextStyle(color: Colors.black87),
                                decoration: new InputDecoration.collapsed(
                                  hintText: 'Enter post title',
                                  hintStyle:
                                  TextStyle(color: AppColors.FROMTO_TEXT),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 0, right: 0),
                          child: Container(
                            decoration: new BoxDecoration(
                                color: AppColors.INPUT_BOX,
                                borderRadius: new BorderRadius.only(
                                  topLeft: const Radius.circular(5.0),
                                  topRight: const Radius.circular(5.0),
                                  bottomLeft: const Radius.circular(5.0),
                                  bottomRight: const Radius.circular(5.0),
                                )),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: TextFormField(
                                controller: epController,
                                maxLines: 10,
                                minLines: 5,
                                keyboardType: TextInputType.multiline,
                                style: TextStyle(color: Colors.black87),
                                decoration: new InputDecoration.collapsed(
                                  hintText: 'Enter post description...',
                                  hintStyle:
                                  TextStyle(color: AppColors.FROMTO_TEXT),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('$CalculateResult',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontFamily: 'Gotham',
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal)),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FlatButton(
                              color: AppColors.CLEAR_BOX,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              onPressed: () {
                                Navigator.of(context, rootNavigator: true).pop();
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.clear,
                                    color: AppColors.CLEAR_BOXTEXT,
                                    size: 15,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text('Close',
                                      style: TextStyle(
                                          color: AppColors.CLEAR_BOXTEXT,
                                          fontFamily: 'Gotham',
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal)),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            FlatButton(
                              // onPressed: () => exit(0),
                              color: AppColors.RESULT_TEXT,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              onPressed: () async {
                                if (spController.text.toString().isEmpty ||
                                    spController.text.toString() == ' ' ||
                                    epController.text.toString().isEmpty ||
                                    epController.text.toString() == ' ') {
                                  setState(() {
                                    CalculateResult =
                                    "Fields should not be blanked";
                                  });
                                } else {
                                  var _data = new Map<String, dynamic>();
                                  _data['title'] = spController.text.toString();
                                  _data['content'] = epController.text.toString();
                                  var data = await Apiservice().UploadPost(_data);

                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                      data['response'].toString(),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    backgroundColor: Colors.green,
                                  ));
                                  Navigator.of(context, rootNavigator: true).pop();

                                  spController.clear();
                                  epController.clear();
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Mydashboard(
                                            number: 3,
                                          )));
                                }
                              },
                              child: Text('Post',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Gotham',
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
        );
      },
    );

    return shouldPop ?? false;
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.POST_BACKGROUND_COLOR,
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 20, bottom: 20),
              child: Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Get.isDarkMode
                      ? Colors.white24
                      : AppColors.POST_TAB_BACKGROUND_COLOR,
                ),
                child: TabBar(
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: AppColors.POST_SELECT_TAB_COLOR,
                  ),
                  unselectedLabelColor: AppColors.POST_SELECT_TAB_COLOR,
                  tabs: [
                    Tab(
                      text: 'LATEST',
                    ),
                    Tab(
                      text: 'POPULAR',
                    ),
                    Tab(
                      text: 'FAVOURITE',
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: double.infinity,
                child: TabBarView(
                  children: [
                    LatestPostScreen(),
                    PopularPostScreen(),
                    FavouritePostScreen(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: getFloatingActionButton(),
      ),
    );
  }
  Widget getFloatingActionButton() {
    return Stack(
      children: [
        AnimatedPositioned(
            duration: duration,
            bottom: isBottomCollapsed ? 90 : 20,
            right: 25,
            child: Visibility(
              visible: isBottomCollapsed,
              child: GestureDetector(
                onTap: () {
                  doPost();
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => MyPost()));
                },
                child: Container(
                  height: 30,
                  width: 70,
                  decoration: BoxDecoration(
                    color: Get.isDarkMode ? Colors.white38 : Colors.black54,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          size: 20,
                          color: Colors.white,
                        ),
                        Text(
                          "POST",
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )),
        Positioned(
          bottom: 20,
          right: 30,
          child: FloatingActionButton(
            backgroundColor: Color(0XFF4CAF50),
            onPressed: () {
              if (_controller != null) {
                setState(() {
                  isBottomCollapsed = !isBottomCollapsed;
                  isBottomCollapsed
                      ? _controller!.forward()
                      : _controller!.reverse();
                });
              }
            },
            child: RotationTransition(
              turns: Tween(begin: 0.0, end: .1).animate(_controller!),
              child: Icon(Icons.add),
            ),
          ),
        ),
      ],
    );
  }

}
