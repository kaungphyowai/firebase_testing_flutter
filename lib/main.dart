import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_testing_flutter/routes.dart';
import 'package:firebase_testing_flutter/screens/wrapper.dart';
import 'package:firebase_testing_flutter/service/firebase.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  API api = API();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  String _message = "Genereating Message....";

  String _token = "Genertaing Token.... ";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        setState(() {
          _message = message.toString();
        });
      },
      // onBackgroundMessage: (Map<String, dynamic> message) async {
      //   setState(() {
      //     _message = message.toString();
      //   });
      // },

      onLaunch: (Map<String, dynamic> message) async {
        setState(() {
          _message = message.toString();
        });
      },
      onResume: (Map<String, dynamic> message) async {
        setState(() {
          _message = message.toString();
        });
      },
    );
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      setState(() {
        _token = token.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider(
      create: (context) => api.streamingAuthState(context),
      child: MaterialApp(
        title: "News App",
        debugShowCheckedModeBanner: false,
        routes: routes,
        themeMode: ThemeMode.dark,
        home: Scaffold(
          body: Column(
            children: [
              Text(_token),
              Divider(),
              Text(_message),
            ],
          ),
        ),
      ),
    );
  }
}
