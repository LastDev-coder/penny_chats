import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:penny_chats/controllers/colors/colors.dart';
import 'package:penny_chats/views/Screen_Helper/ChatScreens/chat_member.dart';
import 'package:penny_chats/views/Screen_Helper/ChatScreens/chat_room.dart';

class Chat extends StatefulWidget {
  Chat({Key? key}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> with SingleTickerProviderStateMixin {
  bool isBottomCollapsed = false;
  final Duration duration = const Duration(milliseconds: 300);
  AnimationController? _controller =null;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(vsync: this, duration:duration);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.POST_BACKGROUND_COLOR,
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
                  color: AppColors.POST_TAB_BACKGROUND_COLOR,
                ),
                child: TabBar(
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: AppColors.POST_SELECT_TAB_COLOR,
                  ),
                  unselectedLabelColor: AppColors.POST_SELECT_TAB_COLOR,
                  tabs: [
                    Tab(
                      text: 'MEMBERS',
                    ),
                    Tab(
                      text: 'PERSONAL',
                    ),
                    Tab(
                      text: 'FAVOURITE',
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.red,
                height: double.infinity,
                child: TabBarView(
                  children: [
                    ChatMember(),
                    ChatMember(),
                    ChatMember(),
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

 Widget getFloatingActionButton(){
    return Stack(
      children: [
        AnimatedPositioned(
            duration: duration,
            bottom:isBottomCollapsed?140:20,
            right: 25,
            child: Visibility(
              visible: isBottomCollapsed,
              child: GestureDetector(
                child: Container(
                  height: 30,
                  width: 70,
                  decoration: BoxDecoration(
                    color: Color(0XFFFBC02D),
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
                        ),Text("GAIN",style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.w500),)
                      ],
                    ),
                  ),
                ),


              ),
            )


        ),

        AnimatedPositioned(
          duration: duration,
            bottom:isBottomCollapsed?90:20,
            right: 25,
            child: Visibility(
              visible: isBottomCollapsed,
              child: GestureDetector(
                child: Container(
                  height: 30,
                  width: 70,
                  decoration: BoxDecoration(
                    color: Colors.black54,
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
                        ),Text("POST",style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.w500),)
                      ],
                    ),
                  ),
                ),


              ),
            )


    ),

        Positioned(
          bottom: 20,
          right: 30,
          child: FloatingActionButton(
            backgroundColor: Color(0XFF4CAF50),
            onPressed: () {
              if(_controller!=null) {
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

        // FloatingActionButton.extended(
        //     onPressed: () {
        //
        //       Navigator.push(
        //           context, MaterialPageRoute(builder: (context) => ChatRoom()));
        //     },
        //     label: Text(
        //       'Start Discussion',
        //       style: GoogleFonts.openSans(
        //         color: AppColors.white,
        //         fontSize: 12,
        //         fontWeight: FontWeight.bold,
        //       ),
        //     ),
        //     // icon: const Icon(Icons.thumb_up),
        //     backgroundColor: AppColors.LOGIN_PAGE_LOGINBOX)
      ],
    );


  }


}
