import 'package:flutter/material.dart';
import 'package:penny_chats/controllers/colors/colors.dart';

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                              'https://image.freepik.com/free-vector/profile-icon-male-avatar-hipster-man-wear-headphones_48369-8728.jpg'),
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
                              'Tanufriya Sakila',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.white,
                                  fontFamily: 'Gotham',
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text(
                                'Real Account',
                                style: TextStyle(
                                    fontSize: 11,
                                    color: AppColors.white,
                                    fontFamily: 'Gotham',
                                    fontWeight: FontWeight.normal),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 5),
                                child: Icon(
                                  Icons.location_on,
                                  size: 16,
                                  color: AppColors.white,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'New York, USA',
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: AppColors.white,
                                      fontFamily: 'Gotham',
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ],
                          ),
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
