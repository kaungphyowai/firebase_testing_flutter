import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_testing_flutter/routes.dart';
import 'package:firebase_testing_flutter/screens/wrapper.dart';
import 'package:firebase_testing_flutter/service/firebase.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  API api = API();
  @override
  Widget build(BuildContext context) {
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
