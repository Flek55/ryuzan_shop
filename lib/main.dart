import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ryozan_shop/scroll_behavior.dart';
import 'package:ryozan_shop/start.dart';
import 'package:ryozan_shop/theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ryozan_shop/db.dart';

import 'api.dart';


Future<void> main() async {
  ///Делает приложение неповоротным на экране
  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: anonKey,
  );

  await ProductInfo.getData();

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
      '/': (context) => const Start(),
    },
  ));
}
