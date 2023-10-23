class partlyrecord {
  String? id;
  String? number;
  String? colour;
  String? gamesno;
  String? price;
  String? status;
  String? datetime;

  partlyrecord({
    required this.id,
    required this.number,
    required this.colour,
    required this.gamesno,
    required this.price,
    required this.status,
    required this.datetime,
  });
  factory partlyrecord.fromJson(Map<String, dynamic> json) {
    return partlyrecord(
      id: json["id"],
      number: json["number"],
      colour: json["colour"],
      gamesno: json["gamesno"],
      price: json["price"],
      status: json["status"],
      datetime: json["datetime"],
    );
  }
}