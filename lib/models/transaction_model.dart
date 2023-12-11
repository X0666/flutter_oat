class TransactionModel {
  int? usersId;
  String? address;
  int? totalPrice;
  int? shippingPrice;
  String? status;
  String? updatedAt;
  String? createdAt;
  int? id;

  TransactionModel(
      {this.usersId,
      this.address,
      this.totalPrice,
      this.shippingPrice,
      this.status,
      this.updatedAt,
      this.createdAt,
      this.id});

  TransactionModel.fromJson(Map<String, dynamic> json) {
    usersId = json['users_id'];
    address = json['address'];
    totalPrice = json['total_price'];
    shippingPrice = json['shipping_price'];
    status = json['status'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['users_id'] = this.usersId;
    data['address'] = this.address;
    data['total_price'] = this.totalPrice;
    data['shipping_price'] = this.shippingPrice;
    data['status'] = this.status;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
