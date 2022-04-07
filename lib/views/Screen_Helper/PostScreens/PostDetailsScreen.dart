import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:penny_chats/ApiService/Apiservice.dart';
import 'package:penny_chats/controllers/colors/colors.dart';
import 'package:penny_chats/models/PostDetailsModel.dart';
import 'package:penny_chats/views/Screen_Helper/Profile/PostUserScreen.dart';
import 'package:share_plus/share_plus.dart';

class PostDetails extends StatefulWidget {
  final String? id;
  final String? name;
  final String? time;
  final String? desc;
  final String? likes;
  final String? comments;
  final String? image;
  final String? postUserId;

  PostDetails(
      {Key? key,
        this.id,
        this.name,
      this.time,
      this.likes,
      this.comments,
      this.image,
      this.desc,
      this.postUserId})
      : super(key: key);

  @override
  _PostDetailsState createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  TextEditingController textController = TextEditingController();
 String postLikes ="0", postComment="0";
  String isLike="true";

  makelike(String postid) async {
    print(postid);
   var data = await Apiservice().getlike(postid);
    if(data["status"]==true){
      isLike = "true";
    }else {
      isLike = "false";
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'You liked this post')));
    print(data);
    print("post id -> $postid , like -> $isLike");

  }
  MyComment(String postId, String comment) async {
    var _data = new Map<String, dynamic>();
    _data['post_id'] = postId;
    _data['comment'] = comment;

    print(_data);

    var data = await Apiservice().PostComment(_data);
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
            Text(data["response"].toString())));
    // Navigator.of(context).pop();
  }

