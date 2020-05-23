import 'dart:convert';

import 'package:device_id/device_id.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'Api/Api.dart';
import 'ViewFavItems.dart';
import 'amazon/webview.dart';
import 'main.dart';
import 'amazon/parsing.dart';

class BottomBar extends StatelessWidget {




  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 6.0,
        color: Colors.transparent,
        elevation: 9.0,
        clipBehavior: Clip.antiAlias,
        child: Container(
            height: 65.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0.0),
                    topRight: Radius.circular(0.0)
                ),
                color: MyApp.primarycolor
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      height: 65.0,
                      width: MediaQuery.of(context).size.width ,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[

                       Container(

                          child:Column(

                          children: <Widget>[

                            new IconButton(
                                  icon: new Icon(
                                  Icons.store,
                                  color: Colors.white),
                                  onPressed: (){

                                    Alert(
                                      context: context,
                                      type: AlertType.error,
                                      title: "Sorry!!",
                                      desc: "we'll be adding more stores soon!!",
                                      buttons: [
                                        DialogButton(
                                          child: Text(
                                            "OK",
                                            style: TextStyle(
                                                color: Color(0XFF2B567E), fontSize: 20),
                                          ),
                                          onPressed: () => Navigator.pop(context),
                                          width: 100,
                                        )
                                      ],
                                    ).show();


                              }),
                            new Text("Stores",style: TextStyle(color:Colors.white),)

                          ]
                          ),
                        ),


                          Container(

                            child:Column(

                              children: <Widget>[

                                new IconButton(
                                    icon: new Icon(FontAwesomeIcons.compass,
                                      color: Colors.white,),
                                    onPressed: (){

                                      Navigator.push(
                                          context, MaterialPageRoute(builder: (context) => WebViewAmazon(MyApp.url)));



                                    }),
                                new Text("Recent",style: TextStyle(color:Colors.white),)

                              ],

                            )

                          ),


                          Container(


                            child:Column(

                            children: <Widget>[
                              new IconButton( icon: new Icon(FontAwesomeIcons.heart,color: Colors.white,), onPressed: (){



                                Api.addFav().then((sucess){

                                  print("adding to favorites");
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ViewFavItems()));

                                });



                              }),
                              new Text("Favoraties",style: TextStyle(color:Colors.white),)

                            ],

                          )
                          ),
                                                    Container(

                            child:Column(

                              children: <Widget>[

                                new IconButton(
                                    icon: new Icon(Icons.more_vert,
                                      color: Colors.white,),
                                    onPressed: (){

                                      Navigator.push(
                                          context, MaterialPageRoute(builder: (context) => WebViewAmazon(MyApp.url)));



                                    }),
                                new Text("More",style: TextStyle(color:Colors.white),)

                              ],

                            )

                          ),

                          /*new IconButton(icon: new Icon(Icons.more,color: MyApp.primarycolor,), onPressed: (){


                          }),*/
                        ],
                      )
                  ),

                ]
            )
        )
    );
  }
}