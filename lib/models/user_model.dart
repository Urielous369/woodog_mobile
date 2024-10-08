class User {
  int? id;
  String? fullName;
  String? email;
  String? password;
  String? token;

  User({
    this.id,
    this.fullName,
    this.email,
    this.password,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        fullName: json["fullName"],
        email: json["email"],
        password: json["password"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
        "email": email,
        "password": password,
      };
}
