class deposit_history {
  String? id;
  String? upiId;
  String? coupanCode;
  String? userId;
  String? amount;
  String? status;
  String? date;
  String? time;
  String? type;


  deposit_history({
    required this.id,
    required this.upiId,
    required this.coupanCode,
    required this.userId,
    required this.amount,
    required this.status,
    required this.date,
    required this.time,
    required this.type,
  });
  factory deposit_history.fromJson(Map<String, dynamic> json) {
    return deposit_history(
      id: json["id"],
      upiId: json["upi_id"],
      coupanCode: json["coupan_code"],
      userId: json["user_id"],
      amount: json["amount"],
      status: json["status"],
      date: json["date"],
      time: json["time"],
      type: json["type"],

    );
  }


}