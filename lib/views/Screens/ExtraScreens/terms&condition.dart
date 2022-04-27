import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:penny_chats/controllers/colors/colors.dart';

class Terms extends StatefulWidget {
  Terms({Key? key}) : super(key: key);

  @override
  _TermsState createState() => _TermsState();
}

class _TermsState extends State<Terms> {
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
        title: Text('TERMS AND CONDITION'),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context, 'back');
          },
          child: Icon(
            Icons.chevron_left,
            size: 40,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: Get.isDarkMode
                  ? Colors.black12
                  : AppColors.NOTIFICATION_BLACKSHADE,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 30, bottom: 30),
                child: Text('PRIVACY',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 15,
                        color: AppColors.LOGIN_PAGE_LOGINBOX,
                        fontFamily: 'Gotham',
                        fontWeight: FontWeight.bold)),
              ),
            ),
            Container(
              width: double.infinity,
              // color: AppColors.NOTIFICATION_BLACKSHADE,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 10, bottom: 10),
                child: Text(
                    'PennyChats.com collects emails and phone numbers (optional) to communicate with users of PennyChats.com. User information is never shared, sold or released for public use or compensation. PennyChats.com reserves the right , that if we choose to transfer ownership of website, all user information will be transferred to new owner, without notice to its members and/or users. Pennychats.com will not be liable for any actions taken by new owner(s) of PennyChats.com. We highly advise all members and users of PennyChats.com to caution sharing information on site in comments, and messages , we hold no liability to any information willingly and publicly released by users on chat boards and exchanged with users on  PennyChats.com. There maybe cookies and 3rd party companies tracking your ip address and internet behavior due to ads you may have clicked and other website tracking information for statistical purposes.',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 14,
                        color: Get.isDarkMode
                            ? Colors.white
                            : AppColors.LOGIN_PAGE_INPUTBOX_INPUTTEXT,
                        fontFamily: 'Gotham',
                        fontWeight: FontWeight.w400)),
              ),
            ),
            Container(
              width: double.infinity,
              color: Get.isDarkMode
                  ? Colors.black12
                  : AppColors.NOTIFICATION_BLACKSHADE,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 30, bottom: 30),
                child: Text('ADVERTISING',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 15,
                        color: AppColors.LOGIN_PAGE_LOGINBOX,
                        fontFamily: 'Gotham',
                        fontWeight: FontWeight.bold)),
              ),
            ),
            Container(
              width: double.infinity,
              // color: AppColors.NOTIFICATION_BLACKSHADE,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 10, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        'PennyChats.com may advertise businesses that we are compensated for when there is user action with advertisement.PennyChats.com holds no liability for any affiliate products that may be advertised on PennyChats.com or shared on PennyChats.com, nor does PennyChats.com hold accountable the legitimacy and/or accuracy of information displayed by advertisements on PennyChats.com. Make sure to do your own research before taking action with any advertisement.',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 14,
                            color: Get.isDarkMode
                                ? Colors.white
                                : AppColors.LOGIN_PAGE_INPUTBOX_INPUTTEXT,
                            fontFamily: 'Gotham',
                            fontWeight: FontWeight.w400)),
                    SizedBox(height: 10,),
                    Text(
                        'Affiliates',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 14,
                            color: AppColors.LOGIN_PAGE_LOGINBOX,
                            fontFamily: 'Gotham',
                            fontWeight: FontWeight.w400)),
                    SizedBox(height: 10,),

                    Text(
                        'No member of PennyChats.com is allowed to share their user information or affiliate link for others to see the inside of the website, or their dashboard. No member of PennyChats.com can or is allowed to sign-up their self with their own affiliate link, we do track IP addresses, and you will be banned for any misuse of our affiliate program. All affiliate commissions are subject to change with notice. PennyChats.com affiliate program may be terminated at anytime without notice, and if it is terminated, all affiliates payouts will be released, and account canceled. You will receieve an affiliate link once registered. Once someone registers under your affiliate link, your back office will show commissions which will be paid out the same day (excluding affiliate payment fee by merchant).',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 14,
                            color: Get.isDarkMode
                                ? Colors.white
                                : AppColors.LOGIN_PAGE_INPUTBOX_INPUTTEXT,
                            fontFamily: 'Gotham',
                            fontWeight: FontWeight.w400)),
                    SizedBox(height: 10,),

                    Text(
                        'Forum/Chat',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 14,
                            color: AppColors.LOGIN_PAGE_LOGINBOX,
                            fontFamily: 'Gotham',
                            fontWeight: FontWeight.w400)),
                    SizedBox(height: 10,),

                    Text(
                      'Please do not pump dead stocks or stocks that have no significant catalyst that will impact shareholder value in a positive way. Respect other members opinions and knowledge or lack thereof. Zero tolerance for trolling and spamming other users , we want to create a friendly and informative environment. If rules are not followed you can be banned from site indefinitely. ',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 14,
                            color: Get.isDarkMode
                                ? Colors.white
                                : AppColors.LOGIN_PAGE_INPUTBOX_INPUTTEXT,
                            fontFamily: 'Gotham',
                            fontWeight: FontWeight.w400)),
                    SizedBox(height: 10,),

                    Text(
                        'Change Notice',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 14,
                            color: AppColors.LOGIN_PAGE_LOGINBOX,
                            fontFamily: 'Gotham',
                            fontWeight: FontWeight.w400)),
                    SizedBox(height: 10,),

                    Text(
                      'As with any of our administrative and legal notice pages, the contents of this page can and will change over time. Accordingly, this page could read differently as of your very next visit. These changes are necessitated, and carried out by PennyChats.com, in order to protect you and our PennyChats.com website. If this page is important to you, you should check back frequently as no other notice of changed content will be provided either before or after the change takes effect',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 14,
                            color: Get.isDarkMode
                                ? Colors.white
                                : AppColors.LOGIN_PAGE_INPUTBOX_INPUTTEXT,
                            fontFamily: 'Gotham',
                            fontWeight: FontWeight.w400)),
                    SizedBox(height: 20,),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
