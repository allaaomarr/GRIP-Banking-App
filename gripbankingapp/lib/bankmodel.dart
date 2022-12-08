class bank {
  int?  id;
  String?  name;
  int?  balance;
  String?  email ;

  bank({this.id ,this.name,  this.email, required this.balance, });
  // to get data
  factory bank.fromMap(Map<String,dynamic> json) => bank(id : json["id"], name: json["name"], email : json["email"], balance: json["balance"]);
  Map<String,dynamic> toMap()=>
      {
        "id" : id,
        "name" : name,
        "email" :  email,
        "balance" : balance,

      };


}