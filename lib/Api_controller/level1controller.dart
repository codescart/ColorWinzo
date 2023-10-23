class level1 {
  String? id;
  String? userId;
  String? amount;
  String? description;
  String? upi;
  String? mobile;
  String? accountId;
  String? status;
  String? date;
  String? time;


  level1({
    required this.id,
    required this.userId,
    required this.amount,
    required this.description,
    required this.upi,
    required this.mobile,
    required this.accountId,
    required this.status,
    required this.date,
    required this.time,
  });


  factory level1.fromJson(Map<String, dynamic> json) {
    return level1(
      id: json["id"],
      userId: json["user_id"],
      amount: json["amount"],
      description: json["description"],
      upi: json["upi"],
      mobile: json["mobile"],
      accountId: json["account_id"],
      status: json["status"],
      date: json["date"],
      time: json["time"],

    );
  }


}