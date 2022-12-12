import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gripbankingapp/Controller/Controller_provider.dart';
import 'package:gripbankingapp/View/transfers.dart';
import 'package:provider/provider.dart';

import '../Controller/bankdb.dart';
import '../bankmodel.dart';
import 'customerprofile.dart';

class customerspage extends StatefulWidget {
  const customerspage({Key? key}) : super(key: key);

  @override
  State<customerspage> createState() => _customerspageState();
}

class _customerspageState extends State<customerspage> {
 // List<bank> datas = [];
late Data db;
  @override
  void initState() {
    super.initState();
    db = Data();
    Provider.of<Update>(context,listen: false).getData(db);
  }
/*
  void getData() async {
    datas = await db.GetCustomersData();
  /*  setState(() {
      fetching = false;
    });*/
    //Provider.of<Update>(context,listen: false).fetch(); /// PROVIDER
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(

          title: Text(
            "Customers",
            style: TextStyle(
              color: Colors.blue[900],
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.yellow[200],
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Transfer(),
                      ));
                },
                icon: Icon(Icons.compare_arrows_outlined,
                    color: Colors.blue[900], size: 30))
          ],
        leading: Icon(Icons.people_alt_outlined,color: Colors.blue[900],)  ),
      body: Provider.of<Update>(context).fetching /// PROVIDER
          ? CircularProgressIndicator()
          : Padding(
              padding: const EdgeInsets.all(10),
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {

      return Card(
        color: Colors.blue[900],
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                Provider.of<Update>(context,listen: false).
                datas[index].name!,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                Provider.of<Update>(context,listen: false).datas[index].email!,
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),

              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                customerprofile(
                                  name:
                                  Provider.of<Update>(context,listen: false).
                                  datas[index].name!,
                                  email:
                                  Provider.of<Update>(context,listen: false).
                                  datas[index].email!,
                                  balance: Provider.of<Update>(context,listen: false).
                                  datas[index].balance!,
                                  id: Provider.of<Update>(context,listen: false).
                                  datas[index].id!,
                                )));
                  },
                  child: Text("View Profile")),
            ],
          ),
        ),
      );
    },
              ),
            ),
    );
  }
}
