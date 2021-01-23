import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_testing_flutter/data/data.dart';
import 'package:firebase_testing_flutter/model/message.dart';
import 'package:firebase_testing_flutter/model/news.dart';
import 'package:firebase_testing_flutter/screens/detail.dart';
import 'package:firebase_testing_flutter/service/firebase.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  static String routeName = "/home";
  Home({
    Key key,
  }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final API api = API();
  final List<Message> messages = [];
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News"),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                api.signOut();
              })
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemCount: todaynews.length,
              itemBuilder: (BuildContext context, int index) {
                News thisnew = todaynews[index];
                return GestureDetector(
                  onTap: () => Navigator.pushNamed(context, Detail.routeName,
                      arguments: thisnew),
                  child: ListTile(
                    title: Text(thisnew.title),
                    leading: Image.asset(thisnew.image),
                    subtitle: Text(thisnew.description),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
