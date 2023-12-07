import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ryozan_shop/forgetpass.dart';
import 'package:ryozan_shop/log.dart';
import 'package:ryozan_shop/register.dart';
import 'package:ryozan_shop/scroll_behavior.dart';
import 'package:ryozan_shop/start.dart';
import 'package:ryozan_shop/theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ryozan_shop/db.dart';

import 'api.dart';
import 'first.dart';
import 'logreg.dart';


Future<void> main() async {
  await Supabase.initialize(
    url: SBData.supabaseUrl,
    anonKey: SBData.anonKey,
  );
  SupabaseClient(SBData.supabaseUrl, SBData.anonKey);


  ///Делает приложение неповоротным на экране
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);


  runApp(MaterialApp(
    scrollBehavior: MyBehavior(),
    theme: theme(),
    builder: EasyLoading.init(),
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => const First(),
      '/home': (context) => const Start(),
      '/logreg': (context) => const LogReg(),
      '/login': (context) => const LoginPage(),
      '/register': (context) => const SignUpPage(),
      '/forpass': (context) => const ForgetPass(),
    },
  ));
}

class CurrentUserData {
  static String email = "";
  static String name = "";
  static String pass = "";
}
