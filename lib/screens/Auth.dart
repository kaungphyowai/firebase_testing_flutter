import 'package:firebase_testing_flutter/service/firebase.dart';
import 'package:flutter/material.dart';

class Auth extends StatelessWidget {
  API _api = API();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () => _api.signInanony(),
        ),
      ),
    );
  }
}
