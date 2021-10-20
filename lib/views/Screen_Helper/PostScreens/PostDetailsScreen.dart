import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:penny_chats/controllers/colors/colors.dart';
import 'package:penny_chats/views/Screen_Helper/Profile/PostUserScreen.dart';

class PostDetails extends StatefulWidget {
  final String? name;
  final String? time;
  final String? desc;
  final String? likes;
  final String? comments;
  final String? image;
  final String? postUserId;

  PostDetails(
      {Key? key,
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
  @override
  Widget build(BuildContext context) {
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
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Icon(Icons.share),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
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
                          color: AppColors.POST_TAB_COMMENTS_COLOR,
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
                        Container(
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
                                '${widget.likes} Likes',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.POST_TAB_LIKE_COLOR,
                                    fontFamily: 'Gotham',
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
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
                                '${widget.comments} comments',
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
                        Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: CircleAvatar(
                              radius: 25,
                              backgroundImage: NetworkImage(
                                  'https://image.freepik.com/free-vector/profile-icon-male-avatar-hipster-man-wear-headphones_48369-8728.jpg'),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            // height: 20,
                            margin: EdgeInsets.only(left: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: AppColors.POST_DETAILS_COMMENTBOX,
                            ),

                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: TextFormField(
                                keyboardType: TextInputType.multiline,
                                maxLines: 2,
                                style: TextStyle(
                                    color:
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
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: CircleAvatar(
                              radius: 25,
                              backgroundImage: NetworkImage(
                                  'https://www.shareicon.net/data/512x512/2016/05/24/770117_people_512x512.png'),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Text(
                                    'Pete Park',
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
                                  'A short story is a piece of prose fiction that typically can be read in one sitting and focuses on a self-contained incident or series of linked incidents, with the intent of evoking a single effect or mood.',
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
                                              '30 minutes ago',
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
                                              '15 Likes',
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
                                Container(
                                  margin: EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: AppColors.POST_DETAILS_COMMENTBOX,
                                  ),
                                  width: MediaQuery.of(context).size.width,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    child: TextFormField(
                                      keyboardType: TextInputType.multiline,
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: AppColors
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
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: CircleAvatar(
                              radius: 25,
                              backgroundImage: NetworkImage(
                                  'https://i.pinimg.com/originals/34/f2/50/34f250635ed02218356595ea6d730518.jpg'),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Text(
                                    'Emanuel Fedorov',
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
                                  'A short story is a piece of prose fiction that typically can be read in one sitting and focuses on a self-contained incident or series of linked incidents, with the intent of evoking a single effect or mood.',
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
                                              '30 minutes ago',
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
                                              '15 Likes',
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
                                Container(
                                  margin: EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: AppColors.POST_DETAILS_COMMENTBOX,
                                  ),
                                  width: MediaQuery.of(context).size.width,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    child: TextFormField(
                                      keyboardType: TextInputType.multiline,
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: AppColors
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
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: CircleAvatar(
                              radius: 25,
                              backgroundImage: NetworkImage(
                                  'https://avatarfiles.alphacoders.com/146/thumb-1920-146420.jpg'),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Text(
                                    'Tanufriya Sakila',
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
                                  'A short story is a piece of prose fiction that typically can be read in one sitting and focuses on a self-contained incident or series of linked incidents, with the intent of evoking a single effect or mood.',
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
                                              '30 minutes ago',
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
                                              '15 Likes',
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
                                Container(
                                  margin: EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: AppColors.POST_DETAILS_COMMENTBOX,
                                  ),
                                  width: MediaQuery.of(context).size.width,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    child: TextFormField(
                                      keyboardType: TextInputType.multiline,
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: AppColors
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
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
