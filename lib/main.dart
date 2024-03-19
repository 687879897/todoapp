import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'package:todo1/prvider/language_provider.dart';
import 'package:todo1/prvider/listprovider.dart';
import 'package:todo1/prvider/providerhtem.dart';
import 'package:todo1/splash/splash_screen.dart';
import 'package:todo1/utils/app_theme.dart';
import 'package:todo1/utils/edit_task.dart';
import '../model/model.dart';
import 'auth/login/login.dart';
import 'auth/register/register.dart';
import 'homescreen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: const FirebaseOptions(
      apiKey: "AIzaSyB4URvZGfORhbPABn-akW66mwVn5UNBjtE",
      appId: "todo-37c4c",
      messagingSenderId: "todo-37c4c",
      projectId: "todo-37c4c"));
  await FirebaseFirestore.instance.enableNetwork();

  runApp(
     MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create:(_)=> Listprovider(),
            ),
            ChangeNotifierProvider(
              create:(_)=> Themprovider(),
            ),
            ChangeNotifierProvider(
              create:(_)=> Settingprovider(),
            )

          ],
          child:MyApp()
      ),
  );
}
class MyApp extends StatelessWidget {

  late Themprovider themprovider;
  late Settingprovider provider;
  late Listprovider listprovider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    themprovider = Provider.of(context);
    listprovider= Provider.of(context);
    return MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'), // English
          Locale('ar'),
        ],
        locale: Locale(provider.currentlocal),
        theme: AppTheme.lightthem,
        darkTheme: AppTheme.darkthem,
        themeMode: themprovider.currentmode,
        initialRoute: SplashView.routeName,
        routes: {
          SplashView.routeName:(_)=>const SplashView(),
          Home.routeName:(_)=>const Home(),
          Editetask.routeName:(_)=> Editetask(),
          Register.routeName:(_)=> Register(),
           Login.routeName:(_)=> Login()
        }
    );
  }
}