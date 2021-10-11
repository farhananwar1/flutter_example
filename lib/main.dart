import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_testing_proj/pages/cart.dart';
import 'package:flutter_testing_proj/pages/home.dart';
import 'package:flutter_testing_proj/pages/login.dart';
import 'package:flutter_testing_proj/pages/mobile_detail.dart';
import 'package:flutter_testing_proj/pages/on_boarding.dart';
import 'package:flutter_testing_proj/pages/signup.dart';
import 'package:flutter_testing_proj/pages/upload_file.dart';
import 'package:flutter_testing_proj/widgets/themes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_important_channel', //id
    'High Importance Notification', //title
    'This channel is used for important notifications', //description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(
    RemoteMessage remoteMessage) async {
  await Firebase.initializeApp();
  print("A big message just showed up :  ${remoteMessage.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Demo Dialog Box',
      debugShowCheckedModeBanner: false,
      home: MainStatePage(),
    );
  }
}

class MainStatePage extends StatefulWidget {
  const MainStatePage({Key? key}) : super(key: key);

  @override
  State<MainStatePage> createState() => _MainPageState();
}

class _MainPageState extends State<MainStatePage> {
// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage remoteMessage) {
      RemoteNotification? notification = remoteMessage.notification;
      AndroidNotification? android = remoteMessage.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
                android: AndroidNotificationDetails(
                    channel.id, channel.name, channel.description,
                    color: Colors.blue,
                    playSound: true,
                    icon: '@mipmap/ic_launcher')));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage remoteMessage) {
      print("A new onMessageOpenedApp event was published");
      RemoteNotification? notification = remoteMessage.notification;
      AndroidNotification? android = remoteMessage.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title!),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body!)],
                  ),
                ),
              );
            });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        themeMode: ThemeMode.system,
        theme: MyThemes.lightTheme(context),
        darkTheme: MyThemes.darkTheme(context),
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        routes: {
          "/": (context) => const OnBoarding(),
          "/login": (context) => const Login(),
          "/signup": (context) => const Signup(),
          "/home": (context) => const Home(),
          "/mobiles_detail": (context) => const MobileDetail(),
          "/cart": (context) => const Cart(),
          "/uploadFile": (context) => const UploadFile()
        });
  }
}
