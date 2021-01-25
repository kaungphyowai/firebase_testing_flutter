// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class PagePage extends StatefulWidget {
//   @override
//   _PagePageState createState() => _PagePageState();
// }

// class _PagePageState extends State<PagePage> {
//   FirebaseFirestore firestore = FirebaseFirestore.instance;

//   List<DocumentSnapshot> products = []; // stores fetched products

//   bool isLoading = false; // track if products fetching

//   bool hasMore = true; // flag for more products available or not

//   int documentLimit = 7; // documents to be fetched per request

//   DocumentSnapshot
//       lastDocument; // flag for last document from where next 10 records to be fetched

//   ScrollController _scrollController = ScrollController(); //
//   getProducts() async {
//     if (!hasMore) {
//       print('No More Products');
//       return;
//     }
//     if (isLoading) {
//       return;
//     }
//     setState(() {
//       isLoading = true;
//     });
//     QuerySnapshot querySnapshot;
//     if (lastDocument == null) {
//       querySnapshot = await firestore
//           .collection('products')
//           .orderBy('name')
//           .limit(documentLimit)
//           .get();
//     } else {
//       querySnapshot = await firestore
//           .collection('products')
//           .orderBy('name')
//           .startAfterDocument(lastDocument)
//           .limit(documentLimit)
//           .get();
//       print(1);
//     }
//     if (querySnapshot.docs.length < documentLimit) {
//       hasMore = false;
//     }
//     lastDocument = querySnapshot.docs[querySnapshot.docs.length - 1];
//     products.addAll(querySnapshot.docs);
//     setState(() {
//       isLoading = false;
//     });
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getProducts();
//     _scrollController.addListener(() {
//       double maxScroll = _scrollController.position.maxScrollExtent;
//       double currentScroll = _scrollController.position.pixels;
//       double delta = MediaQuery.of(context).size.height * 0.20;
//       if (maxScroll - currentScroll <= delta) {
//         getProducts();
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(children: [
//       Expanded(
//         child: products.length == 0
//             ? Center(
//                 child: Text('No Data...'),
//               )
//             : GridView.builder(
//                 physics: BouncingScrollPhysics(),
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                 ),
//                 controller: _scrollController,
//                 itemCount: products.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     contentPadding: EdgeInsets.all(5),
//                     title: Text(products[index].data()['name'].toString()),
//                     subtitle: Text(products[index].data()['Short'].toString()),
//                   );
//                 },
//               ),
//       ),
//       isLoading
//           ? Container(
//               width: MediaQuery.of(context).size.width,
//               padding: EdgeInsets.all(5),
//               color: Colors.yellowAccent,
//               child: Text(
//                 'Loading',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             )
//           : Container()
//     ]);
//   }
// }

// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_testing_flutter/page.dart';
// import 'package:firebase_testing_flutter/routes.dart';
// import 'package:firebase_testing_flutter/screens/wrapper.dart';
// import 'package:firebase_testing_flutter/service/firebase.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   FirebaseMessaging messaging = FirebaseMessaging.instance;
//   @override
//   void initState() {
//     super.initState();

//     var channel = AndroidNotification(channelId: "123");
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       print('Got a message whilst in the foreground!');
//       print('Message data: ${message.data}  ');

//       if (message.notification != null) {
//         print('Message also contained a notification: ${message.notification}');
//       }
//     });
//   }

//   API api = API();

//   var _selectedIndex = 0;
//   List<Widget> _widgetOptions = [
//     PagePage(),
//     Text("Page 2"),
//   ];
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     FirebaseMessaging message;

//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       print('Got a message whilst in the foreground!');
//       print('Message data: ${message.data}  ');

//       if (message.notification != null) {
//         print('Message also contained a notification: ${message.notification}');
//       }
//     });
//     return StreamProvider(
//       create: (context) => api.streamingAuthState(context),
//       child: MaterialApp(
//         title: "News App",
//         debugShowCheckedModeBanner: false,
//         routes: routes,
//         themeMode: ThemeMode.dark,
//         home: Scaffold(
//           body: _widgetOptions.element  At(_selectedIndex),
//           bottomNavigationBar: BottomNavigationBar(
//             onTap: _onItemTapped,
//             currentIndex: _selectedIndex,
//             items: [
//               BottomNavigationBarItem(
//                   icon: Icon(Icons.ac_unit), title: Text("hll")),
//               BottomNavigationBarItem(
//                   icon: Icon(Icons.ac_unit), title: Text("hll")),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
