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
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  @override
  void initState() {
    super.initState();

    var channel = AndroidNotification(channelId: "123");
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}  ');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }

  API api = API();

  @override
  Widget build(BuildContext context) {
    FirebaseMessaging message;
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}  ');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
    return StreamProvider(
      create: (context) => api.streamingAuthState(context),
      child: MaterialApp(
        title: "News App",
        debugShowCheckedModeBanner: false,
        routes: routes,
        themeMode: ThemeMode.dark,
        home: Wrapper(),
      ),
    );
  }
}
