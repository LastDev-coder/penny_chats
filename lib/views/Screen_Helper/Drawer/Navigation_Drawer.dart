import 'package:flutter/material.dart';
import 'package:penny_chats/ApiService/Apiservice.dart';
import 'package:penny_chats/controllers/colors/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
 String name='',image='';


    getprofile() async {
    var data;
    // List<ProfileModel> profilemodel = [];

    data = await Apiservice().getprofile();
    var dataresponse = data["response"];

    if (this.mounted) {
      setState(() {
        name = dataresponse["name"].toString();
        image = dataresponse["profile_pic"].toString();

      });
    }
    // setState(() {
    //
    //
    // });
    print("profile ================ ${name} ");

      // print("profile ================ ${dataresponse["profile_pic"]} ");

    // ProfileModel model = ProfileModel(
    //   dataresponse["id"],
    //   dataresponse["name"],
    //   dataresponse["email"],
    //   dataresponse["email_verified"],
    //   dataresponse["username"],
    //   dataresponse["password"],
    //   dataresponse["profile_pic"],
    //   dataresponse["created"],
    //   dataresponse["modified"],
    //   dataresponse["is_active"],
    //   dataresponse["is_online"],
    //   dataresponse["is_login"],
    // );
    // profilemodel.add(model);
    // print(dataresponse["profile_pic"].toString());
    // return profilemodel;
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    getprofile();
    return SafeArea(
      child: Container(
        width: double.infinity,

        //padding: EdgeInsets.only(top: 50.0),
        child: Stack(
          children: [
            Image.asset(
              'assets/images/menu_bg.png',
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, top: 30),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // height: double.infinity,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(
                             image == '' ?
                             'https://static.wikia.nocookie.net/itstabletoptime/images/b/b5/Default.jpg/revision/latest?cb=20210606184459'
                          : 'https://pennychats.com/pennychatapi/uploads/${image}'
                          ),
                        ),
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
                              '$name',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.white,
                                  fontFamily: 'Gotham',
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          // SizedBox(
                          //   height: 5,
                          // ),
                          // Row(
                          //   children: [
                          //     Text(
                          //       'Real Account',
                          //       style: TextStyle(
                          //           fontSize: 11,
                          //           color: AppColors.white,
                          //           fontFamily: 'Gotham',
                          //           fontWeight: FontWeight.normal),
                          //     ),
                          //     Padding(
                          //       padding:
                          //           const EdgeInsets.only(left: 10, right: 5),
                          //       child: Icon(
                          //         Icons.location_on,
                          //         size: 16,
                          //         color: AppColors.white,
                          //       ),
                          //     ),
                          //     Expanded(
                          //       child: Text(
                          //         'New York, USA',
                          //         style: TextStyle(
                          //             fontSize: 11,
                          //             color: AppColors.white,
                          //             fontFamily: 'Gotham',
                          //             fontWeight: FontWeight.normal),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
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


// class NavigationDrawer extends StatelessWidget {
//  late String name,image;
//   getprofile() async {
//     var data;
//     // List<ProfileModel> profilemodel = [];
//
//     data = await Apiservice().getprofile();
//     var dataresponse = data["response"];
//     name = dataresponse["name"].toString();
//     print("profile ================ ${name} ");
//     // print("profile ================ ${dataresponse["profile_pic"]} ");
//
//     // ProfileModel model = ProfileModel(
//     //   dataresponse["id"],
//     //   dataresponse["name"],
//     //   dataresponse["email"],
//     //   dataresponse["email_verified"],
//     //   dataresponse["username"],
//     //   dataresponse["password"],
//     //   dataresponse["profile_pic"],
//     //   dataresponse["created"],
//     //   dataresponse["modified"],
//     //   dataresponse["is_active"],
//     //   dataresponse["is_online"],
//     //   dataresponse["is_login"],
//     // );
//     // profilemodel.add(model);
//     // print(dataresponse["profile_pic"].toString());
//     // return profilemodel;
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     getprofile();
//     return SafeArea(
//       child: Container(
//         width: double.infinity,
//
//         //padding: EdgeInsets.only(top: 50.0),
//         child: Stack(
//           children: [
//             Image.asset(
//               'assets/images/menu_bg.png',
//               fit: BoxFit.cover,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 30, top: 30),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     // height: double.infinity,
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: AppColors.white,
//                         borderRadius: BorderRadius.circular(100),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(3.0),
//                         child: CircleAvatar(
//                           radius: 25,
//                           backgroundImage: NetworkImage(
//                               'https://image.freepik.com/free-vector/profile-icon-male-avatar-hipster-man-wear-headphones_48369-8728.jpg'),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Container(
//                             width: MediaQuery.of(context).size.width,
//                             child: Text(
//                               '$name',
//                               style: TextStyle(
//                                   fontSize: 16,
//                                   color: AppColors.white,
//                                   fontFamily: 'Gotham',
//                                   fontWeight: FontWeight.w400),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 5,
//                           ),
//                           Row(
//                             children: [
//                               Text(
//                                 'Real Account',
//                                 style: TextStyle(
//                                     fontSize: 11,
//                                     color: AppColors.white,
//                                     fontFamily: 'Gotham',
//                                     fontWeight: FontWeight.normal),
//                               ),
//                               Padding(
//                                 padding:
//                                     const EdgeInsets.only(left: 10, right: 5),
//                                 child: Icon(
//                                   Icons.location_on,
//                                   size: 16,
//                                   color: AppColors.white,
//                                 ),
//                               ),
//                               Expanded(
//                                 child: Text(
//                                   'New York, USA',
//                                   style: TextStyle(
//                                       fontSize: 11,
//                                       color: AppColors.white,
//                                       fontFamily: 'Gotham',
//                                       fontWeight: FontWeight.normal),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