PostDetail() async {
  List<PostDetailsModel> postmodel = [];

  var data = await Apiservice().getPostDetails(widget.id.toString());

  var commentdata = data["response"]["comment"];
  // name = data["response"]["name"];
  print(commentdata);
int i =0;

  for (var x in data["response"]["comment"]) {
    // date = getFormattedDate(dataresponse[i]["created"]);

    PostDetailsModel model = PostDetailsModel(
        data["response"]["comment"][i]["id"],
        data["response"]["comment"][i]["post_id"],
        data["response"]["comment"][i]["user_id"],
        data["response"]["comment"][i]["comment"],
        data["response"]["comment"][i]["created"],
        data["response"]["comment"][i]["modified"],
        data["response"]["comment"][i]["is_active"],
        data["response"]["comment"][i]["name"],
        data["response"]["comment"][i]["profile_pic"] );
    postmodel.add(model);
    i++;
  }
    postLikes = data["response"]["comments"].toString();
    postComment = data["response"]["favourites"].toString();
    print("likes -> $postLikes  comment -> $postComment");
  return postmodel;
}

  Future<bool> ShowProfile(String userId) async {

  var  data = await Apiservice().getOthersprofile(userId);
    var dataresponse = data["response"];
    print("profile ================ $dataresponse ");

    final shouldPop = await showDialog(
      context: context,

      builder: (context) {
        return AlertDialog(
          // title: Text('Percent gain calculator'),
          content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  // color: Colors.red,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 100,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  data["response"]['profile_pic'].toString()==''?
                                  'https://static.wikia.nocookie.net/itstabletoptime/images/b/b5/Default.jpg/revision/latest?cb=20210606184459'

                                      : 'https://pennychats.com/pennychatapi/uploads/${data["response"]['profile_pic'].toString()}'),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.supervised_user_circle_sharp,size: 20,
                            color: Get.isDarkMode ? Colors.white70 : Colors.black,
                            ),
                            SizedBox(width: 10,),
                            Text(
                              'Name :',
                              style: TextStyle(
                                  color: Get.isDarkMode ? Colors.white70 :Colors.black,
                                  fontFamily: 'Gotham',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(width: 10,),
                            Text(
                              data["response"]["name"].toString(),
                              style: TextStyle(
                                  color:Get.isDarkMode ? Colors.white70 : Colors.black,
                                  fontFamily: 'Gotham',
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.email_rounded,size: 20,
                            color: Get.isDarkMode ? Colors.white70 : Colors.black,
                            ),
                            SizedBox(width: 10,),
                            Text(
                              'Email Id :',
                              style: TextStyle(
                                  color: Get.isDarkMode ? Colors.white70 : Colors.black,
                                  fontFamily: 'Gotham',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              child: Text(
                                data["response"]["email"].toString(),
                                style: TextStyle(
                                    color: Get.isDarkMode ? Colors.white70 : Colors.black,
                                    fontFamily: 'Gotham',
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ],
                        )

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
    PostDetail();
  }

  @override
  Widget build(BuildContext context) {
      postComment = widget.comments.toString();
      postLikes = widget.likes.toString();
    return Scaffold(
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
        title: Text('POST DETAILS'),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context, 'back');
          },
          child: Icon(
            Icons.close,
            size: 30,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: (){
              Share.share('PennyChats post by ${widget.name}\n\n ${widget.desc}', subject: '${widget.desc}');
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Icon(Icons.share),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PostUserScreen(
                                        postUserId: widget.postUserId,
                                      )));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: CircleAvatar(
                            radius: 25,
                            backgroundImage: widget.image == ''
                                ? NetworkImage(
                                    'https://image.freepik.com/free-vector/profile-icon-male-avatar-hipster-man-wear-headphones_48369-8728.jpg')
                                : NetworkImage(
                                    'https://www.pennychats.com/uploads/profile_pictures/${widget.image}'),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'By',
                      style: TextStyle(
                          fontSize: 13,
                          color: AppColors.FORGOT_PAGE_INPUT_TEXT,
                          fontFamily: 'Gotham',
                          fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: Text(
                        widget.name.toString(),
                        style: TextStyle(
                            fontSize: 13,
                            color: AppColors.LOGIN_PAGE_LOGINBOX,
                            fontFamily: 'Gotham',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 15),
                      child: VerticalDivider(
                        thickness: 1,
                        width: 10,
                        color: AppColors.POST_TAB_FAVOURITE_TIME_COLOR,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SvgPicture.asset(
                      'assets/icon/clock.svg',
                      color: AppColors.POST_TAB_FAVOURITE_TIME_COLOR,
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Text(
                          widget.time.toString(),
                          style: TextStyle(
                              color:
                                  AppColors.POST_TAB_FAVOURITE_TIME_COLOR,
                              fontFamily: 'Gotham',
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Text(
                widget.desc.toString(),
                style: TextStyle(
                    fontSize: 14,
                    color: Get.isDarkMode ? Colors.white38 : AppColors.POST_TAB_COMMENTS_COLOR,
                    fontFamily: 'Gotham',
                    fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Divider(
                thickness: 1,
                color: AppColors.POST_TAB_FAVOURITE_TIME_COLOR,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      makelike(widget.id.toString());

                    },
                    child: Container(
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icon/heart.svg',
                            height: 20,
                            color: AppColors.POST_TAB_LIKE_COLOR,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            (postLikes=="0" ||postLikes=="1") ? '${postLikes} Like' :   '${postLikes} Likes',
                            style: TextStyle(
                                fontSize: 12,
                                color: AppColors.POST_TAB_LIKE_COLOR,
                                fontFamily: 'Gotham',
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icon/chat.svg',
                          height: 20,
                          color: AppColors.POST_TAB_LIKE_COLOR,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          (postComment=="0" || postComment=="1")?'${postComment} comment':    '${postComment} comments',
                          style: TextStyle(
                              fontSize: 12,
                              color: AppColors.POST_TAB_LIKE_COLOR,
                              fontFamily: 'Gotham',
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/icon/elipsis.svg',
                    height: 20,
                    color: AppColors.POST_TAB_LIKE_COLOR,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Divider(
                thickness: 1,
                color: AppColors.POST_TAB_FAVOURITE_TIME_COLOR,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
              ),
              child: Row(
                children: [
                  // Card(
                  //   elevation: 2,
                  //   shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(50)),
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(2.0),
                  //     child: CircleAvatar(
                  //       radius: 25,
                  //       backgroundImage: NetworkImage(
                  //           'https://image.freepik.com/free-vector/profile-icon-male-avatar-hipster-man-wear-headphones_48369-8728.jpg'),
                  //     ),
                  //   ),
                  // ),
                  Expanded(
                    child: Container(
                      // height: 20,
                      margin: EdgeInsets.only(left: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Get.isDarkMode
                            ?Colors.black:AppColors.POST_DETAILS_COMMENTBOX,
                      ),

                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: TextFormField(
                          keyboardType: TextInputType.multiline,
                          controller: textController,
                          maxLines: 2,
                          style: TextStyle(
                              color:Get.isDarkMode
                                  ?Colors.white:
                                  AppColors.LOGIN_PAGE_INPUTBOX_INPUTTEXT,
                              fontFamily: 'Gotham',
                              fontSize: 11,
                              fontWeight: FontWeight.w400),
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintText: 'Write your comments',
                              hintStyle: TextStyle(
                                fontSize: 11.0,
                                color: AppColors
                                    .POST_DETAILS_COMMENTBOX_HINT,
                                fontWeight: FontWeight.w500,
                              )),
                          validator: (value) {},
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 5,),
                  Container(
                    height: 40,
                      width: 40,

                      child: RaisedButton(
                        // textColor: Colors.white,
                        color: AppColors
                            .POST_DETAILS_ICONCOLOR,
                        child: Icon(Icons.send, size: 15,color: Colors.white,),
                        onPressed: () async {
                          if(textController.text.isNotEmpty && textController.text.toString() !=''){
                        await    MyComment(widget.id.toString(),textController.text.toString());
                        textController.clear();

                        Navigator.of(context).pop();
                            Navigator.of(context).push(new MaterialPageRoute(builder: (context) => PostDetails(
                              id: widget.id,
                              name: widget.name,
                              time: widget.time,
                              desc: widget.desc,
                              likes: widget.likes,
                              comments: postComment,
                              image: widget.image,
                              postUserId: widget.postUserId,
                            )));
                          }

                        },
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(100.0),
                        ),
                      )

                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Divider(
                thickness: 1,
                color: AppColors.POST_TAB_FAVOURITE_TIME_COLOR,
              ),
            ),

            FutureBuilder(
              future: PostDetail(),
              // initialData: InitialData,
              builder:
                  (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.data == null) {
                  return Container(
                    child: Center(
                        child: CupertinoActivityIndicator(
                            animating: true, radius: 15)),
                  );
                } else {
                  return  snapshot.data.length.toString() != "0" || snapshot.data.length.toString() != "null" ?
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int i) {
                      postComment = snapshot.data.length.toString();
                      print(postComment);

                      return Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap:(){
                                ShowProfile(snapshot.data[i].user_id);
                              },
                              child: Card(
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: CircleAvatar(
                                    radius: 25,
                                    backgroundImage: NetworkImage(
                                        'https://www.pennychats.com/beta/uploads/profile_pictures/${snapshot.data[i].profile_pic}'),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Text(
                                        '${snapshot.data[i].name}',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: AppColors.LOGIN_PAGE_LOGINBOX,
                                            fontFamily: 'Gotham',
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      '${snapshot.data[i].comment}',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: AppColors.POST_TAB_COMMENTS_COLOR,
                                          fontFamily: 'Gotham',
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 15, top: 10, bottom: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                'assets/icon/clock.svg',
                                                color: AppColors
                                                    .POST_DETAILS_ICONCOLOR,
                                                height: 15,
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets.only(left: 5),
                                                child: Text(
                                                  '${snapshot.data[i].created}',
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .POST_DETAILS_ICONTEXT,
                                                      fontFamily: 'Gotham',
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w400),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                'assets/icon/heart.svg',
                                                color: AppColors
                                                    .POST_DETAILS_ICONCOLOR,
                                                height: 15,
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets.only(left: 5),
                                                child: Text(
                                                  (postLikes=="0" || postLikes == "1") ? '${postLikes} Like':'${postLikes} Likes',
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .POST_DETAILS_ICONTEXT,
                                                      fontFamily: 'Gotham',
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w400),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                'assets/icon/reply.svg',
                                                color: AppColors
                                                    .POST_DETAILS_ICONCOLOR,
                                                height: 25,
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets.only(left: 5),
                                                child: Text(
                                                  'Reply',
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .POST_DETAILS_ICONTEXT,
                                                      fontFamily: 'Gotham',
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w400),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.only(right: 10),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10.0),
                                              color: Get.isDarkMode ? Colors.black : AppColors.POST_DETAILS_COMMENTBOX,
                                            ),
                                            width: MediaQuery.of(context).size.width,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8, right: 8),
                                              child: TextFormField(
                                                keyboardType: TextInputType.multiline,
                                                maxLines: 1,
                                                style: TextStyle(
                                                    color: Get.isDarkMode
                                                        ?Colors.white:AppColors
                                                        .LOGIN_PAGE_INPUTBOX_INPUTTEXT,
                                                    fontFamily: 'Gotham',
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w400),
                                                decoration: const InputDecoration(
                                                  border: InputBorder.none,
                                                  focusedBorder: InputBorder.none,
                                                  enabledBorder: InputBorder.none,
                                                  errorBorder: InputBorder.none,
                                                  disabledBorder: InputBorder.none,
                                                  hintText: 'Write your comments',
                                                  hintStyle: TextStyle(
                                                    fontSize: 11.0,
                                                    color: AppColors
                                                        .POST_DETAILS_COMMENTBOX_HINT,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                validator: (value) {},
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                            height: 40,
                                            width: 40,

                                            child: RaisedButton(
                                              // textColor: Colors.white,
                                              color: AppColors
                                                  .POST_DETAILS_ICONCOLOR,
                                              child: Icon(Icons.send, size: 15,color: Colors.white,),
                                              onPressed: () async {
                                                // if(textController.text.isNotEmpty && textController.text.toString() !=''){
                                                //   textController.clear();
                                                //   await    MyComment(widget.id.toString(),textController.text.toString());
                                                //   Navigator.of(context).pop();
                                                //   Navigator.of(context).push(new MaterialPageRoute(builder: (context) => PostDetails(
                                                //     id: widget.id,
                                                //     name: widget.name,
                                                //     time: widget.time,
                                                //     desc: widget.desc,
                                                //     likes: widget.likes,
                                                //     comments: widget.comments,
                                                //     image: widget.image,
                                                //     postUserId: widget.postUserId,
                                                //   )));
                                                // }

                                              },
                                              shape: new RoundedRectangleBorder(
                                                borderRadius: new BorderRadius.circular(100.0),
                                              ),
                                            )

                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      );

                    },
                  ) : Container();
                }
              },
            ),

          ],
        ),
      ),
    );
  }


}
