import 'dart:io';

import 'package:flutter/material.dart';
import 'AliExpress/aliExpressParsing.dart';
import 'SplashScreen.dart';
import 'User.dart';
import 'ebay/EbayDataParsing.dart';
import 'models/listAttributes.dart';
import 'login.dart';
import 'nointernet.dart';
import 'amazon/parsing.dart';
import 'amazon/webview.dart';
import 'test.dart';
import 'walmart/WalmartDataParsing.dart';


Future<void> main() async {

  MyApp();
  bool check = await MyApp.checkInternet();


  if(check){

    runApp(
        MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
            ),
            home: SplashScren()));

  }else{

        runApp(
        MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
        ),
        home: NoInternet(null)));


        }


}


class MyApp {


  static Future<bool> checkInternet() async {

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        return true;
      }
    } on SocketException catch (_) {
      print('not connected');
      return false;
    }


  }

  static String base_url = "http://ensorcelldns.com/new_api";
  //static String base_url = "http://192.168.1.7/makaya_api";
  static String url ="";
  static User user ;
  static AmazonDataParsing obj = new AmazonDataParsing();
  static AliExpressDataParsing objAliExpressPrsing = new AliExpressDataParsing();
  static WalmartDataParsing walmart_obj = new WalmartDataParsing();
  static EbayDataParsing ebay_obj = new EbayDataParsing();
  static Color primarycolor = Color.fromRGBO(43, 87, 126, 1);
  static List<all_listAttributes> aitems = new List();
  static List<all_listAttributes> witems = new List();




  static bool enteredProductPage = false;


  static bool _showTitle(String url) {

    bool _nav_visibilty = false;

    int count=0;
    for(int i=0;i<MyApp.url.length;i++){

      if(MyApp.url[i]=="/") count++;

    }

    print(count.toString()+" -- hekiil");
    if(count>7) {
      print(count.toString()+" Not Working");
      _nav_visibilty = true;


    }
    else{
      print(MyApp.url.lastIndexOf("/").toString()+" Working");
      _nav_visibilty = false;
    }

    return _nav_visibilty;

  }

  static void showTitle(String url) {}
  static showProgressDialog(BuildContext context, String title) {
    try {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              content: Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  CircularProgressIndicator(),
                  Padding(padding: EdgeInsets.only(left: 15),),
                  Flexible(
                      flex: 8,
                      child: Text(
                        title,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            );
          });
    } catch (e) {
      print(e.toString());
    }
  }

}


