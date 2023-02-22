import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hakim_dash/providers/adsProvider.dart';
import 'package:hakim_dash/providers/doctorsProvider.dart';
import 'package:hakim_dash/providers/homeCareProvider.dart';
import 'package:hakim_dash/providers/hospitalProvider.dart';
import 'package:hakim_dash/screens/HomePage.dart';

import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';


void main() {
 runApp(MultiProvider(providers:  [
    ChangeNotifierProvider(create: (context) => DoctorsProvider()),
    ChangeNotifierProvider(create: (context) => HomeCareProvider()),
    ChangeNotifierProvider(create: (context) => HospitalProvider()),
        ChangeNotifierProvider(create: (context) => AdsProvider()),

    // ChangeNotifierProvider(
    //   create: (context) => AuthProvider(),
    // ),
  ],
  child:const MyApp(),)
    
    
    
    
    
    
    
    
     );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        title: '',
          localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('ar'),
        
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
  primaryColor: Color(0xffFCFCFC),
          backgroundColor:Color(0xffFCFCFC),
          
          textTheme: GoogleFonts.tajawalTextTheme(),
         
          canvasColor: Colors.white,scaffoldBackgroundColor: Colors.white
               ),
        home:  HomePage(),
      );
    });
  }
}