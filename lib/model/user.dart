import 'package:pfe_salim/model/enums/role.dart';

class User {
  int id;
  String email;
  String? plainPassword;
  String firstname;
  String lastname;
  String? imageFilename;
  List<Role> roles;

  User({
    this.id = -1,
    required this.email,
    this.plainPassword,
    required this.firstname,
    required this.lastname,
    this.imageFilename,
    this.roles = const [],
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      imageFilename: json['imageFilename'],
      roles: json['roles'] != null
          ? List<Role>.from(
              json['roles'].map((role) => parseRole(role)).toList(),
            )
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'plainPassword': plainPassword,
      'firstname': firstname,
      'lastname': lastname,
      'roles': roles.map((r) => r.value).toList(),
    };
  }
}
