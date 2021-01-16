import 'package:firebase_testing_flutter/model/news.dart';
import 'package:flutter/material.dart';

class Detail extends StatelessWidget {
  static const String routeName = "/detail";
  @override
  Widget build(BuildContext context) {
    final News thisnew = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail"),
      ),
      body: Column(
        children: [
          Image.asset(thisnew.image),
          Text(
            thisnew.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Text(thisnew.description)
        ],
      ),
    );
  }
}
