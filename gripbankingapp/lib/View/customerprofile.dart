import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:gripbankingapp/View/transferprocess.dart';
import 'package:gripbankingapp/View/customerspage.dart';

import '../Controller/bankdb.dart';
import '../bankmodel.dart';

class customerprofile extends StatefulWidget {


     String? name = "guest" ;
        String? email  ;
        int? id;
        int? balance;
  @override
  State<customerprofile> createState() => _customerprofileState();
   customerprofile( { this.name,this.email,this.id,this.balance,});

}
List<bank> datas =[];
late Data db;

class _customerprofileState extends State<customerprofile> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:
      Text("Profile",style: TextStyle(color: Colors.blue[900],),),

          centerTitle: true,backgroundColor: Colors.yellow[200],  leading :InkWell(  onTap: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> customerspage()));
        },

          child: Icon(Icons.arrow_back),),  ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                 decoration: BoxDecoration(
                   color:Colors.blue[900],
                   borderRadius: BorderRadiusDirectional.circular(20),
                 ),
                height: 600,
                width: 500,
                 child: Column(
                   children: [
                     Padding(
                       padding: const EdgeInsets.all(50),
                       child: CircleAvatar(
                         backgroundColor: Colors.blue[900],
                         radius: 90,
                         backgroundImage: AssetImage("images/avatar.png"),

                       ),
                     ),
                     Text(widget.name!,style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.bold),),
                     Padding(
                       padding: const EdgeInsets.fromLTRB(150, 20, 100, 20),  
                       child: Row(
                         children: [

                           Text(widget.id.toString(),style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
                            Icon(Icons.perm_identity ,color: Colors.purple[100],),
                         ],
                       ),
                     ),
                        Padding(
                         padding: const EdgeInsets.fromLTRB(150, 20, 20, 20),
                       child:   Row(


                       children: [



                           Text(widget.balance.toString(),style: TextStyle(fontSize: 20,color: Colors.yellow[300],fontWeight: FontWeight.bold),),

                         Icon(Icons.attach_money,color: Colors.white,),
                       ],
                     ),
                        ),
                     Text(widget.email.toString(),style: TextStyle(fontSize: 20,color: Colors.green[300],fontWeight: FontWeight.bold),),

                     Padding(
                       padding: const EdgeInsets.all(20),
                       child: ElevatedButton(onPressed: (){

                         Navigator.push(context, MaterialPageRoute(builder: (context)=> TransferProcess(name: widget.name,id: widget.id,email: widget.email,balance: widget.balance,)));
                       }, child: Text("Transfer Money"),


                       ),
                     ),
                   ],
                 ),

              ),
            ),
          ),
        ),
      ),
    );
  }
}
