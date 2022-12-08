import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gripbankingapp/customerprofile.dart';
import 'package:gripbankingapp/customerspage.dart';
import 'package:gripbankingapp/transfermodel.dart';
import 'package:snack/snack.dart';


import 'bankdb.dart';
import 'bankmodel.dart';

class TransferProcess extends StatefulWidget {
  String? name = "guest" ;
  String? email  ;
  int? id;
  int? balance;

  @override
  State<TransferProcess> createState() => _TransferProcessState();
  TransferProcess( { this.name,this.email,this.id,this.balance});
}

class _TransferProcessState extends State<TransferProcess> {
  @override  void updateUi() {
    setState(() {});
  }
  List<bank> datas =[];
 var balance_controller =TextEditingController();
 var transferamount_controller = TextEditingController();
  final bar = SnackBar(content: Text('you donot have enough balance'),);
  final bar2 = SnackBar(content: Text('balance transfered successfully'),);
  bool fetching =true;
  late Data db;

  @override
  void initState(){
    super.initState();
    db = Data();

    db.AddDB();
    getData();



  }
  void getData ()async{
    datas = await db.GetCustomersData();
    setState((){
      fetching =false;});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Row(
        children: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> customerprofile(updateUi: updateUi, name: widget.name,email: widget.email,id: widget.id,balance:(int.parse(widget.balance.toString())) -
                (int.parse(transferamount_controller.text)),),));
          }, icon: Icon(Icons.arrow_back)),
          Text("Transfer To",style: TextStyle(color: Colors.blue[900],),),
        ],
      ),centerTitle: true,backgroundColor: Colors.yellow[200],),
      body: fetching?

      CircularProgressIndicator(): ListView.builder(
        itemCount: 9,
        itemBuilder: (context, index) {

          if(widget.id != datas[index].id) {
            return
              Card(
color: Colors.blue[900],
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(datas[index].name!,style: TextStyle(fontSize: 20,color: Colors.white),),
                      SizedBox(height: 10,),
                      Text(datas[index].id.toString(),style: TextStyle(color: Colors.green,fontSize: 15,fontWeight: FontWeight.bold),),
                      IconButton(onPressed: () {
                        edit(datas[index], index);
                      }, icon: Icon(Icons.transfer_within_a_station,color: Colors.yellowAccent,)),

                    ],
                  ),
                ),
              );
          }
        else  {
          return Container();
        }

        },

      ),

    );
  }
  edit(bank item, int index) {
    balance_controller.text = datas[index].balance.toString();

    var alert = AlertDialog(
      backgroundColor: Colors.black,
      title: new Text("Transfer",style: TextStyle(color: Colors.white),),
      content: Column(
        children: <Widget>[

          new Expanded(
            child: new TextFormField(
              controller: transferamount_controller,
              keyboardType: TextInputType.number,
              autofocus: true,
              decoration: InputDecoration(

                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.yellow,),
                  borderRadius:BorderRadius.circular(20),
                ),
                hintText: "Transfer Amount",
                hintStyle: TextStyle(color: Colors.white)

              ),
            ),
          ),

        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(

            primary: Colors.yellow[200],
          ),
          onPressed: () async {
            if(int.parse(transferamount_controller.text) <= int.parse( widget.balance.toString()) && int.parse( widget.balance.toString()) > 0) {
              bank recieverbalance = bank.fromMap({
                "name": item.name,
                "balance": (int.parse(transferamount_controller.text)) +
                    (int.parse(balance_controller.text)),
                "id": item.id,
                "email": item.email,
              });
              await db.updateItem(recieverbalance);
              setState(() {
                getData();
              });
              //redrawing scree
              bank senderbalance = bank.fromMap({
                "name": widget.name,
                "balance": (int.parse(widget.balance.toString())) -
                    (int.parse(transferamount_controller.text)),
                "id": widget.id,
                "email": widget.email,
              });
              await db.updateItem(senderbalance);
              db.TransferDB(transfer(amount:int.parse( transferamount_controller.text),sender:int.parse( widget.id.toString()),receiver: item.id));
              setState(() {

              });
              bar2.show(context);
            }
            else {
bar.show(context);
            }


            Navigator.pop(context);
          },
          child: new Text("Transfer",style: TextStyle(color: Colors.blue[900]),),
        ),
        new ElevatedButton(
          style: ElevatedButton.styleFrom(

            primary: Colors.blue[900],
          ),
          onPressed: () => Navigator.pop(context),
          child: new Text("Cancel"),
        ),
      ],
    );
    showDialog(
        context: context,
        builder: (context) {
          return alert;
        });
  }
}

