import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:gripbankingapp/Controller/Controller_provider.dart';
import 'package:gripbankingapp/View/customerspage.dart';

import 'package:gripbankingapp/View/splashscreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(  
      MultiProvider(
        providers: [
      ChangeNotifierProvider<Update>(
      create: (_) => Update(),),
        ],

child :MaterialApp(debugShowCheckedModeBanner: false, home: SplashScreen(),

  theme: ThemeData.dark(),)),
      );
}
