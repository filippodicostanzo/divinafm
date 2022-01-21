import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../enums/connectivy_status.dart';
import '../theme/color_manager.dart';

class Infinity extends StatefulWidget {
  const Infinity({Key? key}) : super(key: key);

  @override
  _InfinityState createState() => _InfinityState();
}

class _InfinityState extends State<Infinity> {
  List<dynamic> dogImages = [];
  bool _loading = true;
  int _perPages = 20;
  int _page = 1;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var _connect = Provider.of<ConnectivityStatus>(context, listen: false);
    if (_connect.toString() != 'ConnectivityStatus.offline') {
      fetch();
      _scrollController.addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          if (_page < 10) {
            setState(() {
              _page = _page + 1;
            });
            fetch();
          }
        }
      });
    }
  }

  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var connect = Provider.of<ConnectivityStatus>(context);
    return Scaffold(
      body: connect.toString() == 'ConnectivityStatus.offline'
          ? Center(
              child: Text('No Connection'),
            )
          : _loading == false
              ? ListView.builder(
                  controller: _scrollController,
                  itemCount: dogImages.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      constraints: BoxConstraints.tightFor(height: 150),
                      child: Text(dogImages[index]['title']['rendered']),
                    );
                  },
                )
              : Center(
                  child: CircularProgressIndicator(
                    color: ColorManager.primary,
                  ),
                ),
    );
  }

  fetch() async {
    final response = await http.get(Uri.parse(
        'https://www.divinafm.it/wp-json/wp/v2/posts?per_page=$_perPages&page=$_page&_embed'));

    print(response);

    if (response.statusCode == 200) {
      setState(() {
        _loading = false;
        dogImages = [...dogImages, ...json.decode(response.body)];
      });
    } else {
      throw Exception('failed to load images');
    }
  }
}
