import 'package:firebase_testing_flutter/screens/detail.dart';
import 'package:firebase_testing_flutter/screens/home.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  Home.routeName: (context) => Home(),
  Detail.routeName: (context) => Detail(),
};
