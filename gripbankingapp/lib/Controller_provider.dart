import 'package:flutter/cupertino.dart';
import 'bankdb.dart';
import 'bankmodel.dart';

class Update extends ChangeNotifier {
List<bank> datas =[];
late Data db;
bool fetching =true;
  void getData ()async{
    datas = await db.GetCustomersData();
      fetching =false;
      notifyListeners();
  }

}