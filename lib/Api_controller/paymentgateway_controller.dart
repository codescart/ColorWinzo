class paymentgateway {
  String? id;
  String? name;
  dynamic? disc;
  dynamic? image;
  String? status;


  paymentgateway({
    required this.id,
    required this.name,
    required this.disc,
    required this.image,
    required this.status,
  });
  factory paymentgateway.fromJson(Map<String, dynamic> json) {
    return paymentgateway(
      id: json["id"],
      name: json["name"],
      disc: json["disc"],
      image: json["image"],
      status: json["status"],
    );
  }
}