class Myrecord {
  String? id;
  String?userid;
  String? amount;
  String? totalamount;
  String? number;
  String? color;
  String? gamesno;
  String?commission;
  String? status;
  dynamic? win;
  String? datetime;

  Myrecord({
    required this.id,
    required this.userid,
    required this.amount,
    required this.totalamount,
    required this.number,
    required this.color,
    required this.gamesno,
    required this.commission,
    required this.status,
    required this.win,
    required this.datetime,
  });


  factory Myrecord.fromJson(Map<String, dynamic> json) {
    return Myrecord(
      id: json["id"],
      userid: json["userid"],
      amount: json["amount"],
      totalamount: json["totalamount"],
      number: json["number"],
      color: json["color"],
      gamesno: json["gamesno"],
      commission: json["commission"],
      status: json["status"],
      win: json["win"],
      datetime: json["datetime"],
    );
  }


}