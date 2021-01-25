import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_testing_flutter/data/data.dart';
import 'package:firebase_testing_flutter/model/news.dart';
import 'package:firebase_testing_flutter/screens/detail.dart';
import 'package:firebase_testing_flutter/service/firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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
  Future<void> function() async {
    AndroidNotification(
        priority: AndroidNotificationPriority.highPriority,
        visibility: AndroidNotificationVisibility.public);
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      'This channel is used for important notifications.', // description
      importance: Importance.max,
    );
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;

      // If `onMessage` is triggered with a notification, construct our own
      // local notification to show to users using the created channel.
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                icon: android?.smallIcon,
                // other properties...
              ),
            ));
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    function();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
    return StreamBuilder<RemoteMessage>(
        stream: FirebaseMessaging.onMessage,
        builder: (context, snapshot) {
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
                  child: RaisedButton(
                    onPressed: () {
                      api.uplaodTime(DateTime.now());
                    },
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                    itemCount: todaynews.length,
                    itemBuilder: (BuildContext context, int index) {
                      News thisnew = todaynews[index];
                      return GestureDetector(
                        onTap: () => Navigator.pushNamed(
                            context, Detail.routeName,
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
        });
  }
}
