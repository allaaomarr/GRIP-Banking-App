import 'package:gripbankingapp/transfermodel.dart';
import 'package:gripbankingapp/transfers.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'bankmodel.dart';
class Data {
  List<Map> expectedList = [
    {'name': 'Ray O’Sun', 'balance': 456,  'email': "Ray O’Sun@gmail.com"},
    {'name': 'Lee A. Sun', 'balance': 456,'email': 'Lee A. Sun@gmail.com', },
    {'name': ' Ray Sin','balance': 3243, 'email': ' Ray Sin@gmail.com', },
    {'name': 'Isabelle Ringing', 'balance': 23233, 'email': 'Isabelle Ringing@gmail.com'},
    {'name': 'Eileen Sideways', 'balance': 24646, 'email':'Eileen Sideways @gmail.com'},
    {'name': 'Rita Book', 'balance': 464431416, 'email': 'Rita Book@gmail.com'},
    {'name': 'Paige Turner','balance': 744731416 , 'email': 'Paige Turner@gmail.com'},
    {'name': 'Rhoda Report',  'balance': 347541416,'email': 'Rhoda Report@gmail.com',},
    {'name': ' Augusta Wind', 'balance': 474431416,  'email': ' Augusta Wind@gmail.com'},
    {'name': 'Chris Anthemum','balance': 474631416,'email': 'Chris Anthemum@gmail.com'},
  ];










  Future<Database> createDB() async {
    String dataBasePath = await getDatabasesPath();
    print(dataBasePath);
    String path = join(dataBasePath, 'bank.db');
    print(path);
    return openDatabase(path,
        version: 1,
        onCreate: (Database db, int version) async {
          await db.execute(
              'CREATE TABLE bank(id INTEGER PRIMARY KEY,name TEXT, balance INTEGER,email TEXT)');
          await db.execute(
              'CREATE TABLE track(id INTEGER PRIMARY KEY,amount INTEGER,sender INTEGER,receiver INTEGER)');
        },
        onOpen: (db) => print("table created"));
  }
  Future<Database> createTransferDB() async {
    String dataBasePath = await getDatabasesPath();
    print(dataBasePath);
    String path = join(dataBasePath, 'track.db');
    print(path);
    return openDatabase(path,
        version: 1,
        onCreate: (Database db, int version) async {

          await db.execute(
              'CREATE TABLE track(id INTEGER PRIMARY KEY,amount INTEGER,sender INTEGER,receiver INTEGER)');
        },
        onOpen: (db) => print("table created"));
  }
  AddDB() async {
    var DB = await createDB();
    DB.transaction((txn) async {
      for(int i=0;i<=9;i++) {
        await txn
            .rawInsert(
            'INSERT INTO bank(name,balance,email) VALUES("${expectedList[i]['name']}","${expectedList[i]['balance']}","${expectedList[i]['email']}")')
            .then((value) => print('$value insert to db'));
      };
      List<Map> list2 = await txn.rawQuery('SELECT * FROM bank');
      print(list2);

});

        }
  TransferDB(transfer t) async {
    var DB = await createTransferDB();
    DB.transaction((txn) async {

        await txn
            .rawInsert(
            'INSERT INTO track(amount,sender,receiver) VALUES("${t.amount}","${t.sender}","${t.receiver}")')
            .then((value) => print('$value insert to db'));

      List<Map> list = await txn.rawQuery('SELECT * FROM track');
      print(list);

    });

  }
  Future<List<bank>> GetCustomersData() async{
    var DB = await createDB();
    List<Map<String,Object?>> datas = await DB.query("bank");
    print(datas);
    return
      datas.map((e) => bank.fromMap(e)).toList();
  }

  Future<List<transfer>> GetTransferData() async{
    var DB = await createTransferDB();
    List<Map<String,Object?>> datas = await DB.query("track");
    print(datas);
    return
      datas.map((e) => transfer.fromMap(e)).toList();
  }
  Future<int> updateItem(bank t) async {
    var dbClient = await createDB();
    return await dbClient.update("bank", t.toMap(),
        where: "id = ?", whereArgs: [t.id]);
  }
}