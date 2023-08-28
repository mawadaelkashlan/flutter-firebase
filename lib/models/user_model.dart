class UserModel {
 final String name;
 final String email;
 final String phone;
 final String uId;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.uId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
        uId: json['uId'],
      );

  Map<String, dynamic> toMap (){
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
    };
  }
}
