class CategoryModel {
  int? id;
  String? name;
  String? accountNumber;

  CategoryModel({
    this.id,
    this.name,
    this.accountNumber,
  });

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    accountNumber = json['account_number'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'accountNumber': accountNumber,
    };
  }
}
