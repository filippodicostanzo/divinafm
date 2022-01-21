import 'dart:convert';

import 'package:divinafm/enums/connectivy_status.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../theme/color_manager.dart';

class Events extends StatefulWidget {
  const Events({Key? key}) : super(key: key);

  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  bool _loading = true;
  List<dynamic> _events = [];

  @override
  void initState() {
    var _connect = Provider.of<ConnectivityStatus>(context, listen: false);
    // var _connect = Provider.of<ConnectivityStatus>(context);
    super.initState();

    if (_connect.toString() != 'ConnectivityStatus.offline') {
      //if (_connect.toString() != 'ConnectivityStatus.offline') {
      fetch();
    }
    //}
  }

  fetch() async {
    final response = await http.get(Uri.parse(
        'https://php.localidautore.it/facebook_events/?page=costaeventi&count=9'));

    if (response.statusCode == 200) {
      setState(() {
        _loading = false;
        Map<String, dynamic> map = json.decode(response.body);
        _events = map["results"];

        //_events = json.decode(response.body);
        print(_events);
      });
    } else {
      throw Exception('failed to load images');
    }
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
                  itemCount: _events.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      constraints: BoxConstraints.tightFor(height: 150),
                      child: Text(_events[index]['name']),
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
}
