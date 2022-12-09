import 'package:gripbankingapp/transfers.dart';

class transfer {
  int?  id;
  int?  amount;
  int?  sender;
  int?  receiver;

 transfer({this.id ,this.amount,  this.sender,  this.receiver, });
  // to get data
  factory transfer.fromMap(Map<String,dynamic> json) => transfer(id : json["id"], amount: json["amount"],sender : json["sender"],receiver: json["receiver"]);
  Map<String,dynamic> toMap()=>
      {
        "id" : id,
        "amount" : amount,
        "sender" :  sender,
        "receiver" : receiver,

      };


}