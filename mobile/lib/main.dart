import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:PetRoulette/pages/main_page.dart';
import 'package:PetRoulette/provider/feedback_position_provider.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.red.shade400,
      
      ),
    );
    return ChangeNotifierProvider(
      create: (context) => FeedbackPositionProvider(),
      child: MaterialApp(
        title: 'PetRoulette',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
          accentColor: Colors.red,
          appBarTheme: AppBarTheme(color: Colors.transparent, elevation: 0),
          scaffoldBackgroundColor: Colors.red.shade400,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MainPage(),
      ),
    );
  }
}

 class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
