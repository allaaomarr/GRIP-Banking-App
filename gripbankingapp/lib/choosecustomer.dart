import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gripbankingapp/customerprofile.dart';
import 'package:gripbankingapp/customerspage.dart';
import 'package:gripbankingapp/transfermodel.dart';
import 'package:provider/provider.dart';
import 'package:snack/snack.dart';

import 'Controller_provider.dart';
import 'bankdb.dart';
import 'bankmodel.dart';

class TransferProcess extends StatefulWidget {
  String? name = "guest";
  String? email;
  int? id;
  int? balance;

  @override
  State<TransferProcess> createState() => _TransferProcessState();
  TransferProcess({this.name, this.email, this.id, this.balance});
}

class _TransferProcessState extends State<TransferProcess> {
  var balance_controller = TextEditingController();
  var transferamount_controller = TextEditingController();
  final bar = SnackBar(
    content: Text('you donot have enough balance'),
  );
  final bar2 = SnackBar(
    content: Text('balance transfered successfully'),
  );
 // List<bank> datas = [];
  late Data db;
  @override
  void initState() {
    super.initState();
    db = Data();
    Provider.of<Update>(context,listen: false).getData(db);
  }

/*  void getData() async {
    datas = await db.GetCustomersData();
    Provider.of<Update>(context, listen: false).fetch();
  }*/

  @override
  Widget build(BuildContext context) {
    int total = (int.parse(widget.balance.toString()));
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              "Transfer To",
              style: TextStyle(
                color: Colors.blue[900],
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.yellow[200],
        leading: InkWell(
          onTap: ()  {
            Navigator.push(
                context,
                MaterialPageRoute(
                builder: (context) =>
          customerprofile(
                  id: widget.id,
                  name: widget.name,
                  email: widget.email,
                  balance: total),
            ),);
            //   Provider.of<Update>(context,listen: false).getData(db); /// PROVIDER
          },
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: Provider.of<Update>(context).fetching
          ? CircularProgressIndicator()
          : ListView.builder(
              itemCount: 9,
              itemBuilder: (context, index) {
                if (widget.id != Provider.of<Update>(context).
                datas[index].id) {
                  return Card(
                    color: Colors.blue[900],
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Text(
                            Provider.of<Update>(context).
                            datas[index].name!,
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            Provider.of<Update>(context).
                            datas[index].id.toString(),
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                              onPressed: () async {
                                edit(Provider.of<Update>(context,listen: false).
                                datas[index], index);
                              },
                              icon: Icon(
                                Icons.transfer_within_a_station,
                                color: Colors.yellowAccent,
                              )),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
    );
  }

  edit(bank item, int index) async {
    balance_controller.text = Provider.of<Update>(context,listen: false).datas[index].balance.toString();
    [
      transferamount_controller.text = "0",
    ];
    var alert = AlertDialog(
      backgroundColor: Colors.black,
      title: new Text(
        "Transfer",
        style: TextStyle(color: Colors.white),
      ),
      content: Column(
        children: <Widget>[
          new Expanded(
            child: new TextFormField(
              controller: transferamount_controller,
              keyboardType: TextInputType.number,
              autofocus: true,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.yellow,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: "Transfer Amount",
                  hintStyle: TextStyle(color: Colors.white)),
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
            if (int.parse(transferamount_controller.text) <=
                    int.parse(widget.balance.toString()) &&
                int.parse(widget.balance.toString()) > 0) {
              bank recieverbalance = bank.fromMap({
                "name": item.name,
                "balance": (int.parse(transferamount_controller.text)) +
                    (int.parse(balance_controller.text)),
                "id": item.id,
                "email": item.email,
              });
              await db.updateItem(recieverbalance);
              bank senderbalance = bank.fromMap({
                "name": widget.name,
                "balance": (int.parse(widget.balance.toString())) -
                    (int.parse(transferamount_controller.text)),
                "id": widget.id,
                "email": widget.email,
              });
              await db.updateItem(senderbalance);
              db.TransferDB(transfer(
                  amount: int.parse(transferamount_controller.text),
                  sender: int.parse(widget.id.toString()),
                  receiver: item.id));

              bar2.show(context);
            } else {
              bar.show(context);
            }
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => customerprofile(
                  id: widget.id,
                  name: widget.name,
                  email: widget.email,
                  balance: (int.parse(widget.balance.toString())) -
                      (int.parse(transferamount_controller.text)),
                ),
              ),
            );
            /*     await Get.to(
              () => customerprofile(
                id: widget.id,
                name: widget.name,
                email: widget.email,
                balance: (int.parse(widget.balance.toString())) -
                    (int.parse(transferamount_controller.text)),
              ),
            );*/
          },
          child: new Text(
            "Transfer",
            style: TextStyle(color: Colors.blue[900]),
          ),
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
