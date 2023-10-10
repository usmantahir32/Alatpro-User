import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:services_finder/utils/size_config.dart';
import 'package:services_finder/views/pages/splash/splash.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart' as fcm;

Future<void> _firebaseMessagingBackgroundHandler(
    fcm.RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

void main() async {
 
  //BISMILLAH
  
 
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
   await EasyLocalization.ensureInitialized();
  
  fcm.FirebaseMessaging messaging = fcm.FirebaseMessaging.instance;
  fcm.NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  print('User granted permission: ${settings.authorizationStatus}');
  fcm.FirebaseMessaging.onBackgroundMessage(
      _firebaseMessagingBackgroundHandler);

  fcm.FirebaseMessaging.onMessage.listen((fcm.RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
  runApp(
    EasyLocalization(
        fallbackLocale: const Locale('id', 'IN'),
        child: const MyApp(),
        supportedLocales: const [
          Locale("en", "US"),
          Locale("id", "IN"),
        ],
        path: "assets/localization"),
  );
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return GetMaterialApp(
              locale: Get.deviceLocale,
              supportedLocales: context.supportedLocales,
              localizationsDelegates: context.localizationDelegates,
              theme: ThemeData(
                scaffoldBackgroundColor: Colors.white,
                fontFamily: 'OpenSans',
              ),
              debugShowCheckedModeBanner: false,
              home: const SplashPage(),
            );
          },
        );
      },
    );
  }
}
