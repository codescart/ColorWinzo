class level3 {
  String? id;
  String? userid;
  dynamic? level1;
  dynamic? level2;
  String? Level3;
  String? amount;
  String? status;
  String? datetime;
  String? username;
  dynamic? userimg;


  level3({
    required this.id,
    required this.userid,
    required this.level1,
    required this.level2,
    required this.Level3,
    required this.amount,
    required this.status,
    required this.datetime,
    required this.username,
    required this.userimg,
  });


  factory level3.fromJson(Map<String, dynamic> json) {
    return level3(
      id: json["id"],
      userid: json["userid"],
      level1: json["level1"],
      level2: json["level2"],
      Level3: json["level3"],
      amount: json["amount"],
      status: json["status"],
      datetime: json["datetime"],
      username: json["username"],
      userimg: json["userimg"],

    );
  }


}