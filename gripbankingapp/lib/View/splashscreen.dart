import 'package:flutter/material.dart';
import 'package:gripbankingapp/View/customerspage.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../Controller/bankdb.dart';
import '../bankmodel.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {
  List<bank> datas = [];

  bool fetching = true;
  late Data db;
  @override
  void initState() {
    super.initState();
    db = Data();
    db.AddDB();


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          SizedBox(height: MediaQuery.of(context).size.height / 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: LinearPercentIndicator(
              animation: true,
              lineHeight: 7.0,
              animationDuration: 2500,
              percent: 1,
              barRadius: const Radius.circular(50),
              progressColor: Colors.yellow,
              onAnimationEnd: () {

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => customerspage(),
                  ),
                      (Route<dynamic> route) => false,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}