import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:petcom/cart/cart.dart';
import 'package:petcom/screens/buyer/home.dart';
import 'package:petcom/controllers/bindings/auth_binding.dart';

import 'package:petcom/screens/register.dart';
import 'package:petcom/screens/seller/home.dart';

import 'package:petcom/screens/signin.dart';

Future<void> _bgMsgHandler(message) async {
  await Firebase.initializeApp();
  print("onBackgroundMessage ${message}");
}

void main() async {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  FirebaseMessaging.onBackgroundMessage(_bgMsgHandler);
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: true,
    badge: true,
    carPlay: false,
    criticalAlert: true,
    provisional: true,
    sound: true,
  );
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    Get.snackbar('Notification', '${message}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    configOneSignal();
  }

  void configOneSignal() {
    OneSignal.shared.setAppId("76077b27-f650-4193-baf5-71b671e57c08");

// The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
      print("Accepted permission: $accepted");
    });
  }

  @override
  Widget build(BuildContext context) {
    return KhaltiScope(
      publicKey: "test_public_key_7d62ba946a1d436f9e2eec13fb816c0e",
      builder: (context, navigatorKey) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: navigatorKey,
          localizationsDelegates: const [
            KhaltiLocalizations.delegate,
          ],
          defaultTransition: Transition.rightToLeftWithFade,
          theme: ThemeData(
            textTheme:
                GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
          ),
          initialRoute: '/',
          initialBinding: AuthBinding(),
          getPages: [
            GetPage(name: '/', page: () => const BuyerHomeScreen()),
            GetPage(name: '/seller', page: () => const SellerHomeScreen()),
            GetPage(name: '/signin', page: () => const SignInScreen()),
            GetPage(name: '/register', page: () => const RegisterScreen()),
            GetPage(name: '/cart', page: () => const CartScreen()),
          ],
        );
      },
    );
  }
}
