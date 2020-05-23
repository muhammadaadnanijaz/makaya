import 'package:flutter/material.dart';
import '../main.dart';
import '../models/listAttributes.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:core';
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';



class WalmartDataParsing {

  String title;
  String price;
  String type;
  String weight;
  String image;
  String size;
  String color;

  FlutterWebviewPlugin fwvp = new FlutterWebviewPlugin();
  static all_listAttributes item;
  String url = "";
  bool parsedSuccess = false;

  Future<bool> viewProduct(String url) async
  {
    var menu = null;
    try {
      print('see url');
      print(url);
      print('see url');

      if (url == null || url == "")
        return false;
      menu = await http.get(url);
      this.url = url;
      var document = parse(menu.body);
      if(parse_page(document, "")==-1){

        return false;

      }else
        return true;


    }
    on Exception catch (e) {
      print("check");
      print(e);
      return false;
    }
    //return menu.body;

  }




  int parse_page(Document document, String type) {
    //get image

    try {
    //For image

        var im = document.getElementsByClassName("hover-zoom-hero-image");

        if(im.length>0){

          image = im[0].attributes['src'];
          if(!image.contains("https:") && !image.contains("http:")){

            image = "http:"+image;

          }

        }
    //For title
        var ti = document.getElementsByClassName("prod-ProductTitle font-normal");

        if(ti.length>0){

          title = ti[0].attributes["content"];

        }
        //For price

        var pr = document.getElementsByClassName("price-characteristic");

        if(pr.length>0){

          price = pr[0].attributes["content"];

        }

        var we = document.getElementById("specifications");

        if(we!=null){

          var we_sub = we.getElementsByTagName("td");
          for(int i=0;i<we_sub.length;i++){

            if(we_sub[i].text.contains("Weight")){

              weight =we_sub[i+1].text;

            }
            
            if(we_sub[i].text.contains("Size")){

              size = we_sub[i+1].text;

            }



          }


        }


        parsedSuccess = true;

        return 1;





    }on Exception catch (e){

      print("error was : ");
      print(e);
      return -1;

    }


  }


  int addTocart(String url) {
    int flag = 0;

    print("teejjj"+this.weight);

    if (!this.weight.contains("ounces")&&!this.weight.contains("pounds"))
      this.weight = "";
    if (this.price.contains("-")) {
      return 3;
    }

    for (int i = 0; i < MyApp.aitems.length; i++)
      if (this.image == MyApp.aitems[i].image) {
        MyApp.aitems[i].quantity++;
        flag = 1;
        return 2;
      }


    all_listAttributes temp = new all_listAttributes(
        this.title,
        this.price,
        this.type,
        1,
        this.weight,
        color,
        this.image,
        "Walmart",
        this.size,
        url);
        MyApp.aitems.add(temp);


    if (flag == 0) {
      print("see data");
      //fwvp.evalJavascript("jQuery('#preloader').remove();");
      return 1;
      //fwvp.reloadUrl(url);
      //fwvp.dispose();

    } else {
      return 0;
    }


/*
    this.title ="";
    this.price = "";
    this.type="";
    this.weight="";
    this.image="";

    parsedSuccess= false;*/

  }

  void reset() {
    this.title = "";
    this.price = "";
    this.type = "";
    this.weight = "";
    this.image = "";
  }

  int addTofav(String url) {
    int flag = 0;
    if (!this.weight.contains("ounces")&&!this.weight.contains("pounds"))
      this.weight = "";
    if (this.price.contains("-")) {
      return 3;
    }

    for (int i = 0; i < MyApp.witems.length; i++)
      if (this.image == MyApp.witems[i].image) {
        MyApp. witems[i].quantity++;
        flag = 1;
        return 2;
      }

    /*MyApp. witems.add(new listAttributes(
        this.title,
        this.price,
        this.type,
        1,
        this.weight,
        this.color,
        this.image,
        "Walmart",
        this.size,
        url));*/


    if (flag == 0) {
      print("see data");
      //fwvp.evalJavascript("jQuery('#preloader').remove();");
      return 1;
      //fwvp.reloadUrl(url);
      //fwvp.dispose();

    } else {
      return 0;
    }
  }


  String getImage() {
    return image;
  }
}
