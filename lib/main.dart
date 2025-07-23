import 'package:easy_localization/easy_localization.dart';
import 'package:final_q/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'core/helper/language_helper.dart';
import 'core/helper/shared_preferences_helper.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesHelper.instance.init();
  await EasyLocalization.ensureInitialized();

  runApp( EasyLocalization(
    supportedLocales: [Locale('en'), Locale('ar')],
    path: 'assets/langs',
    fallbackLocale: Locale('en'),
    startLocale: await LanguageHelper.getSavedLocale(),

    child: MyApp(),
  ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
 debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
      ),
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
      home: SplashScreen()
    );
  }
}

