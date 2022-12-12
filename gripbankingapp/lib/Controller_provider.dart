import 'package:flutter/cupertino.dart';
import 'bankdb.dart';
import 'bankmodel.dart';

class Update extends ChangeNotifier {
List<bank> datas =[];
bool fetching = true;
 void fetch()
 {
   fetching = false;
   notifyListeners();
 }
void getData (Data db)async{
    // db = Data();
    datas = await db.GetCustomersData();
    fetching = false;
      notifyListeners();
  }

}