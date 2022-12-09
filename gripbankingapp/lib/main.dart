import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:gripbankingapp/Controller_provider.dart';
import 'package:gripbankingapp/choosecustomer.dart';
import 'package:gripbankingapp/customerspage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp( GetMaterialApp(debugShowCheckedModeBanner: false,home: ChangeNotifierProvider<Update>(
    create: (_) => Update(),
    child: customerspage(),
  )
  ,theme: ThemeData.dark(),));
}
