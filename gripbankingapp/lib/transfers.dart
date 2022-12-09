import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gripbankingapp/transfermodel.dart';

import 'bankdb.dart';

class Transfer extends StatefulWidget {
  const Transfer({Key? key}) : super(key: key);

  @override
  State<Transfer> createState() => _TransferState();
}

class _TransferState extends State<Transfer> {
  List<transfer> datas =[];

  bool fetching =true;
  late Data db;
  @override
  void initState(){
    super.initState();
    db = Data();
    setState(() {
      getData();
    });

  }
  void getData ()async{
    datas = await db.GetTransferData();
    setState((){
      fetching =false;});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
        appBar: AppBar(title:
        Text("Transfer Tracker",style: TextStyle(color: Colors.blue[900],),),backgroundColor: Colors.yellow[200],),
      body: fetching ? CircularProgressIndicator() :Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: datas.length,
          itemBuilder: (context, index) {
          return Card(
            color: Colors.blue[900],
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row
                (
                children: [
                  Column(
                    children: [
                      Text("Amount"),
                      SizedBox(height: 20,),
                      Text("${datas[index].amount.toString()}"),
                    ],
                  ),
                  Spacer(),
                  Column(
                    children: [
                      Text("Sender ID"),
                      SizedBox(height: 20,),
                      Text(datas[index].sender.toString()),
                    ],
                  ),
                  Spacer(),
                  Column(
                    children: [
                      Text("Receiver ID"),
                      SizedBox(height: 20,),
                      Text(datas[index].receiver.toString()),
                    ],
                  ),
                ],
              ),
            ),
          );
        },),
      ),
    );
  }
}
