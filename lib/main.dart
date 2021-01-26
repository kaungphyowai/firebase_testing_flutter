import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_testing_flutter/routes.dart';
import 'package:firebase_testing_flutter/screens/wrapper.dart';
import 'package:firebase_testing_flutter/service/firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:overlay_support/overlay_support.dart';

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
    initializePlatformSpecifics() {
      var initializationSettingsAndroid =
          AndroidInitializationSettings('app_notf_icon');
      var initializationSettingsIOS = IOSInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: false,
        onDidReceiveLocalNotification: (id, title, body, payload) async {
          // your call back to the UI
        },
      );
      InitializationSettings initializationSettings = InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIOS);
    }

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        showSimpleNotification(
          Container(child: Text(message.toString())),
          position: NotificationPosition.top,
          duration: Duration(
            minutes: 1,
          ),
        );
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

  Future<void> showNotification() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
    var androidChannelSpecifics = AndroidNotificationDetails(
      'CHANNEL_ID',
      'CHANNEL_NAME',
      "CHANNEL_DESCRIPTION",
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      timeoutAfter: 5000,
      styleInformation: DefaultStyleInformation(true, true),
    );
    var iosChannelSpecifics = IOSNotificationDetails(
      badgeNumber: 0,
      subtitle: "Hello",
    );
    var platformChannelSpecifics = NotificationDetails(
        android: androidChannelSpecifics, iOS: iosChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      'Test Title', // Notification Title
      'Test Body', // Notification Body, set as null to remove the body
      platformChannelSpecifics,
      payload: 'New Payload', // Notification Payload
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider(
      create: (context) => api.streamingAuthState(context),
      child: OverlaySupport(
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
                  showNotification();
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
