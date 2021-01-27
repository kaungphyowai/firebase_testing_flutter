import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_testing_flutter/routes.dart';
import 'package:firebase_testing_flutter/screens/wrapper.dart';
import 'package:firebase_testing_flutter/service/firebase.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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

  String _message = "Genereating Message....";

  String _token = "Genertaing Token.... ";

  @override
  void initState() {
    super.initState();
    messaging.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
    // AndroidNotificationChannel channel = AndroidNotificationChannel(
    //   'high_importance_channel', // id
    //   'High Importance Notifications', // title
    //   'This channel is used for important notifications.', // description
    //   importance: Importance.max,
    // );
    // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    //     FlutterLocalNotificationsPlugin();

    // flutterLocalNotificationsPlugin
    //     .resolvePlatformSpecificImplementation<
    //         AndroidFlutterLocalNotificationsPlugin>()
    //     ?.createNotificationChannel(channel);
    // FirebaseMessaging.onBackgroundMessage((message) {
    //   setState(() {
    //     _message = message.toString();
    //   });
    // });
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   RemoteNotification notification = message.notification;
    //   AndroidNotification android = message.notification?.android;
    //   print("We are inside onmessage");
    //   // If `onMessage` is triggered with a notification, construct our own
    //   // local notification to show to users using the created channel.
    //   if (notification != null && android != null) {
    //     flutterLocalNotificationsPlugin.show(
    //         notification.hashCode,
    //         notification.title,
    //         notification.body,
    //         NotificationDetails(
    //           android: AndroidNotificationDetails(
    //             channel.id,
    //             channel.name,
    //             channel.description,
    //             icon: android?.smallIcon,
    //             // other properties...
    //           ),
    //         ));
    //   }
    // });
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
        setState(() {
          _message = message.notification.toString();
        });
      }
    });
    return StreamProvider(
      create: (context) => api.streamingAuthState(context),
      child: MaterialApp(
        title: "News App",
        debugShowCheckedModeBanner: false,
        routes: routes,
        themeMode: ThemeMode.dark,
        home: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_token),
              Divider(),
              Text(_message),
              RaisedButton(onPressed: () {
                // showNotification();
              })
            ],
          ),
        ),
      ),
    );
  }
}
