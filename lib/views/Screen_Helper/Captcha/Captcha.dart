import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:penny_chats/views/Screens/Auth/login.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class Captcha extends StatefulWidget {
  const Captcha({Key? key}) : super(key: key);

  @override
  _CaptchaState createState() => _CaptchaState();
}
class _CaptchaState extends State<Captcha> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: WebViewPlus(
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (controller){
            controller.loadUrl("assets/webpages/index.html");
          },
          javascriptChannels: Set.from([
            JavascriptChannel(name: 'Captcha', onMessageReceived: (JavascriptMessage message){
              print('-------------- Captcha Message -------------------');
              print(message.message);
              print('--------------------------------------------------');
              Navigator.of(context).pop(false);

            })
          ]),
        )
    );
  }
}
