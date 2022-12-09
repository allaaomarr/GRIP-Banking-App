import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gripbankingapp/transfers.dart';


import 'bankdb.dart';
import 'bankmodel.dart';
import 'customerprofile.dart';

class customerspage extends StatefulWidget {
  const customerspage({Key? key}) : super(key: key);

  @override
  State<customerspage> createState() => _customerspageState();
}

class _customerspageState extends State<customerspage> {
 /* @override  void updateUi() {
    setState(() {});
  }*/
  List<bank> datas =[];

  bool fetching =true;
  late Data db;
  @override
  void initState(){
    super.initState();
    db = Data();
    db.AddDB();
   setState(() {
     getData();
   });




  }
  void getData ()async{
    datas = await db.GetCustomersData();
    setState((){
    //  datas;
      datas;
      fetching =false;});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title:
          Text("Customers",style: TextStyle(color: Colors.blue[900],),),

     centerTitle: true,backgroundColor: Colors.yellow[200], actions: [ IconButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> Transfer(),));}, icon: Icon(Icons.compare_arrows_outlined,color: Colors.blue[900],size:30))]),
       body: fetching?

     CircularProgressIndicator(): Padding(
       padding: const EdgeInsets.all(10),
       child: ListView.builder(
           itemCount: 9,
            itemBuilder: (context, index) {
              return Card(
                color: Colors.blue[900],
child: Padding(
  padding: const EdgeInsets.all(20),
  child:   Column(

    children: [

    Text(datas[index].name!,style: TextStyle(fontSize: 20,color: Colors.white),),
SizedBox(height: 10,),
        Text(datas[index].email!,style: TextStyle(color: Colors.green,fontSize: 15,fontWeight: FontWeight.bold),),

    Row(
        children: [

        //  Text(datas[index].balance.toString(),style: TextStyle(fontSize: 20,color: Colors.white),),
        //  Icon(Icons.attach_money_sharp,color: Colors.yellow,),
        ],
    ),

        TextButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => customerprofile(name :datas[index].name.toString(),email: datas[index].email.toString(),balance: datas[index].balance,id: datas[index].id,)));}, child: Text("View Profile")),



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
