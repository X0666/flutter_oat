class userModel {
  int? id;
  String? name;
  String? email;
  String? username;
  String? profilePhotoUrl;
  String? roles;
  String? token;

  userModel({
    this.id,
    this.name,
    this.email,
    this.username,
    this.profilePhotoUrl,
    this.roles,
    this.token,
  });

  userModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    username = json['username'];
    profilePhotoUrl = json['profile_photo_url'];
    roles = json['roles'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'username': username,
      'profile_photo_url': profilePhotoUrl,
      'roles': roles,
      'token': token,
    };
  }
}
