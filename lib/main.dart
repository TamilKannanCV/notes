import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:get/get.dart';
import 'package:notes/firebase_options.dart';
import 'package:notes/router/app_router.dart';
import 'package:notes/services/firebase_service.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setUrlStrategy(PathUrlStrategy());

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Get.put(FirebaseAuth.instance);
  Get.put(FirebaseService());
  Get.put(FirebaseFirestore.instance);
  await Get.putAsync<User?>(() async => (await Get.find<FirebaseAuth>().signInAnonymously()).user);
  await Get.putAsync<PackageInfo>(() async => await PackageInfo.fromPlatform());
  Get.lazyPut(() => AppRouter());
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, _, __) {
      return GetMaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          useMaterial3: true,
          colorSchemeSeed: Colors.pink,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          useMaterial3: true,
          colorSchemeSeed: Colors.pink,
        ),
        themeMode: ThemeMode.system,
        routerDelegate: Get.find<AppRouter>().config().routerDelegate,
        routeInformationParser: Get.find<AppRouter>().config().routeInformationParser,
        routeInformationProvider: Get.find<AppRouter>().config().routeInformationProvider,
      );
    });
  }
}
