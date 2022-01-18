import 'dart:async';
import 'dart:convert';
import 'package:html/parser.dart';
import 'package:divinafm/theme/color_manager.dart';
import 'package:divinafm/services/wpapi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

// ignore: prefer_final_fields
class _HomeState extends State<Home> {
  bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: FutureBuilder(
        future: fetchWpPosts(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                Map wppost = snapshot.data[index];
                var imageurl =
                    wppost['_embedded']['wp:featuredmedia'][0]['source_url'];
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  color: Color(0xffffd15c),
                  margin: EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FadeInImage.assetNetwork(
                              placeholder: 'assets/images/divinafm.png',
                              image: imageurl),
                        ),
                        Text(
                          wppost['title']['rendered'],
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        Text((wppost['excerpt']['rendered']).toString()),
                        RaisedButton(
                            onPressed: () => print('a'),
                            child: Text('read more'),
                            color: Color(0xffff4c60),
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(18.0),
                              side: BorderSide(color: Color(0xff6c6de5)),
                            )),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return Center(
              child: CircularProgressIndicator(
            color: ColorManager.primary,
          ));
        },
      )),
    );
  }
}
